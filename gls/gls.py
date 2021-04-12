# Import python libraries
import argparse, binascii, csv, glob, os, re, string, subprocess
from defines import *


# Get active PE tiles from bitstream and write to file
def get_active_pes(bsfile):
    bsname = bsfile[:-4] # remove the file extension
    with open(bsfile) as inf, open(f'{bsname}.tiles', 'w') as outf:
        for line in inf.readlines():
            if line[:2] == 'FF':
                peid = line[4:8]
                outf.write(peid + '\n')


# Commands to generate raw commands
def generate_raw(app, tile):
    # Convert signals to flags
    input_signals = ' '.join([f'-signal {scope}.{tile}.{i}' for i in inputs])
    output_signals = ' '.join([f'-signal {scope}.{tile}.{o}' for o in outputs])

    # Convert flag list to argument string
    flags = [
        "-overwrite",
        "-xsub 0",
        "-timeunits ps",
        "-radix hex",
        "-64bit",
        "-notime",
        f"-expression \"{scope}.clk == 1'b1\"", # take signals when clock is high
    ]
    flag_string = ' '.join(flags)

    # Convert VCD to SST2 (if files do not exist already)
    if not os.path.exists(f'{app}.trn'):
        os.system(f'simvisdbutil inputs/{app}.vcd -sst2')
    if not os.path.exists(f'outputs/raw_input_{app}_{tile}.csv'):
        os.system(f'simvisdbutil {app}.trn {input_signals} -output outputs/raw_input_{app}_{tile}.csv {flag_string}')
    if not os.path.exists(f'outputs/raw_output_{app}_{tile}.csv'):
        os.system(f'simvisdbutil {app}.trn {output_signals} -output outputs/raw_output_{app}_{tile}.csv {flag_string}')


# Convert raw signals CSV file to test vector file
def convert_raw(signals, input_file, output_file):
    # Pattern for recognizing vector size (dim)
    dim_pattern = re.compile("\w*\[(\d+):0\]")

    # Open input/output files
    rawfile = open(input_file, "r")
    outfile = open(output_file, "w")

    # Read in CSV file
    data = list(csv.reader(rawfile, delimiter=','))
    headers = data[0]

    # Create mappings from name to width and column index
    widths = {}
    col = {}
    for i, h in enumerate(headers):
        # Take signal name without prefix
        name = h.split('.')[-1]

        # If bit width specified
        try:
            # Get name, width from regex
            width = int(dim_pattern.match(name).groups()[0]) + 1
            name = name.replace(f'[{width-1}:0]', '')
            widths[name] = width
        # If no bit width specified, set to 1
        except:
            widths[name] = 1

        # Mapping of name to column index
        col[name] = i

    # Start with two 0000 vectors for all signals
    #outfile.write(('_'.join(['0000']*len(signals))+'\n'))

    # Generate vector form
    for c in range(1,len(data)):
        to_write = []
        # Split by signal
        for s in signals:
            value = data[c][col[s]]

            # Append leading zeros to pad up to 16 bits (4 hex digits)
            while len(value) % 4 != 0:
                value = "0"+value

            # Put value in
            term = []
            for i in range(int((len(value) - 1) / 4) + 1):
                partial_value = value[i*4:min((i+1)*4, len(value)+1)]
                term.append(partial_value)
            term.reverse()
            for t in term:
                to_write.append(t)
        to_write.reverse()

        # Separate by underscores to represent different signals
        outfile.write('_'.join(to_write)+'\n')
             
    # Close files
    outfile.close()
    rawfile.close()
    
    # Return number of test vectors and width of each one
    num_test_vectors = len(data) - 1
    return num_test_vectors, widths


# Generates the testbench SystemVerilog file
def create_testbench(app, inputs, outputs, input_widths, output_widths, num_test_vectors, active_cycle_number):
    # Start from 0 and define input slices
    input_slices, input_base = '', 0
    for i in inputs:
        input_slices += f'`define SLICE_{i.upper()} {input_widths[i]-1+input_base}:{input_base}\n'
        input_base += input_widths[i]
        if input_widths[i] % 16 != 0:
            input_base += (16 - input_widths[i] % 16)
    input_slices = input_slices.strip()

    # Start from 0 and define output slices
    output_slices, output_base = '', 0
    for o in outputs:
        output_slices += f'`define SLICE_{o.upper()} {output_widths[o]-1+output_base}:{output_base}\n'
        output_base += output_widths[o]
        if output_widths[o] % 16 != 0:
            output_base += (16 - output_widths[o] % 16)
    output_slices = output_slices.strip()

    # Input wires
    input_wires = ''
    for i in inputs:
        if 'reset' not in i:
            input_wires += f'    wire [{input_widths[i]-1}:0] {i} = test_vectors[test_vector_addr][`SLICE_{i.upper()}];\n'
        else:
            input_wires += f'    wire {i} = test_vectors[test_vector_addr][`SLICE_{i.upper()}];\n'
    input_wires = input_wires.strip()
    
    # Output wires
    output_wires = ''
    for o in outputs:
        output_wires += f'    wire [{output_widths[o]-1}:0] {o};\n'
    output_wires = output_wires.strip()

    # Power supplies if power aware gates present
    pwr_supplies = '''supply1 VDD;
    supply0 VSS;
    ''' if pwr_aware else ''

    # DUT I/O and PG pins
    dut_io = ''
    for i in inputs+outputs:
        dut_io += f'        .{i}({i}),\n' # DUT I/O
    if pwr_aware:
        dut_io += '''        .VDD(VDD),
        .VSS(VSS),\n'''
    dut_io = dut_io.strip()

    # Output checks
    output_checks = ''
    for o in outputs:
        output_checks += f'''
        if ({o} != test_outputs[test_vector_addr][`SLICE_{o.upper()}] || ($isunknown({o}) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: {o}: got %x, expected %x", test_vector_addr, {o}, test_outputs[test_vector_addr][`SLICE_{o.upper()}]);
        end\n'''
    output_checks = output_checks.strip()

    # Template substitution for testbench
    template = string.Template(open('templates/testbench.sv.tmpl').read())
    output = template.substitute(**{**locals(), **globals()})
    open('testbench.sv', 'w').write(output)

    # Run VCS to create simv executable
    vcs_cmd = [
        "vcs",
        "-sverilog",
        "-debug",
        "+vcs+dumpvars+outputs/out.vcd",
        "+vcs+initreg+random",
        "+neg_tchk",
        "testbench.sv",
        design_file,
        stdcell_file,
        nems_file,
    ]
    os.system(" ".join(vcs_cmd))


# Run the testbenches that are created
def run_testbench(app, tile, input_file, output_file, simout_file):
    # Copy input vectors and output vectors to inputs/
    subprocess.run(["cp", "-f", input_file, "inputs/test_vectors.txt"])
    subprocess.run(["cp", "-f", output_file, "inputs/test_outputs.txt"])

    # Run the simulation, print output and write to file
    simout = subprocess.check_output(["./simv", "+vcs+initreg+0"])
    print(simout.decode('utf-8'))
    open(simout_file, 'wb').write(simout)

    # Rename the output
    subprocess.run(["mv", "outputs/out.vcd", f"outputs/{app}_{tile}.vcd"])
    subprocess.run(["mv", "outputs/out.saif", f"outputs/{app}_{tile}.saif"])


# Merge saifs of all active tiles
def merge_saif(app):
    # Generate command
    app_saifs = glob.glob(f"outputs/{app}_pe_*.saif")
    input_list = " ".join([f"-input {saif} -weight {100 / len(app_saifs)}" for saif in app_saifs])
    prefix = f"set power_enable_analysis true; read_verilog {design_file}; set target_library [list {stdcell_file[:-2]}.db  {nems_file[:-2]}.db]; set link_path \"* $target_library\"; current_design {tile_module}"
    cmd = ["pt_shell", "-x", f"{prefix}; merge_saif -input_list \"{input_list}\" -simple_merge -strip_path testbench/dut -output outputs/{app}.saif; report_disable_timing; quit"]
    print(" ".join(cmd))
    ptout = subprocess.check_output(cmd)
    print(ptout.decode('utf-8'))

    # Write output to log file
    open('merge_saif.log', 'ab').write(ptout)


# Process each tile
def main():
    # Parse arguments
    parser = argparse.ArgumentParser(description="Run gate-level simulation for CGRA: verification and power estimation")
    parser.add_argument('app', help="Name of CGRA application to test", type=str)
    parser.add_argument('-acn', '--active_cycle_number', help="Number of cycles after which to measure toggling activity, typically after CGRA configuration", required=False, type=int, default=None)
    parser.add_argument('-acf', '--app_clk_factor', help="How much slower should timing be for this app", required=False, type=float, default=None)
    parser.add_argument('--merge-saif-only', help="Only do the merge SAIF step", required=False, action='store_true')
    args = parser.parse_args()

    # Load app and active cycle number
    try:
        app, active_cycle_number = args.app, args.active_cycle_number if args.active_cycle_number is not None else app_active_cycle_numbers[args.app]
    except KeyError:
        sys.exit("Must specify app's active_cycle_number if it is not in defines.py dict!")

    # Adjust clock period using app's clock factor
    try:
        global clock_period
        clock_period *= args.app_clk_factor if args.app_clk_factor is not None else app_clk_factors[args.app]
    except KeyError:
        pass
    print("Clock period used:", clock_period)

    # If requested to merge saif only
    if args.merge_saif_only:
        merge_saif(app)
        exit(0)

    # Create output directory
    if not os.path.exists('outputs'):
        os.makedirs('outputs')

    # Extract active PEs from app bitstream
    print("Extracting active PEs from app bitsream...")
    get_active_pes(f"inputs/{app}.bsa")

    # Open tiles
    print("Converting tiles to vectors...")
    for i, line in enumerate(open(f'inputs/{app}.tiles', 'r')):
        # Get full tile name
        tile = pe_prefix + line.strip()
        print(f"Processing {tile}...")

        # Generate raw input/output CSVs
        generate_raw(app, tile)

        # Convert raw input/output CSVs to test vectors (if files do not already exist)
        if not os.path.exists(f"outputs/test_vectors_{app}_{tile}.txt") or i == 0:
            num_test_vectors, input_widths = convert_raw(inputs, f"outputs/raw_input_{app}_{tile}.csv", f"outputs/test_vectors_{app}_{tile}.txt")
        if not os.path.exists(f"outputs/test_outputs_{app}_{tile}.txt") or i == 0:
            _, output_widths = convert_raw(outputs, f"outputs/raw_output_{app}_{tile}.csv", f"outputs/test_outputs_{app}_{tile}.txt")
    
    # Create testbench
    print("Creating testbench...")
    create_testbench(app, inputs, outputs, input_widths, output_widths, num_test_vectors, active_cycle_number)

    # Run testbench
    print("Running testbench...")
    for i, line in enumerate(open(f'inputs/{app}.tiles', 'r')):
        # Get full tile name
        tile = pe_prefix + line.strip()
        print(f"Processing {tile}...")

        # Run the testbench
        run_testbench(app, tile, f"outputs/test_vectors_{app}_{tile}.txt", f"outputs/test_outputs_{app}_{tile}.txt", f"outputs/{app}_{tile}_results.txt")

    # Merge saifs
    print("Merging saifs...")
    merge_saif(app)

    # DONE!
    print("DONE!")


# Run main if called from command line
if __name__ == '__main__':
    main()
