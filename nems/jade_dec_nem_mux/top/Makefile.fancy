# Note: Makefile should be doing this, basically:
#   make gen -f $ddir/Makefile GENESIS_HIERARCHY=$xml_out GENESIS_CFG_XML=$changefile >& $makefile_log

##############################################################################
# This makefile lets you run the generator from any remote directory,
# e.g. if the generator lives in
#
#   /nobackup/steveri/github/CGRA/hardware/generator_z/top/
#
# You can do this:
#
#    % mkdir /tmp/cgra; cd /tmp/cgra
#    % make gen -f /nobackup/steveri/github/CGRA/hardware/generator_z/top/Makefile
#    % ls /tmp/cgra
#        genesis_clean.cmd*  genesis_synth/         genesis_vlog.verif.vf
#        genesis.log         genesis_verif/         genesis_vlog.vf
#        genesis_raw/        genesis_vlog.synth.vf  genesis_work/

##############################################################################
# Basically, makefile does this:
#   set DESIGN_HOME = /nobackup/steveri/github/CGRA/hardware/generator_z/top
#   Genesis2.pl -parse -generate -top top -input <input files>

# Set DESIGN_HOME = directory where makefile lives
# e.g. DESIGN_HOME =  /nobackup/steveri/github/CGRA/hardware/generator_z/top/
MAKEFILE_PATH:=$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
DESIGN_HOME:=$(shell cd $(dir $(MAKEFILE_PATH)); pwd -P)
$(info $(DESIGN_HOME)/Makefile)



########### Generic Env Defs ############
#########################################
# TOP is name of module to compile and run, e.g.
#   - make TOP=fftgen for fftgen test
#   - make TOP=clock to test clock.vp module only.
#TOP := fftgen
#TOP := fft
TOP := top

# output xml hierarchy file
ifndef GENESIS_HIERARCHY
  GENESIS_HIERARCHY := $(TOP).xml
endif

$(info GENESIS_HIERARCHY set to $(GENESIS_HIERARCHY))


# If xml changefile requested, set the appropriate change flags
GENESIS_CFG_XML	:=
GENESIS_CFG	:=

# This checks to see if the default null value was overwritten by command line.
ifneq ($(strip $(GENESIS_CFG_XML)),)
  GENESIS_CFG := \
    -cfgpath . \
    -cfgpath ./SysCfgs \
    -xml $(GENESIS_CFG_XML)
  $(info GENESIS_CFG set to '$(GENESIS_CFG)')
endif



# Run the generator
# 
# (For GUI, added hierarchy, cfgpath and xml flags.)
gen:
	@if ! `test -d SysCfgs`; then echo; \
	  echo 'WARNING Cannot find change dir "SysCfgs"';    \
          echo 'WARNING I will attempt to build it for you.'; \
	  echo; \
	  mkdir SysCfgs; \
	fi
	Genesis2.pl -parse -generate -top $(TOP) -input \
	    $(DESIGN_HOME)/../sb/sb.vp \
	    $(DESIGN_HOME)/../cb/cb.vp \
	    $(DESIGN_HOME)/../pe/pe.vp \
	    $(DESIGN_HOME)/../memory_tile/mem_tile_sb_cb.vp \
	    $(DESIGN_HOME)/../memory/mem_tile.vp \
	    $(DESIGN_HOME)/../memory/mem.vp \
	    $(DESIGN_HOME)/top.vp \
	  -hierarchy $(GENESIS_HIERARCHY) \
	  $(GENESIS_CFG)


# Note: Makefile should be doing this, basically:
#   make gen -f $ddir/Makefile GENESIS_HIERARCHY=$xml_out GENESIS_CFG_XML=$changefile >& $makefile_log
