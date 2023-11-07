module pc (
    input wire clk,
    input wire rst,
    input wire Branch,
    input wire dmem_valid,
    input wire load,
    input wire jal,
    input wire jalr,
    input wire b_result,
    input wire [31:0]branch_address,
    input wire [31:0]jal_address,
    input wire [31:0]jalr_address,
    input wire [31:0]address_in,

    output reg [31:0]address_out,
    output wire [31:0]pre_address_out
);

    reg [31:0]pre_address;

    always @(posedge clk or negedge rst) begin
        if(!rst)begin
            address_out <= 0;
        end
        else if (Branch && b_result)begin
            address_out <= branch_address;
        end
        else if (jal)begin
            address_out <= jal_address;
        end
        else if (jalr)begin
            address_out <= jalr_address;
        end
        else if((load && !dmem_valid))begin
            address_out <=  address_out;
        end
        else begin
            address_out <= address_out + 32'd4;
        end
        pre_address<=address_out;
    end
    
    assign pre_address_out = pre_address;
endmodule