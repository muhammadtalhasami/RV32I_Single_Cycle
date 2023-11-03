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
  input wire load,


  output reg we_re,
  output reg request,
  output reg [3:0] mask,
  output wire [31:0] address_out,
  output reg  [31:0] instruction

);


  // PROGRAM COUNTER
  pc u_pc0 
  (
    .clk(clk),
    .rst(rst),
    .load(load),
    .jal(jal),
    .jalr(jalr),
    .dmem_valid(valid),
    .jal_address(alu_res),
    .Branch(Branch),
    .b_result(b_result),
    .jalr_address(alu_res),
    .branch_address(alu_res),
    .address_in(0),
    .address_out(address_out)
  );

  always@(*)begin
    if(load & !valid)begin
      mask = 4'b1111; 
      we_re = 1'b0;
      request = 1'b0;
    end
    else begin
      mask = 4'b1111; 
      we_re = 1'b0;
      request = 1'b1;
    end
  end
  always @ (*) begin 
    instruction = instruction_fetch ;
  end
    
endmodule