IVERILOG ?= /usr/bin/iverilog
VVP 		 ?= /usr/bin/vvp

SIM = simv
SOURCES = alu.sv alu_tb.sv

.PHONY: all run cocotb clean

all: run

run: $(SIM)
	$(VVP) $(SIM)

$(SIM): $(SOURCES)
	$(IVERILOG) -g2012 -s tb -o $(SIM) $(SOURCES)

cocotb:
	python test_alu.py

clean:
	rm -f $(SIM)
	rm -rf sim_build
	rm -rf __pycache__
	rm -f dump.fst
