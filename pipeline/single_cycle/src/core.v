module core(
    input wire clk,
    input wire rst,
    input wire data_mem_valid,
    input wire instruc_mem_valid,
    input wire [31:0] instruction,
    input wire [31:0] load_data_in,
    
    output wire load_signal,
    output wire instruction_mem_we_re,
    output wire instruction_mem_request,
    output wire data_mem_we_re,
    output wire data_mem_request,
    output wire [3:0]  instruc_mask_singal,
    output wire [3:0]  mask_singal,
    output wire [31:0] store_data_out,
    output wire [31:0] alu_out_address,
    output wire [31:0] pc_address
);

    wire [31:0]instruc_data_out;
    wire [31:0] pc_address_out;
    wire load;
    wire store;
    wire Jal;
    wire Jalr;
    wire Branch_on;
    wire [31:0] rd_wb_data;
    wire branch_result;
    wire [3:0]mask;
    wire [31:0] op_b;
    wire [31:0] opa_mux_out;
    wire [31:0] opb_mux_out;
    wire [31:0] u_immediate;
    wire [1:0] rd_sel;
    wire [3:0] alu_control;
    wire [31:0]alu_res_out;
    wire [31:0] wrap_load_out;
    wire [31:0] opb_data;
    wire [31:0] pre_address_pc;
    wire [31:0] pre_address_pc_pp;
    wire [31:0] instruc_data_out_pp;
    // FETCH_STAGE
    Fetch_stage u_fetch_stage0 
    (
        .clk(clk),
        .rst(rst),
        .jal(Jal),
        .jalr(Jalr),
        .Branch(Branch_on),
        .b_result(branch_result),
        .instruction_fetch(instruction),
        .instruction(instruc_data_out),
        .address_in(0),
        .load(load),
        .alu_res(alu_res_out),
        .valid(data_mem_valid),
        .mask(instruc_mask_singal),
        .we_re(instruction_mem_we_re),
        .request(instruction_mem_request),
        .pre_address_pc(pre_address_pc),
        .address_out(pc_address)
    );

    //fetch_pipeline
    Fetch_pipe u_fet_pip0
    (
        .clk(clk),
        .Jal(Jal),
        .Jal_r(Jalr),
        .load(load),
        .branch(branch_result),
        .pre_address_pc(pre_address_pc),
        .instruction(instruc_data_out),
        .pre_address_pc_pp(pre_address_pc_pp),
        .instruction_pp(instruc_data_out_pp)
    );

    //DECODE STAGE
    decode_stage u_dec0(
        .clk(clk),
        .rst(rst),
        .valid(data_mem_valid),
        .data1(instruc_data_out_pp),
        .program_counter(pre_address_pc_pp),
        .rd_wb_data(rd_wb_data),
        .load(load),
        .store(store),
        .Jal(Jal),
        .Jalr(Jalr),
        .branch_on(Branch_on),
        .branch_result(branch_result),
        .opb_data(op_b),
        .u_immediate(u_immediate),
        .rd_sel(rd_sel),
        .alu_control(alu_control),
        .opa_mux_out(opa_mux_out),
        .opb_mux_out(opb_mux_out)
    );
    
    assign load_signal =load;
    //EXECUTE_STAGE
    execute u_execute0 
    (
        .a_i(opa_mux_out),
        .b_i(opb_mux_out),
        .alu_control(alu_control),
        .alu_out(alu_res_out)
    );

    //MEMORY_STAGE
    memory_stage u_memory_stage(
        .load(load),
        .store(store),
        .op_b(op_b),
        .instruction(instruc_data_out_pp),
        .alu_out_address(alu_res_out),
        .wrap_load_in(load_data_in),
        .mask(mask),
        .valid(instruc_mem_valid),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .store_data_out(store_data_out),
        .wrap_load_out(wrap_load_out)
    );
    assign alu_out_address = alu_res_out ;
    assign mask_singal = mask ;

    //WRITE_BACK_STAGE
    write_back u_writeback_stage2 (
        .mem_to_reg(rd_sel),
        .alu_out(alu_res_out),
        .data_mem_out(wrap_load_out),
        .pc_address(pre_address_pc_pp),
        .u_immo(u_immediate),
        .rd_sel_mux_out(rd_wb_data)
    );    
    
endmodule