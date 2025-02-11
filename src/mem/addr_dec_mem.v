module addr_dec_mem (
    // inputs A5 - 13, A4 - 12, A3 - 15, A2 - 18, A1 - 20, A0 - 22
    input   [15:10] A,
  
    // input A6 - 11
    input   BOOT,
    // input A7 - 10
    input   f7_q1,
    // input A8 - 44
    input   RELOK,
   
    // output D0 - 23
    output        nROM1,
    // output D1 - 25
    output        nROM3,
    // output D2 - 27
    output        nRS,
    // output D3 - 28
    output        nDR,
    // output D4 - 30
    output        nROM2,
    // output D5 - 31
    output        nIAH
);

// ~ROM1 (BAS0) - at 0x0000..0x1FFF
assign nROM1 = (~(RELOK == 1 && f7_q1 == 1) && BOOT == 0 && A[15:13] == 3'h00) ? 1'b0 : 1'b1;

// ~ROM2 (BOOT) - at 0x0000..0x1FFF
assign nROM2 = (BOOT == 1 && A[15:13] == 3'h00) ? 1'b0 : 1'b1;

// 0x2000..0x3FFF region
// - ROM3 (BAS1) is mapped if BOOT == 0 and f7_q1 == 0, or BOOT == 1 and fl_q1 == 1
assign nROM3 = (((BOOT == 0 && f7_q1 == 0) ||
                 (BOOT == 1 && f7_q1 == 1))
                && A[15:13] == 3'h01)
    ? 1'b0 : 1'b1;


// ~RS - at 0x5800..0x5BFF if RELOK == 0, 0xF800..0xFBFF if RELOK == 1
assign nRS = ((RELOK == 0 && A[15:10] == 6'h16) || (RELOK == 1 && A[15:10] == 6'h3E))
    ? 1'b0 : 1'b1;


// ~DR selects DRAM, it is active for any address that is not handled by EPROMs
// at the moment.
assign nDR = nROM1 == 1 && nROM2 == 1 && nROM3 == 1
    ? 1'b0 : 1'b1;

// ~IAH - part of the RESTART circuit.
assign nIAH = (RELOK == 1 && f7_q1 == 1 && BOOT == 0 && A[15:10] == 6'h00)
    ? 1'b0 : 1'b1;

endmodule
