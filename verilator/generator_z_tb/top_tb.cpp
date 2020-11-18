// #define INWIRE  top->wire_0_0_BUS16_S1_T0

//// #define OUTWIRE top->wire_1_0_BUS16_S1_T0
// #define OUTWIRE  top->wire_1_2_BUS16_S3_T0

/// module tb();

#include "Vtop.h"
#include "verilated.h"

// If trace requested, verilator will set VM_TRACE to 1, else 0
#if VM_TRACE > 0
#include "verilated_vcd_c.h"
#define CLOSETRACE if (trace_filename != NULL) { tfp->close(); }
#else
#define CLOSETRACE
#endif

void write_output(
                  FILE *output_file,
                  unsigned int pads_in,
                  unsigned int pads_out,
                  char *what_i_did,
                  int print_result);

int main(int argc, char **argv, char **env) {
    char *config_filename = NULL;
    char  *input_filename = NULL;
    char *output_filename = NULL;
    char  *trace_filename = NULL;
    char *outbit_filename = NULL; // eg "onebit_bool.raw"
    char *outbit_padname  = NULL; // eg "s1t0" => pad_S1_T0

    char default_trace_filename[128] = "top_tb.vcd";

    FILE *input_file = NULL;
    FILE *output_file = NULL;
    FILE *outbit_file = NULL; // eg "onebit_bool.raw"

    // Run simulation for NCLOCKS clock periods (default = 40)
    int NCLOCKS = 40;

    Verilated::debug(1);

    printf("\n\nHi there!  I am the simulatory thingy.\n");
    fflush(stdout);

    // printf("    arg0 is maybe %s\n", argv[0]);  // "obj_dir/Vtop"
    // printf("    arg1 is maybe %s\n", argv[1]);  // "-config"
    // printf("    arg2 is maybe %s\n", argv[2]);  // "../../hardware/generator_z/top_tb/tile_config.dat"
    // printf("\n");

    int delay_in = 0;  // How long to wait before sending output
    int delay_out = 0; // How long to wait before  ending output

    int initial_delay_so_far = 0;
    int final_delay_so_far = 0;

    int ntimes_printed = 0;

    for (int i=1; i< argc; i++) {
        // printf("    arg%d is maybe %s\n", i, argv[i]);
        if      (! strcmp(argv[i], "-config"))  { config_filename = argv[++i]; }
        else if (! strcmp(argv[i], "-input" ))  { input_filename  = argv[++i]; }
        else if (! strcmp(argv[i], "-output" )) { output_filename = argv[++i]; }
        else if (! strcmp(argv[i], "-out1" )) {
            // eg "--out1 s1t0 onebit_bool.raw"
            outbit_padname  = argv[++i];
            outbit_filename = argv[++i];
        }
        else if (! strcmp(argv[i], "-trace" ))  { trace_filename  = argv[++i]; }
        else if (! strcmp(argv[i], "-nclocks")) { 
                sscanf(argv[++i], "%d", &NCLOCKS);
        }
        else if (! strcmp(argv[i], "-delay")) { 
            sscanf(argv[++i], "%d,%d", &delay_in, &delay_out);
        }
        else if (! strcmp(argv[i], "--help" )) {
            fprintf(stderr, "Usage: %s\n%s%s%s%s%s%s\n",
                    argv[0],
                    "  -config <config_filename>\n",
                    "  -input  <input_filename>\n",
                    "  -output <output_filename>\n",
                    "  -out1 s1t0 <1bitout_filename>\n",
                    "  [-trace <trace_filename>]\n",
                    "  -nclocks <max_ncycles e.g. '100K' or '5M' or '3576602'>\n"
                    );
        }
    }

    printf("  - Will run for %d cycles or until eof(input)\n", NCLOCKS);
    printf("  - Found config filename '%s'\n", config_filename);

    if (input_filename == NULL) {
        printf("\n");
        printf("WARNING No input file specified. I will generate random numbers instead of input.\n");
    }
    else {
        printf("  - Found input filename '%s'\n", input_filename);

        input_file = fopen(input_filename, "r");
        if (input_file == NULL) {
            fflush(stdout);
            fprintf(stderr,"\n\nERROR: Could not open input file '%s'\n\n", input_filename);
            exit(-1);
        }
    }

    if (output_filename == NULL) {
        printf("\n");
        printf("WARNING No output file specified. I will write debug info only.\n");
    }
    else {
        printf("  - Found output filename '%s'\n", output_filename);

        output_file = fopen(output_filename, "w");
        if (output_file == NULL) {
            fflush(stdout);
            fprintf(stderr,"\n\nERROR: Could not create output file '%s'\n\n", output_filename);
            exit(-1);
        }
    }
    if (outbit_filename != NULL) {
        printf("  - Found filename for onebit output '%s'\n", outbit_filename);
        printf("  - '%s' will contain output from pad '%s'\n", outbit_filename, outbit_padname);
        if (strcmp(outbit_padname, "s1t0") != 0) {
            printf("\n\nERROR haha for now can only output from pad 's1t0' sorry!\n\n");
            exit(13);
        }
        outbit_file = fopen(outbit_filename, "w");
        if (outbit_file == NULL) {
            fflush(stdout);
            fprintf(stderr,"\n\nERROR: Could not create onebit output file '%s'\n\n", outbit_filename);
            exit(13);
        }
    }

#if VM_TRACE > 0
    if (trace_filename == NULL) {
        printf("\n");
        // trace_filename = "top_tb.vcd";
        trace_filename = default_trace_filename;
        printf("WARNING No trace file specified. I am using default '%s'\n", trace_filename);
    }
    else {
        printf("  - Found trace filename '%s' for output waveforms\n", trace_filename);
    }
#else
    printf("NOTE no trace file was requested.\n");
#endif


//    if (delay_in)  { printf("NOTE REQUESTED OUTPUT SEND DELAY OF %d CYCLES\n", delay_in); }
//    if (delay_out) { printf("NOTE REQUESTED OUTPUT  END DELAY OF %d CYCLES\n", delay_out); }
    if (1) { printf("NOTE REQUESTED OUTPUT SEND DELAY OF %d CYCLES\n", delay_in); }
    if (1) { printf("NOTE REQUESTED OUTPUT  END DELAY OF %d CYCLES\n", delay_out); }
    printf("\n");

    /////////////////////////////////////////////////////////
    // Clock and reset
    /////////////////////////////////////////////////////////
    ///
    ///    reg clk;
    ///    reg [3:0] reset_count;
    ///    wire reset;
    
    int clk;
    int reset_count;
    int reset;

    Verilated::commandArgs(argc, argv);
    Vtop* top = new Vtop;

#if VM_TRACE > 0
    // Prepare to build waveform file
    // Verilated::commandArgs(argc, argv); // ?
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    if (trace_filename != NULL) {
        top->trace(tfp, 99); // What is 99?  I don't know!  FIXME
        tfp->open(trace_filename);
    }
#endif

    ///    initial begin
    ///      clk<=1'b1;
    ///      reset_count<=4'd0;
    ///    end

    clk = 1;
    reset = 1;
    reset_count = 0;

    /////////////////////////////////////////////////////////
    // Tile configuration init BEGIN
    ///
    ///    integer    config_data_file    ; // file handler
    ///    reg [31:0] config_addr_i;
    ///    reg [31:0] config_data_i;
    ///    reg [31:0] config_addr;
    ///    reg [31:0] config_data;
    ///    reg tile_config_done;

    FILE *config_data_file; // file handler

    unsigned int config_addr_i;
    unsigned int config_data_i;

    unsigned int config_addr;
    unsigned int config_data;

    unsigned int pads_in;  // 16-bit  input value
    unsigned int pads_out; // 16-bit output value
    unsigned int outbit;   //  1-bit output value

    int tile_config_done;

    ///    initial begin
    ///      config_addr_i <= 0;
    ///      config_data_i <= 0;
    ///      config_addr <= 0;
    ///      config_data <= 0;
    ///      tile_config_done <= 0;
    ///    end

    config_addr_i = 0;
    config_data_i = 0;

    config_addr = 0;
    config_data = 0;

    tile_config_done = 0;

    ///    `define NULL 0
    ///    initial begin
    ///      config_data_file = $fopen("tile_config.dat", "r");
    ///      if (config_data_file == `NULL) begin
    ///        $display("config_data_file handle was NULL");
    ///        $finish;
    ///      end
    ///    end

    config_data_file = fopen(config_filename, "r");

    if (config_data_file == NULL) {
        fprintf(stderr,"\n\nERROR: Could not open config file '%s'\n\n", config_filename);
        exit(-1);
    }

    // Tile configuration init END
    /////////////////////////////////////////////////////////
    ///    always #0.625 clk <= ~clk;

    int nprints = 0;

//    // First config addr/data should be stable well before reset goes low...
//    fscanf(config_data_file, "%x %x", &config_addr_i, &config_data_i);
//    config_addr = config_addr_i;
//    config_data = config_data_i;

    for (int i=0; i<NCLOCKS; i++) {
        // travis freaks out if no output for 10 minutes...
        // if ( (i%100000) == 0) {
        //     if (i==100000) printf("Executed %dK cycles...", i/1000);
        //     else if (i>0)  printf("%dK...", i/1000);
        //     fflush(stdout);
        // }
        //if ( (i%100000) == 0 ) { NOT ENOUGH for 16x16 maybe...
        //if ( (i%1000) == 0 ) {
        if ( (i%5000) == 0 ) {
            printf("Executed %dK cycles...\n", i/1000); fflush(stdout);
        }

        char what_i_did[256] = "";
        // sprintf(what_i_did, "");

        // @posedge events go here.

        ///    always @(posedge clk) begin
        ///      if (!(&reset_count)) begin 
        ///        reset_count <= reset_count + 1;  // Remember this is four bits!
        ///      end
        ///    end
        ///    assign reset = !reset_count[3];
    
//        if (i>4) { reset = 0; } else { sprintf(what_i_did, "reset=1"); }
//        if (i==4) { sprintf(what_i_did, "reset=0\n"); }

        // for (clk=0; clk<2; clk++) {
        // FIXME my clumsy way of making output happen on negedge(clk)
        // instead of posedge.  The fix of course is to CLEAN UP THIS WHOLE FILE
        for (clk=1; clk>=0; clk--) {

#if VM_TRACE > 0
            // dump variables into VCD file
            //tfp->dump (2*i+clk);
            // timestamp must STRICTLY INCREASE over time
            tfp->dump(2*i+(1-clk));
#endif
            if (clk==0) {
                // Note "clk==0" makes reset go low on negedge of clock
                // Note2 seems to work either way
                if (i>4) { reset = 0; } else { sprintf(what_i_did, "reset=1"); }
                if (i==4) { sprintf(what_i_did, "reset=0\n"); }
            }

            //printf("CyNum-rst-clk %05d %d %d, ", i, reset, clk);
            // char prefix[256];
            // sprintf(prefix, "cy.clk %05d.%d R%d: ", i, clk, reset);
            // printf("cy.clk %05d.%d R%d: ", i, clk, reset);
            // top->clk = !top->clk;
            // printf("Sim-cycle.clock %03d.%d, ", i, clk);

            // FIXME (below) why not "if (!reset && !tile_config_done)" instead?

            /////////////////////////////////////////////////////////
            // if (!reset &&  clk) { // posedge BAD
            // if (!reset && !clk) { // negedge GOOD
            // OOPS should be
            if (!reset && !clk && !tile_config_done) { // negedge GOOD

                // TILE CONFIGURATION - Change config data "on posedge"
                // E.g. set config when clk==0, after posedge event processed

                fscanf(config_data_file, "%x %x", &config_addr_i, &config_data_i);
                if (!feof(config_data_file)) {
                    // printf("scanned config data %08X %08X\n", config_addr_i, config_data_i);
                    sprintf(what_i_did, "scanned config data %08X %08X", config_addr_i, config_data_i);


                    // In the future, addresses will come in looking like this:
                    // TTTTFFRR
                    // and we will need to rearrange them to look like
                    // RRFFTTTT


                    config_addr = config_addr_i;
                    config_data = config_data_i;
                } else {
                    tile_config_done = 1;
                }
            } // (!reset && !clk)

            //if (!reset && tile_config_done && clk) { // posedge
            //    // READ INPUT DATA - Change input data "on posedge"
            //    // E.g. set config when clk==1, after posedge event processed

            if (!reset && !clk && tile_config_done) { // negedge
                // READ INPUT DATA - Change input data "on negedge"
                // E.g. set config when clk==0, after negedge event processed

                pads_in = (unsigned int)fgetc(input_file);
                // printf("Scanned input data %04x\n", pads_in);

                if (feof(input_file)) {
                    if (final_delay_so_far == delay_out) {
                        printf("\nINFO Simulation ran for %d cycles (349)\n\n", i);
                        if (input_file)       { fclose(input_file ); }
                        if (output_file)      { fclose(output_file); }
                        if (outbit_file)      { fclose(outbit_file); }
                        if (config_data_file) { fclose(config_data_file); }
                        CLOSETRACE // YES!
                        exit(0);
                    } // (input_filename == NULL) {} else {
                    else {
                        if (final_delay_so_far == 0) { printf("\n"); }
                        printf("One more (333): delay_out=%d, final_delay_so_far=%d; ",
                               delay_out, final_delay_so_far);
                        pads_in = 0;
                        // final_delay_so_far++; // This happens later, see below.
                    }
                }

            } // (!reset && tile_config_done && !clk)

            // Tile configuration END
            /////////////////////////////////////////////////////////

            /////////////////////////////////////////////////////////
            // DUT instantiation
            /////////////////////////////////////////////////////////

            // // These happen on EVERY clock edge, pos and neg
            // top->clk = clk;
            // top->reset = reset;
            // top->config_addr = config_addr;
            // top->config_data = config_data;

            // nbdev2 changed some names :(
            // These happen on EVERY clock edge, pos and neg
            top->clk_in = clk;
            top->reset_in = reset;
            top->config_addr_in = config_addr;
            top->config_data_in = config_data;

            //            top->pad_S3_T0 = clk;
            //            top->pad_S0_T0 = clk;



            ///////////////////////////////////////////////////////////////////
            // When/if inouts ever work:
            // For 16x16 grid, input byte should show up in tile pe_0x15 side 2
            // (only sides 2 and 1 connect to ALU inputs :( )
            // top->pad_S2_T8  = (pads_in & 0x80) ? 1 : 0;
            // top->pad_S2_T9  = (pads_in & 0x40) ? 1 : 0;
            // top->pad_S2_T10 = (pads_in & 0x20) ? 1 : 0;
            // top->pad_S2_T11 = (pads_in & 0x10) ? 1 : 0;
            // top->pad_S2_T12 = (pads_in & 0x08) ? 1 : 0;
            // top->pad_S2_T13 = (pads_in & 0x04) ? 1 : 0;
            // top->pad_S2_T14 = (pads_in & 0x02) ? 1 : 0;
            // top->pad_S2_T15 = (pads_in & 0x01) ? 1 : 0;

            // While inouts are busted:
            // For 16x16 grid, input byte should show up in tile pe_0x15 side 2
            // (only sides 2 and 1 connect to ALU inputs :( )
            top->pad_S2_T8_in  = (pads_in & 0x80) ? 1 : 0;
            top->pad_S2_T9_in  = (pads_in & 0x40) ? 1 : 0;
            top->pad_S2_T10_in = (pads_in & 0x20) ? 1 : 0;
            top->pad_S2_T11_in = (pads_in & 0x10) ? 1 : 0;
            top->pad_S2_T12_in = (pads_in & 0x08) ? 1 : 0;
            top->pad_S2_T13_in = (pads_in & 0x04) ? 1 : 0;
            top->pad_S2_T14_in = (pads_in & 0x02) ? 1 : 0;
            top->pad_S2_T15_in = (pads_in & 0x01) ? 1 : 0;
            ///////////////////////////////////////////////////////////////////



            ///always @(posedge clk) begin
            ///   $display ("%h + %h + %h + %h = %h (%h)", pads_in, in_0_1, in_1_0,
            ///   in_1_1, dut.wire_0_1_BUS16_S0_T4 ,pads_in+in_0_1+in_1_0+in_1_1);
            // printf("  top:clk,reset = %d,%d, ", top->clk, top->reset);

            // PROCESS THE NEXT ROUND OF VERILOG EVENTS (posedge, negedge, repeat...)
            top->eval ();



            ///////////////////////////////////////////////////////////////////
            // When/if inouts ever work:
            /*
            pads_out = 
                (top->pad_S0_T0  << 15) |
                (top->pad_S0_T1  << 14) |
                (top->pad_S0_T2  << 13) |
                (top->pad_S0_T3  << 12) |
                (top->pad_S0_T4  << 11) |
                (top->pad_S0_T5  << 10) |
                (top->pad_S0_T6  <<  9) |
                (top->pad_S0_T7  <<  8) |
                (top->pad_S0_T8  <<  7) |
                (top->pad_S0_T9  <<  6) |
                (top->pad_S0_T10 <<  5) |
                (top->pad_S0_T11 <<  4) |
                (top->pad_S0_T12 <<  3) |
                (top->pad_S0_T13 <<  2) |
                (top->pad_S0_T14 <<  1) |
                (top->pad_S0_T15 <<  0) |
                0;
            */

            // While inouts are busted:
            pads_out = 
                (top->pad_S0_T0_out  << 15) |
                (top->pad_S0_T1_out  << 14) |
                (top->pad_S0_T2_out  << 13) |
                (top->pad_S0_T3_out  << 12) |
                (top->pad_S0_T4_out  << 11) |
                (top->pad_S0_T5_out  << 10) |
                (top->pad_S0_T6_out  <<  9) |
                (top->pad_S0_T7_out  <<  8) |
                (top->pad_S0_T8_out  <<  7) |
                (top->pad_S0_T9_out  <<  6) |
                (top->pad_S0_T10_out <<  5) |
                (top->pad_S0_T11_out <<  4) |
                (top->pad_S0_T12_out <<  3) |
                (top->pad_S0_T13_out <<  2) |
                (top->pad_S0_T14_out <<  1) |
                (top->pad_S0_T15_out <<  0) |
                0;
            ///////////////////////////////////////////////////////////////////

            //printf("OUT pad00=%d ", top->pad_S0_T0);
            //printf("pad30=%d\n", top->pad_S3_T0);

            if (outbit_file != NULL) {
                if (outbit_padname == NULL) {
                    printf("\n\nERROR no padname specified on cmd line\n\n");
                    exit(13);
                }
                if (! strcmp(outbit_padname, "s1t0")) {
                    outbit = top->pad_S1_T0_out;
                } else { 
                    printf("\n\nERROR haha for now can only output from pad 's1t0' sorry!\n\n");
                    exit(13);
                }
            }
        } // for (clk)

        if (!reset && tile_config_done) {
            nprints++;

            // Only print info for first 40 cycles, see how that goes
            if (i < 60) {
                if (delay_in == 0) {
                    // If delay zero, assume we're doing the 2x thing (oh so terrible)
                    // 
                    // Queue up output in "what_i_did" buffer, to display later
                    sprintf(what_i_did, "Two times %d = %d  *%s*", 
                            pads_in,
                            pads_out,
                            pads_out == 2*pads_in ? "PASS" : "FAIL"
                            );
                }
                else {
                    sprintf(what_i_did, "Input %d => result %d", 
                            pads_in,
                            pads_out
                            );
                }
            }
            else sprintf(what_i_did, "...");

            //printf("initial_delay_so_far=%d; delay_in=%d\n", initial_delay_so_far, delay_in);
            // Output to output file if specified.
            if (initial_delay_so_far == delay_in) {
                int print_result = (delay_in > 0) && (i < 40);
                write_output(output_file, pads_in, pads_out, what_i_did, print_result);
                if (outbit_file) { fputc(outbit, outbit_file); }
            } else {
                initial_delay_so_far++;
            }
        }
        if (nprints==1) { printf("\n"); }

        if (i <= 60) {
            // printf("cy.clk %05d.%d: ", i, top->clk);
            printf("%05d: ", i);
            printf("%s\n", what_i_did);
        }

        // FIXME/TODO maybe build a "close_all_and_exit" subroutine and call it before exit(s)
        if (input_filename != NULL) {
            if (feof(input_file)) {
                if (final_delay_so_far == delay_out) {
                    printf("\n\nINFO Simulation ran for %d cycles (453)\n\n", i);
                    if (input_file)       { fclose(input_file ); }
                    if (output_file)      { fclose(output_file); }
                    if (outbit_file)      { fclose(outbit_file); }
                    if (config_data_file) { fclose(config_data_file); }
                    CLOSETRACE
                    exit(0);
                }
                else {
                    //    printf("One more (446): delay_out=%d, final_delay_so_far=%d\n", delay_out, final_delay_so_far);
                    final_delay_so_far++;
                }
            }
        }
    } // for (i)

    if (Verilated::gotFinish()) {
        printf("\n\nINFO Simulation ran for %d cycles (459)\n\n", NCLOCKS);
        if (input_file)       { fclose(input_file ); }
        if (output_file)      { fclose(output_file); }
        if (outbit_file)      { fclose(outbit_file); }
        if (config_data_file) { fclose(config_data_file); }
        CLOSETRACE
        exit(0);
    }
    CLOSETRACE
} // main()

void write_output(
                  FILE *output_file,
                  unsigned int pads_in,
                  unsigned int pads_out,
                  char *what_i_did,
                  int print_result)
{
    if (output_file != NULL) {
        // print_result = (delay_in > 0) && (i < 40)
        
        // char c = (char)(top->wire_0_1_BUS16_S0_T4 & 0xff);
        // char c = (char)(OUTWIRE & 0xff);
        
        // printf("\nemit %d to output file\n", pads_out & 0xff);
        fputc(pads_out, output_file);
        if (print_result) {
            sprintf(what_i_did, "Input %d => result %d => OUT", 
                    pads_in,
                    pads_out
                    );
        }
    } // output_file != NULL
}
