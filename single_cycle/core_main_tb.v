`timescale 1ns/1ps
module core_main_tb();
    reg clk;
    reg [31:0]instruction;
    reg rst;
    reg enable;
    wire[31:0] res_out;

    core_main u_core_main0
    (
        .clk(clk),
        .instruction(instruction),
        .rst(rst),
        .enable(enable)
    );

    initial begin
        clk = 0;
        rst = 1;
        #10;
       
        rst=0;
        enable = 0;
        #10;

        rst = 1;
        #100;
        #60;

        $finish;       
    end
     initial begin
       $dumpfile("coremain.vcd");
       $dumpvars(0,core_main_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule