perl --version | head -1

# Alternatively could maybe do this...
# If running locally, use existing Genesis2 install...
# if (hostname == kiwi) setenv GENESIS_HOME /cad/genesis2/r11879/Genesis2Tools/

# Clone Genesis2 from github

if (! -d /tmp/Genesis2/) then
  git clone https://github.com/StanfordVLSI/Genesis2.git /tmp/Genesis2
endif
setenv GENESIS_HOME /tmp/Genesis2/Genesis2Tools

# huh.  seems to break if don't remove distrib Zlib?
# Compress::Raw::Zlib object version 2.060 does not match bootstrap parameter 2.033 at /tmp/Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress/Raw/Zlib.pm line 98.
/bin/rm -rf /tmp/Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress
#
# popd

set path=(. $GENESIS_HOME/bin $GENESIS_HOME/gui/bin $path)
if (! $?PERL5LIB) then
  setenv PERL5LIB $GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions
else
  setenv PERL5LIB "$PERL5LIB":$GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions
endif

