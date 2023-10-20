`include "controlunit.v"
`include "mux1_2.v"
`include "rd_address.v"
`include "mux2_4.v"
`include "alu.v"
`include "reg_file.v"
`include "immediategene.v"
`include "instruction_memory.v"
`include "Fetch_stage.v"
`include "data_memory.v"
`include "wrapper_mem.v"
`include "branch.v"
module single_cycle (
    input wire clk,
    input wire en,
    input wire rst,
    input wire [31:0]instruction
);

    wire [31:0] data;
    wire auipc_en;
    wire Lui;
    wire operand_a;
    wire [31:0] i_immo;
    wire [31:0] s_immo;
    wire [31:0] sb_immo;
    wire [31:0] uj_immo;
    wire [31:0] u_immo;
    wire reg_write;
    wire [2:0]imm_sel;
    wire [1:0]rd_sel;
    wire mem_en;
    wire Jalren;
    wire loaden;
    wire branchen;
    wire operand_b;
    wire result;
    wire jal_en;
    wire out_sel;
    wire [3:0] mmaask;
    wire [3:0] alu_control;
    wire [31:0] op_a;
    wire [31:0] op_b;
    wire [31:0] out;
    wire [31:0] outz;
    wire [31:0] res_o;
    wire [31:0] inadd;
    wire [31:0] outadd;
    wire [31:0] m2out;
    wire [31:0] dmout;
    wire [31:0] dmin;
    wire [31:0] wlout;
    wire [31:0] m3data;

        // PROGRAM COUNTER
    pc u_pc0 
    (
        .clk(clk),
        .rst(rst),
        .jal(jal_en),
        .jalr(Jalren),
        .jal_address(res_o),
        .Branch(branchen),
        .b_result(result),
        .jalr_address(res_o),
        .branch_address(res_o),
        .address_in(0),
        .address_out(inadd)
    );

        // INSTRUCTION MEMORY
    instructionmemory u_im0 (
        .clk(clk),
        .enable(en),
        .address(inadd[9:2]),
        .data_in(instruction),
        .data_out(data)
    );

        // IMMEDIATE GENERATOR
    immediategen u_ig0 (
        .instr(data),
        .i_imme(i_immo),
        .sb_imme(sb_immo),
        .s_imme(s_immo),
        .uj_imme(uj_immo),
        .u_imme(u_immo)
    );

        // CONTROL UNIT
    controlunit u_cu0 
    (
        .opcode(data[6:0]),
        .fun3(data[14:12]),
        .fun7(data[30]),
        .reg_write(reg_write),
        .rd_sel(rd_sel),
        .imm_sel(imm_sel),
        .operand_b(operand_b),
        .mem_to_reg(mem_to_reg),
        .Jal(jal_en),
        .Load(loaden),
        .Store(Store),
        .Lui(Lui),
        .Auipc(auipc_en),
        .Branch(branchen),
        .mem_en(mem_en),
        .Jalr(Jalren),
        .operand_a(operand_a),
        .alu_control(alu_control)
    );

        // REGISTER FILE
    registerfile u_rf0 
    (
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .rs1(data[19:15]),
        .rs2(data[24:20]),
        .rd(data[11:7]),
        .data(m3data),
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

    // OPERAND B OR IMMEDIATE     
    mux u_mux0 (
        .a(op_b),
        .b(m2out),
        .sel(operand_b),
        .out(out)
    );

    //PROGRAM COUNTER OR OPERAND A
    mux u_mux4 
    (
        .a(op_a),
        .b(inadd),
        .sel(operand_a),
        .out(outz)
    );

        // ALU
    alu u_alu0 
    (
        .a_i(outz),
        .b_i(out),
        .op_i(alu_control),
        .res_o(res_o)
    );
        
        //BRANCH
    branch u_branch0(
        .en(branchen),
        .op_a(op_a),
        .op_b(op_b),
        .fun3(data[14:12]),
        .result(result)
    );

       //WRAPPER MEMORY | ALU_RESULT | JAL MUX | LUI ||AUIPC
    rd_address u_writeback_stage2 (
        .alu_out(res_o),
        .wrapermout(wlout),
        .jal_addr(inadd),
        .lui_addr(u_immo),
        .sel(rd_sel),
        .out(m3data)
    );  

        // WRAPPER MEMORY
    wrappermem u_wm0 (
        .data_i(op_b),
        .byteadd(res_o[1:0]),
        .fun3(data[14:12]),
        .mem_en(mem_en),
        .Load(loaden),
        .wrap_load_in(dmout),
        .masking(mmaask),
        .data_o(dmin),
        .wrap_load_out(wlout)
    );

        // DATA MEMORY
    datamemory u_dm0(
        .clk(clk),
        .mem_en(mem_en),
        .address(res_o[9:2]),
        .storein(dmin),
        .mask(mmaask),
        .loadout(dmout)
    );

endmodule