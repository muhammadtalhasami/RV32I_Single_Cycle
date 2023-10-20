module mux(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire sel,
    output wire [31:0] out
);

assign out = (sel)? b : a;

endmodule