################################################################################
# Makefile Definitions
################################################################################

# RUN := run.csh
RUN := run_tbg.csh
TBG := -tbg
ifeq ($(RUN), run.csh)
  TBG :=
endif

MEMHEIGHT := short

VERILATOR_TOP := ../verilator/generator_z_tb
HARDWARE_TOP  :=  ../hardware/generator_z/top
CGRA_INFO := $(HARDWARE_TOP)/cgra_info.txt
SIMULATOR := $(VERILATOR_TOP)/build/Vtop

SILENT := FALSE
ifeq ($(SILENT), TRUE)
	QUIET := -q
	VSWITCH :=
else
	QUIET :=
	VSWITCH := -v
endif
# $(warning OUTPUT = "$(OUTPUT)")

TEMPDIR := $(shell mktemp -d /tmp/gentest-XXX)
DELAY = 0,0

test_basic:
#	# Use run.csh built-in default config
	@./writelog.csh log1 -init
#	# make test TEMPDIR=$(TEMPDIR) IMAGE="gray_small"         DELAY="0,0"
	make test TEMPDIR=$(TEMPDIR) IMAGE="input_10x10_1to100" DELAY="0,0" \
	          CONFIG=""
	@echo
	@./writelog.csh log1 -print

$(CGRA_INFO):
	cd $(HARDWARE_TOP); ./build_cgra.sh --$(MEMHEIGHT)mem
	$(HARDWARE_TOP)/bin/show_cgra_info.csh

$(VERILATOR_TOP)/obj_dir/Vtop: $(CGRA_INFO)
	cd $(VERILATOR_TOP); ./run.csh 

# No dependence on Vtop b/c utest.py default is now TBG...right?
# test_unit: $(CGRA_INFO) $(VERILATOR_TOP)/obj_dir/Vtop
test_unit: $(CGRA_INFO)
	./unit_tests/utest --nogen $(VSWITCH)

test_all:
	make hackdiff_test 2>&1 | tee $(TEMPDIR)/hackdiff_test.log
	make test_unit
	make test_basic
	make test_serpent

        # Read standalone test result(s) from 'log1'
	@echo ""
	@echo SUMMARY OF STANDALONE TEST RESULTS
	@echo ==================================================
	./writelog.csh log1 -print

        # Summary of hackdiff results
	egrep ^hackdiff $(TEMPDIR)/hackdiff_test.log


# Twenty-minute (ish) tests for travis
travis_system_tests:
	@echo TIMENOW `date +%H:%M`
	@echo "ten minutes for basic test (pointwise) + tbg first build"
	make SILENT=TRUE test_basic   RUN=run_tbg.csh

	@echo TIMENOW `date +%H:%M`
	@echo "ten minutes for sr unit tests"
	make SILENT=TRUE test_unit    RUN=run_tbg.csh

	@echo TIMENOW `date +%H:%M`
	@echo "five minutes for serpent-based tests"
        # Note the "tee" command masks make errors :(
	(make SILENT=TRUE test_serpent RUN=run_tbg.csh || echo FAIL) \
	  | tee serpent_results.tmp

	@echo TIMENOW `date +%H:%M`
	@echo "four minutes(?) for keyi-routed cascade and harris"
	(make SILENT=TRUE cascade RUN=run_tbg.csh || echo FAIL) \
	  | tee -a serpent_results.tmp
	(make SILENT=TRUE harris  RUN=run_tbg.csh || echo FAIL) \
	  | tee -a serpent_results.tmp

	@echo "quick bsbuilder test"
	(cd ..//bitstream/bsbuilder/testdir/sram_mode; make test || echo FAIL bsbuilder) \
	  | tee -a serpent_results.tmp

        # check for hidden errors
	grep FAIL serpent_results.tmp && exit 13 || echo NO_FAIL
	grep RESULT serpent_results.tmp
	$(HARDWARE_TOP)/bin/show_cgra_info.csh | grep mem_tile_height
	@echo TIMENOW `date +%H:%M`


travis_test_cascade:
	@echo "cascade!"
	(make SILENT=TRUE cascade RUN=run_tbg.csh || echo FAIL) \
	  | tee -a serpent_results.tmp

# '$@' turns into 'cascade' or 'harris' as appropriate
cascade harris: $(CGRA_INFO)
	cd $(VERILATOR_TOP); ./run_tbg.csh \
	  -config ../../bitstream/examples/$@_keyi.bsa \
	  -input  ../../bitstream/bsbuilder/testdir/examples/$@_input.raw \
	  -output build/$@_CGRA_out.raw \
	  -out1   build/$@_CGRA_out1.raw \
	  -delay 260,0 -nclocks 1M || exit 13

	cd $(VERILATOR_TOP); python ./bin/keyi_compare.py  \
	  build/$@_CGRA_out.raw build/$@_CGRA_out1.raw \
	  ../../bitstream/bsbuilder/testdir/examples/$@_halide_out.raw \
          && echo TEST RESULT $@ PASSED || exit 13

test_serpent: $(CGRA_INFO)
	../bitstream/bsbuilder/testdir/make_bitstreams.csh $(TEMPDIR)
	../bitstream/bsbuilder/testdir/test_bitstreams.csh $(TBG) $(TEMPDIR)
#	FIXME Who will delete TEMPDIR?

test_serpent_dev:
	../bitstream/bsbuilder/testdir/make_bitstreams.csh $(TEMPDIR) pointwise conv_1_2 conv_2_1

hackdiff_test:
	cd ../bitstream; \
	decoder/hackdiff.csh \
	  examples/bw1000.bs examples/bw1000.bsa \
	  -cgra examples/cgra_configs/cgra_info_new.txt



# TODO can combine all these down to one
# TODO make it look more like other makefile (cgraflow)


test: $(HARDWARE_TOP)/cgra_info.txt
	@echo ""
	@echo "------------------------------------------------------------------------"
	@echo "BEGIN TEST"
	@echo "------------------------------------------------------------------------"

#	./run.csh $(QUIET) -gen
	cd $(VERILATOR_TOP);\
	./$(RUN) $(QUIET) -gen    \
	   $(CONFIG)               \
	   -input  io/$(IMAGE).png \
	   -output $(TEMPDIR)/$(IMAGE)_out.raw \
	   -delay $(DELAY)         \
	   -nclocks 5M || echo FAIL

	cmp $(VERILATOR_TOP)/io/$(IMAGE)_out.raw $(TEMPDIR)/$(IMAGE)_out.raw      \
		&& ./writelog.csh log1 PASSED `date +%R` test $(CONFIG) \
		|| ./writelog.csh log1 FAILED `date +%R` test $(CONFIG)

	cd $(VERILATOR_TOP);\
	cmp io/$(IMAGE)_out.raw $(TEMPDIR)/$(IMAGE)_out.raw

