module core_main (
    input wire clk,
    input wire enable,
    input wire rst,
    input wire [31:0]instruction
    );

    wire [31:0] instruction_data;
    wire [31:0] pc_address;
    wire [31:0] load_data_out;
    wire [31:0] alu_out_address;
    wire [31:0] store_data;
    wire [3:0]  mask;
    wire [3:0]  instruc_mask_singal;
    wire instruction_mem_we_re;
    wire instruction_mem_request;
    wire instruc_mem_valid;
    wire data_mem_valid;
    wire data_mem_we_re;
    wire data_mem_request;
    wire store;
    wire load;

    // INSTRUCTION MEMORY
    instruc_mem_top#(
      .INIT_MEM(1)
    )
    u_instruction_mem0 (
        .rst(rst),
        .clk(clk),
        .we_re(instruction_mem_we_re),
        .request(instruction_mem_request),
        .masking(instruc_mask_singal),
        .address(pc_address[9:2]),
        .w_data(instruction),
        .valid(instruc_mem_valid),
        .r_data(instruction_data)
    );

    //CORE
    core u_core(
        .clk(clk),
        .rst(rst),
        .load_signal(load),
        .instruction(instruction_data),
        .load_data_in(load_data_out),
        .mask_singal(mask),
        .instruc_mask_singal(instruc_mask_singal),
        .instruction_mem_we_re(instruction_mem_we_re),
        .instruction_mem_request(instruction_mem_request),
        .data_mem_we_re(data_mem_we_re),
        .data_mem_request(data_mem_request),
        .instruc_mem_valid(instruc_mem_valid),
        .data_mem_valid(data_mem_valid),
        .store_data_out(store_data),
        .pc_address(pc_address),
        .alu_out_address(alu_out_address)
    );


    // DATA MEMORY
    data_mem_top u_data_memory0(
        .clk(clk),
        .rst(rst),
        .load(load),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .address(alu_out_address[9:2]),
        .w_data(store_data),
        .masking(mask),
        .valid(data_mem_valid),
        .r_data(load_data_out)
    );
endmodule