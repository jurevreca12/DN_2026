current_dir := ${CURDIR}
ANVIL_HOME ?= $(HOME)/opt/anvil
TARGET := nexys4ddr
TOP := top
SOURCES := ${current_dir}/build/converted/SevSegDisplay.v \
           ${current_dir}/build/converted/anode_assert.v \
           ${current_dir}/build/converted/counter_1s.v \
           ${current_dir}/build/converted/digits_to_segments.v \
           ${current_dir}/build/converted/timer_002s.v \
           ${current_dir}/build/converted/top.v \
           ${current_dir}/build/converted/value_to_digit.v
XDC := ${current_dir}/Nexys-A7-100T-Master.xdc

include ${current_dir}/common/common.mk
