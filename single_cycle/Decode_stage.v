`include "controlunit.v"
`include "immediategene.v"
`include "branch.v"
`include "reg_file.v"
`include "mux2_4.v"
`include "mux1_2.v"

module decode_stage(
    input wire [31:0]data1,
    input wire clk,
    input wire rst,
    input wire [31:0]program_counter,
    input wire [31:0] rd_wb_data,

    output wire load,
    output wire store,
    output wire Jal,
    output wire Jalr,
    output wire branch_on,
    output wire branch_result,
    output wire [3:0] alu_control,
    output wire [1:0]  rd_sel,
    output wire [31:0] opa_mux_out,
    output wire [31:0] opb_mux_out,
    output wire [31:0] opb_data,
    output wire [31:0] u_immediate
);

    wire [31:0] i_immo;
    wire [31:0] s_immo;
    wire [31:0] sb_immo;
    wire [31:0] uj_immo;
    wire [31:0] u_immo;
    wire [31:0] m2out;
    wire reg_write;
    wire mem_to_reg;
    wire [2:0]imm_sel;
    wire auipc_en;
    wire Lui;
    wire [31:0] op_b;
    wire mem_en;
    wire loaden;
    wire branchen;
    wire operand_b;
    wire operand_a;
    wire result;
    wire [31:0] op_a;

    // IMMEDIATE GENERATOR
    immediategen u_ig0 (
        .instr(data1),
        .i_imme(i_immo),
        .sb_imme(sb_immo),
        .s_imme(s_immo),
        .uj_imme(uj_immo),
        .u_imme(u_immo)
    );

 
     // CONTROL UNIT
    controlunit u_cu0 
    (
        .opcode(data1[6:0]),
        .fun3(data1[14:12]),
        .fun7(data1[30]),
        .reg_write(reg_write),
        .rd_sel(rd_sel),
        .imm_sel(imm_sel),
        .operand_b(operand_b),
        .operand_a(operand_a),
        .mem_to_reg(mem_to_reg),
        .Jal(Jal),
        .Load(load),
        .Store(store),
        .Lui(Lui),
        .Auipc(auipc_en),
        .Branch(branchen),
        .mem_en(mem_en),
        .Jalr(Jalr),
        .alu_control(alu_control)
    );

         // REGISTER FILE
    registerfile u_rf0 
    (
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .rs1(data1[19:15]),
        .rs2(data1[24:20]),
        .rd(data1[11:7]),
        .data(rd_wb_data),
        .op_a(op_a),
        .op_b(op_b)
    );

            //IMMEDIATE GENERTAOR
    mux2_4 u_mux 
    (
        .a(i_immo),
        .b(s_immo),
        .c(sb_immo),
        .d(uj_immo),
        .e(u_immo),
        .sel(imm_sel),
        .out(m2out)
    );

    assign u_immediate = u_immo;

     assign opb_data = op_b ;

  

     //PROGRAM COUNTER OR OPERAND A
    mux u_mux4 
    (
        .a(op_a),
        .b(program_counter),
        .sel(operand_a),
        .out(opa_mux_out)
    );

     // OPERAND B OR IMMEDIATE     
    mux u_mux0 (
        .a(op_b),
        .b(m2out),
        .sel(operand_b),
        .out(opb_mux_out)
    );

          //BRANCH
    branch u_branch0(
        .en(branchen),
        .op_a(op_a),
        .op_b(op_b),
        .fun3(data1[14:12]),
        .result(branch_result)
    );

    assign branch_on = branchen;

endmodule