module mux2_4 (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [31:0] c,
    input wire [31:0] d,
    input wire [31:0] e,
    input wire [2:0]sel,
    output wire [31:0] out
);

assign out = (sel == 3'b000)? b :(sel == 3'b001)? a :(sel == 3'b010)?c:(sel == 3'b011)?d:e;

endmodule