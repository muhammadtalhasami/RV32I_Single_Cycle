`include "rd_address.v"
module write_back (
    input wire [1:0]  mem_to_reg,
    input wire [31:0] alu_out,
    input wire [31:0] data_mem_out,
    input wire [31:0] pc_address,
    input wire [31:0] u_immo,

    output wire [31:0] rd_sel_mux_out
    );

    //WRITE BACK MUX
    rd_address u_0 (
        .alu_out(alu_out),
        .wrapermout(data_mem_out),
        .jal_addr(pc_address),
        .lui_addr(u_immo),
        .sel(mem_to_reg),
        .out(rd_sel_mux_out)
    );  
endmodule