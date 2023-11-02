module c_mem(
    input wire clk,
    input wire request,
    input wire [7:0] address,
    input wire [31:0] w_data,
    input wire [3:0] masking,
    input wire we_re,

    output reg valid,
    output reg [31:0] r_data
);

    reg [31:0] mem [0:255];

    initial begin
        $readmemh("tb/instr.mem",mem);
   end
    always @ (posedge clk) begin 
        valid <= 1'b0;
        if(request && we_re)begin
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

        if(request && we_re == 1'b0)begin
            valid <= 1'b1;
            r_data<= mem[address];
        end
    end
endmodule