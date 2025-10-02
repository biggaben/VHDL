module nand2_delay(input logic a, b, output logic y);
    assign y = ~(a & b);
endmodule