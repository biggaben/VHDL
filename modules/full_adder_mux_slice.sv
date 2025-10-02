module full_adder_mux_slice(
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);
    // Internal Signals
    logic b_xor_cin, b_xor_cin_inv, b_and_cin, b_or_cin;
    
    // Gate Instantiations
    // module_name instance_name (.port1(signal1), .port2(signal2), ...);

    or2_delay u_or1 (.a(b), .b(cin), .y(b_or_cin));
    xor2_delay u_xor1 (.a(b), .b(cin), .y(b_xor_cin));
    and2_delay u_and1 (.a(b), .b(cin), .y(b_and_cin));
    nand2_delay u_nand_inv (.a(b_xor_cin), .b(b_xor_cin), .y(b_xor_cin_inv));
//    nand2_delay u_nand1 (.a(b), .b(cin), .y(b_and_cin));

    // This mux chooses between b_xor_cin and its inverse, depending on the value of a
    // This is because if a is 0, then b_xor_cin is the sum, and if a is 1, then b_xor_cin_inv is the sum
    mux2to1_slice u_sum_mux (.a(b_xor_cin_inv), .b(b_xor_cin), .s(a), .y(sum));

    // This mux chooses between b_and_cin and b_or_cin, depending on the value of a
    // This is because if a is 0, then b_and_cin is the cout, and if a is 1, then b_or_cin is the cout
    mux2to1_slice u_cout_mux (.a(b_or_cin), .b(b_and_cin), .s(a), .y(cout));

/* 
Truth Table for the full adder
Shannon decomposition of the full adder:

a  |  sum (output)  |  cout (output)
---+----------------+---------------
0  |  b ^ cin       |  b & cin      
1  |  ~(b ^ cin)    |  b   
*/

endmodule