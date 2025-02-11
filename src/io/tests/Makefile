SIM ?= verilator
EXTRA_ARGS += --trace-fst --trace-structs

TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES += ../addr_dec_io.v

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = addr_dec_io

# MODULE is the basename of the Python test file
MODULE = test_addr_dec_io

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
