
class risc_monitor;
risc_packet pkt;
probe_packet ppkt;
mailbox #(probe_packet)mon_sb;
virtual dut_if i;
virtual probe_intf pi;

function new (mailbox #(probe_packet)mon_sb,virtual dut_if i,virtual probe_intf pi);
this.mon_sb = mon_sb;
this.i = i;
this.pi = pi;
endfunction

task run();
	$display("monitor output");
	pkt = new();
	ppkt = new();
	
	@(i.cb_risc);
	pkt.opcode = i.cb_risc.opcode;
	pkt.operand_1 = i.cb_risc.operand_1;
	pkt.operand_2 = i.cb_risc.operand_2;
	pkt.cin = i.cb_risc.cin;
	pkt.alu_op  = i.cb_risc.alu_op;
	pkt.cb = i.cb_risc.cb;
	
	@(pi.cb_probe);
	ppkt.opcode = pi.cb_probe.opcode;
	ppkt.operand_1 = pi.cb_probe.operand_1;
	ppkt.operand_2 = pi.cb_probe.operand_2;
	ppkt.cs = pi.cb_probe.cs;
	ppkt.rw=pi.cb_probe.rw;
	ppkt.wb=pi.cb_probe.wb;
	ppkt.data_out = pi.cb_probe.data_out;
	ppkt.alu_operation = pi.cb_probe.alu_operation;
	ppkt.alu_opr1 = pi.cb_probe.alu_opr1;
	ppkt.alu_opr2 = pi.cb_probe.alu_opr2;
	ppkt.address = pi.cb_probe.address;

	mon_sb.put(ppkt);
	$display("mon_sb opcode = %b operand_1 = %b operand_2 = %b address =%b data_out = %b alu_operation =%b alu_opr1 =%b alu_opr2 = %b cs =%b rw =%b wb =%b",ppkt.opcode,ppkt.operand_1,ppkt.operand_2,ppkt.address,ppkt.data_out,ppkt.alu_operation,ppkt.alu_opr1,ppkt.alu_opr2,ppkt.cs,ppkt.rw,ppkt.wb);
	
	$display("mon_sb opcode = %b operand_1 = %b operand_2 = %b address =%b data_out = %b alu_operation =%b alu_opr1 =%b alu_opr2 = %b cs =%b rw =%b wb =%b",pi.opcode,pi.operand_1,pi.operand_2,pi.address,pi.data_out,pi.alu_operation,pi.alu_opr1,pi.alu_opr2,pi.cs,pi.rw,pi.wb);

	$display("dut_pkt : opcode =%b operand_1 =%b operand_2 = $b cin =%b alu_op =%b cb =%b ",pkt.opcode,pkt.operand_1,pkt.operand_2,pkt.cin,pkt.alu_op,pkt.cb);
	$display("");
	$display("");
endtask
endclass

