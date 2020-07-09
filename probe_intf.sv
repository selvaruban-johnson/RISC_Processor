interface probe_intf (input bit clk,rst,
			/*input bit[3:0]opcode,operand_1,
			input bit[3:0]address,alu_operation,
			input bit [7:0]operand_2,alu_opr2,
			input bit [15:0]data_out,alu_opr1,
			input bit rw,cs,wb*/
/* //alu
    			input bit [15:0] alu_operand_1,
    			input bit [15:0] alu_operand_2,
    			input bit [3:0] alu_operation,
 			input bit cin,
    			input bit [15:0] alu_op,
    			input bit cb);
*/
			  
			    input bit rw,
			    input bit cs,
			    input bit [3:0] address,
			    input bit [15:0] data_in,
			    input bit [15:0] data_out);

clocking cb_probe @(posedge clk);
default input #1 output #0;
	/*inout opcode,operand_1;
	inout address,alu_operation;
	inout operand_2,alu_opr2;
	inout data_out,alu_opr1;
	inout rw,cs,wb;*/
/*
	inout alu_operand_1,alu_operand_2;
	inout alu_operation;
	inout cin;
	inout alu_op;
	inout cb;
*/
    inout rw;
    inout cs;
    inout  address;
    inout  data_in;
    inout  data_out;

endclocking 
endinterface
