FAMILY  = kintex7
PART    = xc7k325tffg900-2
BOARD   = kc705
XDC    ?= kc705.xdc
PROJECT = top

CHIPDB ?= ../../chipdb

include ../../openXC7.mk

# TODO: validate ?LUT.INIT in top.fasm
.PHONY: test
test:
	#make -C . YOSYS_OPTS="-DTEST_RAMS32" clean top.fasm
	#make -C . YOSYS_OPTS="-DTEST_RAMD32" clean top.fasm
	#make -C . YOSYS_OPTS="-DTEST_RAMS64E" clean top.fasm
	#make -C . YOSYS_OPTS="-DTEST_RAMD64E" clean top.fasm
	#make -C . YOSYS_OPTS="-DTEST_RAM64X1S" clean top.fasm
	#make -C . YOSYS_OPTS="-DTEST_RAM128X1S" clean top.fasm
	#make -C . YOSYS_OPTS="-DTEST_RAM256X1S" clean top.fasm
	make -C . YOSYS_OPTS="-DTEST_RAM32X1D" clean top.fasm
	make -C . YOSYS_OPTS="-DTEST_RAM64X1D" clean top.fasm
	make -C . YOSYS_OPTS="-DTEST_RAM128X1D" clean top.fasm
	make -C . YOSYS_OPTS="-DTEST_RAM32X1S" clean top.fasm
	make -C . YOSYS_OPTS="-DTEST_RAM32M" clean top.fasm
	make -C . YOSYS_OPTS="-DTEST_RAM64M" clean top.fasm
