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
4. Copy the gate-level netlist and SDF file as `design.v` and `design.sdf` to `gls/design/`
5. Copy the VCD output to gls: `cp verilator/generator_z_tb/<app_name>.vcd gls/inputs/<app_name>.vcd`
6. Copy the bitstream `<app_name>.bsa` for the app to `gls/inputs/`
7. Open the VCD and find the cycle number you want to start measuring toggling (activity factor) from
    - Typically, you want to skip the configuration phase of the CGRA, so choose the cycle that corresponds to the beginning of the usage phase after the end of configuration
    - For several CGRA applications, this cycle number has been found and stored in `defines.py` for convenience
    - If you are using one of these CGRA applications, `<active_cycle_number>` is optional in the next step
8. Run GLS: `python gls.py <app_name> <active_cycle_number>`
9.  **TODO: how to do gate-level simulation**

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

