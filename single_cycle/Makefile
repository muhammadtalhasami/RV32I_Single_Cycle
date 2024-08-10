export CORE_ROOT=/home/talha/RV32I_Single_Cycle/single_cycle

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/microprocessor.output

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/microprocessor.output

clean:
	rm -rf temp