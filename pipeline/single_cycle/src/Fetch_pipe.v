//THIS IS THE FETCH_PIPELINE MODULE. IN THIS MODULE WE TRYING TOO MAKE OUR PROGRAM COUNTER ALLIGNED WITH OUR
//INSTRUCTION BY FLUSHING AND INSTALLING 
//IN FLUSH WE MAKE THE WHOLE INSTRUCTION FLUSH SO THAT THE UN NECSSARY INSTRUCTIONS WILL NOT BE READ
//WHILE IN INSTALLING WE MAKE ASSIGNED PREVIOUS VALUE TOO THE LOAD
module Fetch_pipe(
    input wire clk,
    input wire [31:0]pre_address_pc,
    input wire [31:0]instruction,
    input wire branch,
    input wire Jal,
    input wire Jal_r,
    input wire load,
    
    output wire [31:0]pre_address_pc_pp,
    output wire [31:0]instruction_pp
);

    reg[31:0] pre_address_out;
    reg[31:0] instruct;
    reg flush;


    always@(posedge clk)begin
        //                  --------------FLUSH----------------
        // AS WE HAVE DONE PIPELINE ON FETCH STAGE WE HAVE TO FACE THE PLENTY OF 2 CYCLE SO SOLVING
        // THIS ISSUE WE NEED TO FLUSH THE INSTRUCTION IN THE  FETCH PIPELINE STAGE 
        // IF THE BRANCH IS TRUE OR WE HAVE JAL , JAL_R IS HIGH THEN WE HAVE TOO 
        // ASSGIN THE INSTRUCTION A 32 BIT 0 SO IN THIS WAY WE FLUSH THE INSTRUCTION FOR THE 1 CYCLE
        // FOR SOLVING THE ISSUE OF 2 CYCLE PLENTY WE NEED TOO FLUSH ALSO THE NEXT INSTRUCTION
        // SO FOR THIS WE USE FLUSH VARIABLE WHICH IS WORKING ON THE POSEDEGE OF CLOCK 
        // WHEN NEXT CYCLE COMES WE CHECK WHETHER THE FLUSH IS HIGH IF YES IT WILL FLUSH THE NEXT
        // INSTRUCTION TOO FOR FLUSH IS 0 INSTRUCTIONS WILL BE EXECUTE.
        //                  --------------FLUSH----------------
        
        if(branch | Jal | Jal_r)begin
            instruct <= 32'b0;
            flush <= 1'b1;
            pre_address_out <= 32'b0;
        end
        else if(flush)begin
            instruct <= 32'b0;
            flush <= 1'b0;
            pre_address_out <= 32'b0;
        end
        else if(load)begin
            pre_address_out <= pre_address_pc_pp;
            instruct <= instruction_pp;
        end
        else begin
            instruct <= instruction;
            flush <= 1'b0;
            pre_address_out <= pre_address_pc;
        end
    end

    assign pre_address_pc_pp = pre_address_out;
    assign instruction_pp = instruct;
 
endmodule
