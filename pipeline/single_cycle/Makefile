export CORE_ROOT=/home/talha/RV32I_Single_Cycle/pipeline

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/core_main.out

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/core_main.out

clean:
	rm -rf temp