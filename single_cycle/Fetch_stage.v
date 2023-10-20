`include "pc_reg.v"
module Fetch_stage(

  input wire clk,
  input wire rst,
  input wire valid,
  input wire Branch,
  input wire jal,
  input wire jalr,
  input wire b_result,
  input wire [31:0] instruction_fetch,
  input wire [31:0]alu_res,
  input wire [31:0]address_in,


  output wire we_re,
  output wire request,
  output wire [3:0] mask,
  output wire [31:0] address_out,
  output reg  [31:0] instruction

);

  // PROGRAM COUNTER
  pc u_pc0 
  (
    .clk(clk),
    .rst(rst),
    .jal(jal),
    .jalr(jalr),
    .jal_address(alu_res),
    .Branch(Branch),
    .b_result(b_result),
    .jalr_address(alu_res),
    .branch_address(alu_res),
    .address_in(0),
    .address_out(address_out)
  );

  assign mask = 4'b1111; 
  assign we_re = 1'b0;
  assign request = 1'b1;

  always @ (*) begin 
    instruction = instruction_fetch ;
  end
    
endmodule