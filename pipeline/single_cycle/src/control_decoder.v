module control_decoder (
    input wire [2:0] fun3,
    input wire fun7,
    input wire i_type,
    input wire r_type,
    input wire load,
    input wire store,
    input wire branch,
    input wire jal,
    input wire jalr,
    input wire lui,
    input wire auipc,

    output reg Load,
    output reg Store,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_en,
    output reg operand_b,
    output reg [2:0]imm_sel,
    output reg Branch,
    output reg Jal,
    output reg [1:0]rd_sel,
    output reg [3:0]alu_control,
    output reg Jalr,
    output reg Auipc,
    output reg Lui,
    output reg operand_a,
    output reg write_read
);

always @(*) begin
    reg_write = r_type | i_type | load | jal |jalr |lui |auipc;
    operand_b = i_type | load | store | branch | jal |jalr |auipc;
    operand_a = branch | jal | auipc ;
    //imm_sel = i_type | store| branch ;
    Load = load;
    Store = store;
    Branch =  branch;
    Jal = 1'b0;
    Jalr = 1'b0;
    Lui = lui;
    Auipc = auipc;

    if(r_type)begin //rtype
    rd_sel = 2'b00;
        if(fun3==3'b000 & fun7==0)begin
            alu_control = 4'b0000;
        end
        else if(fun3==3'b000 & fun7==1)begin
            alu_control = 4'b0001;
        end
        else if (fun3==3'b001 & fun7==0)begin
            alu_control = 4'b0010;
        end
        else if (fun3==3'b010 & fun7==0)begin
            alu_control = 4'b0011;
        end
        else if (fun3==3'b011 & fun7==0)begin
            alu_control = 4'b0100;
        end
        else if (fun3==3'b100 & fun7==0)begin
            alu_control = 4'b0101;
        end
        else if (fun3==3'b101 & fun7==0)begin
            alu_control = 4'b0110;
        end
        else if (fun3==3'b101 & fun7==1)begin
            alu_control = 4'b0111;
        end
        else if (fun3==3'b110 & fun7==0)begin
            alu_control = 4'b1000;
        end
        else if (fun3==3'b111 & fun7==0)begin
            alu_control = 4'b1001;
        end
    end
    else if (i_type)begin //itype
        rd_sel = 2'b00;
        imm_sel = 3'b001;//i_type selection
        if(fun3==3'b000 & fun7==0)begin
            alu_control = 4'b0000;
        end
        else if (fun3==3'b001 & fun7==0)begin
            alu_control = 4'b0010;
        end
        else if (fun3==3'b010 & fun7==0)begin
            alu_control = 4'b0011;
        end
        else if (fun3==3'b011 & fun7==0)begin
            alu_control = 4'b0100;
        end
        else if (fun3==3'b100 & fun7==0)begin
            alu_control = 4'b0101;
        end
        else if (fun3==3'b101 & fun7==0)begin
            alu_control = 4'b0110;
        end
        else if (fun3==3'b101 & fun7==1)begin
            alu_control = 4'b0111;
        end
        else if (fun3==3'b110 & fun7==0)begin
            alu_control = 4'b1000;
        end
        else if (fun3==3'b111 & fun7==0)begin
            alu_control = 4'b1001;
        end
    end
    else if (store) begin //store
       imm_sel = 3'b000;//store selection
        mem_en = 1;
        if (fun3==3'b000)begin //sb
            alu_control = 4'b0000;
            //signal = 2'b00;
        end
        else if (fun3==3'b001)begin //sh
            alu_control = 4'b0000;
            //signal = 2'b01;
        end
        else if (fun3==3'b010)begin //sw
            alu_control = 4'b0000;
            //signal = 2'b10;
        end
    end
    else if (load) begin
        rd_sel = 2'b01;
       imm_sel = 3'b001;//i_type selection
        if (fun3==3'b000)begin //lb
            alu_control = 4'b0000;
        end
        else if(fun3==3'b001)begin //lh
            alu_control = 4'b0000;
        end
        else if(fun3==3'b010)begin //lw
            alu_control = 4'b0000;
        end
        else if(fun3==3'b100)begin //lbu
            alu_control = 4'b0000;
        end
        else if(fun3==3'b101)begin //lhu
            alu_control = 4'b0000;
        end
        else if(fun3==3'b110)begin //lwu
            alu_control = 4'b0000;
        end
    end
    else if (branch)begin
        alu_control = 4'b0000;
        imm_sel = 3'b010;//branch selection
    end
    else if (jal)begin
        rd_sel = 2'b10;
        Jal = jal;
        alu_control = 4'b0000;
        imm_sel = 3'b011;//jal selection
    end
    else if(jalr)begin
        Jalr = jalr;
        rd_sel = 2'b10;
        alu_control = 4'b0000;
        imm_sel = 3'b001;//i_type selection
    end
        else if(lui)begin
        rd_sel = 2'b11;
        imm_sel = 3'b100;//u_type selection
    end
        else if(auipc)begin
        rd_sel = 2'b00;
        alu_control = 4'b0000;
        imm_sel = 3'b100;//u_type selection
    end
end

endmodule