module data_mem_top #(
    parameter INIT_MEM = 0
)(
    input wire rst,
    input wire clk,
    input wire request,
    input wire [7:0] address,
    input wire [31:0] w_data,
    input wire [3:0] masking,
    input wire we_re,
    input wire load,

    output reg valid,
    output wire [31:0] r_data
    );

    always @(posedge clk or negedge rst ) begin
        if(!rst)begin
            valid<=0;
        end
        else begin
            valid <= load;
        end
    end

    c_mem #(
      .INIT_MEM(INIT_MEM)
    )
    u_mem0 (
        .clk(clk),
        .we_re(we_re),
        .masking(masking),
        .address(address),
        .w_data(w_data),
        .request(request),
        .r_data(r_data)
    );
endmodule