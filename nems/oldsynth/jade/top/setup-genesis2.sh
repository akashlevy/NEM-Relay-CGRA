# Look for/create Genesis2
GENESIS_HOME=/home/steveri/smart_memories/Smart_design/ChipGen/bin/Genesis2Tools/
if [ ! -d $GENESIS_HOME ]; then

  echo ""
  echo "Genesis2 not found in /home/steveri; try /tmp/Genesis2"

  if [ ! -d /tmp/Genesis2 ]; then
    echo "Genesis2 not found in /tmp/Genesis2 either, I will git-clone a new one for you"
    git clone https://github.com/StanfordVLSI/Genesis2.git /tmp/Genesis2
  fi
  echo ""

  # Note this must be OUTSIDE if-clause above, doy!
  GENESIS_HOME=/tmp/Genesis2/Genesis2Tools

  # huh.  seems to break if don't remove distrib Zlib?
  # Compress::Raw::Zlib object version 2.060 does not match bootstrap parameter 2.033 at /tmp/Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress/Raw/Zlib.pm line 98.
  if [ -e /tmp/Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress ]; then
    /bin/rm -rf /tmp/Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress
  fi
fi

export GENESIS_HOME
export PATH="$GENESIS_HOME/bin:$GENESIS_HOME/gui/bin":"$PATH"

# Set vars based on what you found
PATH=$GENESIS_HOME/bin:$GENESIS_HOME/gui/bin:$PATH
# if [ -z ${var+x} ]; then echo "var is unset"; else echo "var is set to '$var'"; fi
if [ -z ${PERL5LIB+x} ]; then
  PERL5LIB=$GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions
else
  PERL5LIB=$PERL5LIB:$GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions
fi
export PERL5LIB
