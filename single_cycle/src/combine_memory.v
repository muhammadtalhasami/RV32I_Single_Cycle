module c_mem#
(
    parameter  INIT_MEM = 0
)(
    input wire clk,
    input wire [7:0] address,
    input wire [31:0] w_data,
    input wire [3:0] masking,
    input wire we_re,

    output reg [31:0] r_data
);

    reg [31:0] mem [0:255];

    initial begin
         if (INIT_MEM)
        $readmemh("tb/instr.mem",mem);
   end
    always @ (posedge clk) begin 
        if(we_re)begin
            // mem[address] <= w_data;

            if(masking[0]) begin
                mem[address][7:0] <= w_data[7:0];
            end
            if(masking[1]) begin
                mem[address][15:8] <= w_data[15:8];
            end
            if(masking[2]) begin
                mem[address][23:16] <= w_data[23:16];
            end
            if(masking[3]) begin
                mem[address][31:24] <= w_data[31:24];
            end
        end

        else if(!we_re)begin
            r_data<= mem[address];
        end
    end
endmodule