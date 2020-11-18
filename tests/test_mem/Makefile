default:
	verilator -Wno-fatal -I../../hardware/generator_z/top/genesis_verif/ -I../../hardware/generator_z/top/ --cc memory_core_unq1.v --exe memory_core_test.cpp --top-module memory_core_unq1 -CFLAGS "--std=c++14"
	make --silent -C obj_dir -j -f Vmemory_core_unq1.mk Vmemory_core_unq1 -B

clean:
	\rm -rf obj_dir
