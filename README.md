# NEM Relay CGRA (Coarse-Grain Reconfigurable Architecture) Generator

## Instructions: RTL Simulation and Gate-Level Simulation (GLS)

The goal is first to get the waveforms as `*.vcd` files using verilator.
Then, you want to take the input stimuli from the VCD and apply them to the gate-level netlist to get the gate-level activities:
1. Clone modified TestBenchGenerator:
    - `git clone https://github.com/akashlevy/TestBenchGenerator.git ../TestBenchGenerator`
2. Look at `.travis.yml` and install packages as done in there. *Recommended: use Linux for setup.* Current instructions:
    - `sudo apt-get install csh verilator`
    - Install Miniconda:
        - `wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;`
        - `bash miniconda.sh -u -b -p $HOME/miniconda`
        - Ensure that base is activated automatically
        - Restart terminal or source user profile script (e.g. `.bash_profile`) to activate it
        - `rm miniconda.sh`
    - `pip install pytest numpy delegator.py bit_vector==0.42a0`
3. Go to `testdir` and run `make vcdtest APP=<app_name>` to generate the waveform. The VCD output will be in `verilator/generator_z_tb`
    - You might need a large amount of RAM for verilator to work
    - On Ubuntu, you can try creating a swap file: https://linuxize.com/post/how-to-add-swap-space-on-ubuntu-18-04/
4. Copy the VCD output to gls: `cp verilator/generator_z_tb/<app_name>.vcd gls/inputs/<app_name>.vcd`
5. Symlink your mflowgen `outputs/` directory from the signoff step as `design` in `gls/`
6. Symlink your Liberty/Verilog files from the NEM-Relay-CAD repo in `gls/lib/`. This will work by default if your NEM-Relay-CAD repo and NEM-Relay-CGRA repo are cloned to the same directory.
7. Copy the bitstream `<app_name>.bsa` for the app to `gls/inputs/`. The example application bitstreams are already copied there.
8. Open the VCD and find the cycle number you want to start measuring toggling (activity factor) from
    - Typically, you want to skip the configuration phase of the CGRA, so choose the cycle that corresponds to the beginning of the usage phase after the end of configuration
    - For several CGRA applications, this cycle number has been found and stored in `defines.py` for convenience
    - If you are using one of these CGRA applications, you don't need to supply `<active_cycle_number>`
9. Make sure the requirement modules are loaded. Add these lines to your `~/.cshrc` or equivalent profile:
    - `module load vcs/O-2018.09-SP1`
    - `module load prime`
    - `module load pts/K-2015.12`
10. Run GLS: `python gls.py <app_name> <active_cycle_number>`
11. Then go into `synopsys-ptpx-gl` and configure your symlinks
    - `nldm_nems40tt.db` should point to the latest compiled NEMS lib file
    - `stdcells.db` should point to the compiled library cells from the PDK
    - `nems` should point to the mflowgen `outputs/` directory from the signoff step of your NEMS design
    - `vanilla` should point to the mflowgen `outputs/` directory from the signoff step of your vanilla design
12. Finally, run `run.sh <app_name> <nems_or_vanilla>` which will run PTPX and generate signoff reports in `gls/results/<nems_or_vanilla>`.
13. Done!


To visualize the power number breakdown after PTPX using sunburst-chart:
13. First go to `gls/results/` and run `powjson.py`.
    - This will automatically parse all the power reports for all apps that were run and generate jsons.
14. Then upload the desired HSIB file to an online destination.
    - One good way to do this is simply to commit the json files to the repository and find the link to the raw file on GitHub.
15. Navigate to http://www.akashlevy.com/sunburst-chart/example/flare/ and enter the URL of the JSON file.
16. Done!

## NOTES

VCD trace output from Verilator is in picoseconds.

## Old Info from CGRAGenerator

| Status                       |
|------------------------------|
| [![linux build status][1]][2]|

[1]: https://travis-ci.org/StanfordAHA/CGRAGenerator.svg?branch=master
[2]: https://travis-ci.org/StanfordAHA/CGRAGenerator

See doc/srnotes.txt for Steve's notes on organization and such
(still TBD as of this writing).

Quick guide to repository contents as of 03/2017:
* doc/ => documentation (still TBD as of this writing)
* Genesis2Tools => for building the project and running it with e.g. travis
* hardware/generator_z => latest instantiation of the generator
* hardware/generator_z/top => go here to run the generator
* verilator => verilator experiments
* verilator/generator_z_tb => go here to run the generator testbench (under development)
<br/><br/>

TODO
* should replace Genesis2Tools with a build from within the travis script maybe
<br/><br/>


OBSOLETE: I think maybe these are obsolete?
* hardware/pe => Artem's PE generator (right?)
* hardware/sb => Ankita's switchbox generator (yes?)
* sr-proposal/ => Steve's proposal for a unified framework for the generators

