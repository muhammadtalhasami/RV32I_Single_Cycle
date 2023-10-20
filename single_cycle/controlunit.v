`include "dec_.v"
`include "control_decoder.v"
module controlunit (
    input wire [6:0] opcode,
    input wire [2:0] fun3,
    input wire fun7,

    output wire reg_write,
    output wire [2:0]imm_sel,
    output wire [1:0]rd_sel,
    output wire operand_b,
    output wire mem_to_reg,
    output wire Jal,
    output wire Jalr,
    output wire Load,
    output wire Store,
    output wire Branch,
    output wire mem_en,
    output wire Auipc,
    output wire Lui,
    output wire operand_a,
    output wire [3:0] alu_control
);

    wire r_type;
    wire i_type;
    wire load;
    wire store;
    wire jal;
    wire jalr;
    wire branch;
    wire lui;

    type_decoder utd0 (
        .opcode(opcode),
        .r_type(r_type),
        .i_type(i_type),
        .load(load),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc),
        .store(store)
    );

    control_decoder ucd0 (
        .fun3(fun3),
        .fun7(fun7),
        .i_type(i_type),
        .r_type(r_type),
        .load(load),
        .store(store),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .rd_sel(rd_sel),
        .Branch(Branch),
        .Load(Load),
        .Jal(Jal),
        .Jalr(Jalr),
        .Store(Store),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_en(mem_en),
        .operand_b(operand_b),
        .imm_sel(imm_sel),
        .lui(lui),
        .Lui(Lui),
        .auipc(auipc),
        .Auipc(Auipc),
        .operand_a(operand_a),
        .alu_control(alu_control)
    );

endmodule