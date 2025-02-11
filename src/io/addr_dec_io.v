module addr_dec_io (
    // A8 - 44, A7 - pin 10, A6 - 11, A5 - 13, A4 - 12, A3 - 15, A2 - 18, A1 - 20, A0 - 22
    input   [8:0] A,
    // D0 - 23
    output        nCFE,
    // D1 - 25
    output        nCF7,
    // D3 - 28
    output        nCSFDC,
    // D4 - 30
    output        nCS51,
    // D2 - 27
    output        nCS55,
    // D5 - 31
    output        nCF1,
    // D6 - 33
    output        nIAL
);

// ~CFE
assign nCFE = (A[7:0] == 8'hFE || A[7:0] == 8'hFB || A[7:0] == 8'h7F) ? 1'b0 : 1'b1;

// ~CF7
assign nCF7 = A[7:0] == 8'hF7 ? 1'b0 : 1'b1;

// ~CS55
assign nCS55 = (A[7:0] == 8'h1F || 
                A[7:0] == 8'hDC ||
                A[7:0] == 8'hDD || 
                A[7:0] == 8'hDE || 
                A[7:0] == 8'hDF) ? 1'b0 : 1'b1;

// ~CSFDC
assign nCSFDC = (A[7:0] == 8'hEE || A[7:0] == 8'hEF) ? 1'b0 : 1'b1;

// ~CS51
assign nCS51 = (A[7:0] == 8'hBE || A[7:0] == 8'hBF) ? 1'b0 : 1'b1;

// ~CF1
assign nCF1 = A[7:0] == 8'hF1 ? 1'b0 : 1'b1;

// ~IAL
assign nIAL= A[8:0] == 9'h66 ? 1'b0 : 1'b1;

endmodule
