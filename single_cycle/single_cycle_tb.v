`timescale 1ns/1ps
module single_cycle_tb();
    reg clk;
    reg [31:0]instruction;
    reg rst;
    reg enable;
    wire[31:0] res_out;

    single_cycle u_single_cycle
    (
        .clk(clk),
        .instruction(instruction),
        .rst(rst),
        .en(enable)
    );

    initial begin
        clk = 0;
        rst = 1;
        #5;
        rst=0;
        enable = 0;
        #10;

        rst = 1;
        #40;

        $finish;       
    end
     initial begin
       $dumpfile("single.vcd");
       $dumpvars(0,single_cycle_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule