module execute (
    input wire [31:0]a_i,
    input wire [31:0]b_i,
    input wire [3:0]alu_control,

    output wire [31:0]alu_out

);

    // ALU
    alu u_alu0 
    (
        .a_i(a_i),
        .b_i(b_i),
        .op_i(alu_control),
        .res_o(alu_out)
    );

endmodule