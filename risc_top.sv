`include "risc_header.svh"

module risc_top;

bit clk,rst;

always #5 clk++;

initial
begin
	rst = 1'b1;
	#100 rst = 1'b0;
end
	dut_if di(clk,rst);
	
	RISC r_top(.clk(clk),.rst(rst),.opcode(di.opcode),.operand_1(di.operand_1),.operand_2(di.operand_2),.cin(di.cin),.alu_op(di.alu_op),.cb(di.cb));

	//probe_intf pi(.clk(clk),.rst(rst),.opcode(r_top.il.opcode),.operand_1(r_top.il.operand_1),.operand_2(r_top.il.operand_2),.wb(r_top.il.wb),.data_out(r_top.il.data_out),.address(r_top.il.address),.rw(r_top.il.rw),.cs(r_top.il.cs),.alu_operation(r_top.il.alu_operation),.alu_opr1(r_top.il.alu_opr1),.alu_opr2(r_top.il.alu_opr2));

	//probe_intf pi(.clk(clk),.rst(rst),.alu_operand_1(r_top.vl.alu_operand_1),.alu_operand_2(r_top.vl.alu_operand_2),.alu_operation(r_top.vl.alu_operation),.cin(r_top.vl.cin),.alu_op(r_top.vl.alu_op),.cb(r_top.vl.cb));

	probe_intf pi (.clk(clk),.rst(rst),.rw(r_top.rl.rw),.cs(r_top.rl.cs),.address(r_top.rl.address),.data_in(r_top.rl.data_in),.data_out(r_top.rl.data_out));
	risc_test test(pi,di);
endmodule 