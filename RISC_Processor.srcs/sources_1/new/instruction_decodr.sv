
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2020 06:38:58 PM
// Design Name: 
// Module Name: instruction_decodr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_decodr(
    input clk,
    input rst,
    input [3:0] opcode,
    input [3:0] operand_1,
    input [7:0] operand_2,
    input [15:0] data_out,
    output logic rw,
    output logic cs,
    output logic [3:0] address,
    output logic [3:0] alu_operation,
    output logic [15:0] alu_opr1,
    output logic  [7:0] alu_opr2,
    output logic wb
    );
   logic [2:0]state,next;
   
   parameter INIT = 3'b000,FETCH = 3'b001,DECODE = 3'b010,EXECUTE = 3'b011,LOAD = 3'b100;
   always @(posedge clk)
   begin
   if(rst)
        state <= INIT;
   else
        state <= next;
   end
   always @(posedge clk)
   begin    
        case(state)
        
        INIT :  next <= FETCH;
 
        FETCH : begin
                next <= DECODE;
                alu_operation <= opcode;
                address <= operand_1;
                alu_opr2 <= operand_2;
                rw <= 1'b1;
                cs <= 1'b1;
                wb <= 1'b0;
                end
            
        DECODE : begin
                 next <= EXECUTE;
                 alu_opr1 <= data_out;
                 rw <= 1'b0;
                 cs <= 1'b0;
                 wb <= 1'b0;
                 end
        EXECUTE : begin
                  next <= LOAD;
                  alu_opr1 <= data_out;
                  cs <= 1'b1;
                  wb <= 1'b1;
                  rw <= 1'b0;
                  end
        LOAD : begin
               next <= FETCH;
               cs <= 1'b0;
               wb <= 1'b0;
               rw <= 1'b0;    
               end
        default : next <=FETCH;
       endcase       
   end
   
endmodule