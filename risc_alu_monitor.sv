//`include "risc_packet.sv"
//`include "probe_packet.sv"
class risc_alu_monitor;
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
	ppkt.alu_operand_1 = pi.cb_probe.alu_operand_1;
	ppkt.alu_operand_2 = pi.cb_probe.alu_operand_2;
	ppkt.alu_operation = pi.cb_probe.alu_operation;
	ppkt.cin=pi.cb_probe.cin;
	ppkt.alu_op=pi.cb_probe.alu_op;
	ppkt.cb = pi.cb_probe.cb;
	

	mon_sb.put(ppkt);
	$display("mon_sb :  alu_operand_1 = %b alu_operand_2 = %b alu_operation =%b cin = %b  alu_op =%b cb= %b",ppkt.alu_operand_1,ppkt.alu_operand_2,ppkt.alu_operation,ppkt.cin,ppkt.alu_op,ppkt.cb);
	
	$display("probe intf: alu_operand_1 = %b alu_operand_2 = %b alu_operation =%b cin = %b  alu_op =%b cb= %b",pi.alu_operand_1,pi.alu_operand_2,pi.alu_operation,pi.cin,pi.alu_op,pi.cb);

	$display("dut_pkt : opcode =%b operand_1 =%b operand_2 = $b cin =%b alu_op =%b cb =%b ",pkt.opcode,pkt.operand_1,pkt.operand_2,pkt.cin,pkt.alu_op,pkt.cb);
	$display("");
	$display("");
endtask
endclass
