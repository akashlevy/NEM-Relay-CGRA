#!/bin/csh

cat << eof
GENESIS2 SETUP (csh)

Can set GENESIS_HOME to existing install e.g. on kiwi:

  setenv GENESIS_HOME /home/steveri/smart_memories/Smart_design/ChipGen/bin/Genesis2Tools/

...or can install Genesis2 from scratch and then set GENESIS_HOME e.g.

  git clone https://github.com/StanfordVLSI/Genesis2.git /tmp/Genesis2
  setenv GENESIS_HOME /tmp/Genesis2/Genesis2Tools

Then:

  set path=(. \$GENESIS_HOME/bin \$GENESIS_HOME/gui/bin \$path)
  if (! \$?PERL5LIB) then
    setenv PERL5LIB \$GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions
  else
    setenv PERL5LIB "\$PERL5LIB":\$GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions
  endif

eof
