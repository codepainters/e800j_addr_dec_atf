#!/bin/sh

FILE=$1

exec openocd \
    -c "interface jlink" \
    -c "jtag newtap atf1502 tap -irlen 3 -expected-id 0x0150203f" \
    -c "init" \
    -c "svf -progress $FILE"

