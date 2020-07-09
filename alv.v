
module alv(
    input [15:0] alu_operand_1,
    input [15:0] alu_operand_2,
    input [3:0] alu_operation,
    input cin,
    input clk,
    input rst,
    output reg [15:0] alu_op,
    output reg cb
    );
    always @(posedge clk)
    begin
        if(rst)
        begin
            alu_op <= 1'b0;
            cb <= 1'b0;
        end
        else
        begin
            case(alu_operation)
            4'b0000 : if(~cin)
                      begin
                        alu_op <= alu_operand_1 + alu_operand_2 ;
                      end
                      else
                      begin
                        {cb,alu_op} <= alu_operand_1 + alu_operand_2;
                      end
           4'b0001 : if(cin)
                      begin
                        alu_op <= alu_operand_1 - alu_operand_2 ;
                      end
                      else
                      begin
                        {cb,alu_op} <= alu_operand_1 - alu_operand_2;
                      end
           4'b0010 : if(cin)
                     begin
                        alu_op <= alu_operand_1 + 1'b1;
                     end
           4'b0011 : alu_op <= alu_operand_1 - 1'b1;
           
           4'b0100 : alu_op <= alu_operand_1 & alu_operand_2;
           
           4'b0101 : alu_op <= alu_operand_1 | alu_operand_2;
           
           4'b0110 : alu_op <= ~alu_operand_1;
           
           4'b1000 : alu_op <= ~(alu_operand_1 & alu_operand_2);
           
           4'b1001 : alu_op <= ~(alu_operand_1 | alu_operand_2);
           
           4'b1010 : alu_op <= (alu_operand_1 ^ alu_operand_2);

           4'b1011 : alu_op <= ~(alu_operand_1 ^ alu_operand_2);

           4'b1100 : alu_op <= (alu_operand_1 << 1);
           
           4'b1101 : alu_op <= (alu_operand_1 >> 1);
           
           4'b1110 : alu_op <= ({alu_operand_1[14:0],alu_operand_1[15]});

           4'b1111 : alu_op <= ({alu_operand_1[15],alu_operand_1[14:0]});
           default : {cb,alu_op} <= 1'b0;
            endcase
        end
    end
endmodule
