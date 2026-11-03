IVERILOG ?= /usr/bin/iverilog
VVP 	 ?= /usr/bin/vvp

SIM = simv
SOURCES = gray_counter.sv gray_counter_tb.sv

.PHONY: all run cocotb clean

all: run

run: $(SIM)
	$(VVP) $(SIM)

$(SIM): $(SOURCES)
	$(IVERILOG) -g2012 -s gray_counter_tb -o $(SIM) $(SOURCES)

cocotb:
	python test_gray_counter.py

clean:
	rm -f $(SIM)
	rm -rf sim_build
	rm -rf __pycache__

