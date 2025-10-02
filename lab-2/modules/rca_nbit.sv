module rca_nbit #(parameter N = 4) (
    input logic [N-1:0] a,  // N-bit input  
    input logic [N-1:0] b,  // N-bit input
    input logic cin,         // carry in
    output logic [N-1:0] sum, // N-bit output
    output logic cout        // carry out
);

    // Internal Signals
    logic [N:0] carry;
    // Assign the first carry to the cin
    assign carry[0] = cin;
    // Generate the loop variable
    genvar i;

    // Generate N bit full adder
    generate
        for (i = 0; i < N; i++) begin : gen_full_adder
            // module_name instance_name (.port1(signal1), .port2(signal2), ...);
            full_adder_mux_slice fa (
                .a(a[i]), 
                .b(b[i]), 
                .cin(carry[i]), 
                .sum(sum[i]), 
                .cout(carry[i+1]));
        end
    endgenerate

    // Assign the last carry to the cout
    assign cout = carry[N];

endmodule
