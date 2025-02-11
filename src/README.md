# Source files

The directories [io](io) and [mem](mem) contain source files for I/O and memory address decoders, respectively. Decoding logic is written in Verilog. It can be verified using [cocotb](https://www.cocotb.org/) and [verilator](https://www.veripool.org/verilator/), just execute `make` in `io/tests` or `mem/tests` subdirectory.

In order to build the bitstreams you have to follow the following steps:

* compile the project using `Altera Quartus 13` (for Linux see [here](https://github.com/codepainters/quartus13/)). Quartus is used to create a `.pof` file suitable for Altera chip, as `ATF1502ASL` is compatible with Altera `EPM7032`CPLD.
* use Atmel's [pof2jed](https://www.microchip.com/en-us/development-tool/pof2jed) tool to convert `.pof` file into `.jed` (Jedec) file suitable for `ATF1502ASL`
* use Atmel's [ATMISP](https://www.microchip.com/en-us/development-tool/atmisp) to convert `.jed` file to a `.svf` file (or program the chip, if you happen to have a ATMISP-compatible JTAG probe)

Atmel tools are Windows-only, unfortunately (but work properly under [Wine](winehq.org)).

