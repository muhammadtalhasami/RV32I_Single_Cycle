`timescale 1ns/1ps
module register_file_tb();
    reg  clk;
    reg  rst;
    reg  enable;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] data;

    wire [31:0]op_a;
    wire [31:0]op_b;

    register_file u_register_file0(
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .rs1(rs1),
        .rs2(rs2),
        .op_a(op_a),
        .op_b(op_b),
        .rd(rd),
        .data(data)
    );

    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        #10;

        rst = 0;
        enable = 1;
        data = 32'b00000000000000000000000000000001;
        rd = 5'b00001;
        #10

       
        rs1 = 5'b00001;
        #10;

        enable = 0;
        rs2 = 5'b00000;
        #10;

        rst = 1;
        rs1 = 5'b00001;
        #10;

        $finish;
        
    end

    initial begin
       $dumpfile("register.vcd");
       $dumpvars(0,register_file_tb);
    end

    always begin
        #5 clk= ~clk;
    end


endmodule