class risc_coverage;

virtual dut_if i;
bit clk;

covergroup cg @(posedge i.clk);

	OP_CODE : coverpoint i.cb_risc.opcode;
	OPERAND__1 : coverpoint i.cb_risc.operand_1;
	OPERAND__2 : coverpoint i.cb_risc.operand_2;
	C_IN : coverpoint i.cb_risc.cin;
	ALU__OUT : coverpoint i.cb_risc.alu_op; /*{wildcard bins alu_op = {16'b0001??????000???, 16'b0001??????1?????, 16'b0101??????000???, 16'b0101??????1?????, 16'b1001??????111111};} */
	C_B : coverpoint i.cb_risc.cb;

endgroup

	function new(virtual dut_if i);
		this.i = i;
		this.clk = clk;
		cg = new();
	endfunction 
	
	task sample();
		cg.sample();
	endtask
endclass
