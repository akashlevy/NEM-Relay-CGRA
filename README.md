# CGRA Coarse-Grain Reconfigurable Architecture Generator

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

