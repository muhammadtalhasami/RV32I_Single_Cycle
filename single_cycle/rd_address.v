module rd_address (
    input wire [31:0] alu_out,
    input wire [31:0] wrapermout,
    input wire [31:0] jal_addr,
    input wire [31:0] lui_addr,
    input wire [1:0]sel,
    output wire [31:0] out
);

assign out = (sel == 2'b11)? lui_addr: (sel == 2'b00)? alu_out :(sel == 2'b01)? wrapermout :jal_addr+4;

endmodule