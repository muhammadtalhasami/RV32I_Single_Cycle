module memory_top #(
    parameter INIT_MEM = 0
)(
    input wire clk,
    input wire request,
    input wire [7:0] address,
    input wire [31:0] w_data,
    input wire [3:0] masking,
    input wire we_re,

    output wire valid,
    output wire [31:0] r_data
    );

    c_mem #(
      .INIT_MEM(INIT_MEM)
    )
    u_instructionmem0 (
        .clk(clk),
        .we_re(we_re),
        .request(request),
        .masking(masking),
        .address(address),
        .w_data(w_data),
        .valid(valid),
        .r_data(r_data)
    );
endmodule