interface dut_if(input clk,rst);
    logic [3:0] opcode;
    logic [3:0] operand_1;
    logic [7:0] operand_2;
    logic cin;
    logic [15:0] alu_op;
    logic cb;

clocking cb_risc @(posedge clk);
	default input #1 output #0;
	input alu_op;
	input cb;
	output opcode;
	output operand_1;
	output operand_2;
	output cin;
endclocking 
endinterface
