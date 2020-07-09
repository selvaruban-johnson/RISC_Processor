//`include "risc_packet.sv"
//`include "probe_packet.sv"

class risc_ram_monitor;

risc_packet pkt;
probe_packet ppkt;

mailbox #(probe_packet) mon_sb;

virtual dut_if i;
virtual probe_intf pi;

function new(mailbox #(probe_packet)mon_sb ,virtual dut_if i,virtual probe_intf pi);
	this.mon_sb =mon_sb;
	this.i = i;
	this.pi= pi;
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
	ppkt.rw = pi.cb_probe.rw;
	ppkt.cs = pi.cb_probe.cs;
	ppkt.address = pi.cb_probe.address;
	ppkt.data_in = pi.cb_probe.data_in;
	ppkt.data_out = pi.cb_probe.data_out;
	
	mon_sb.put(ppkt);
	$display("mon_sb :  rw = %b cs = %b address =%b data_in = %b  data_out =%b",ppkt.rw,ppkt.cs,ppkt.address,ppkt.data_in,ppkt.data_out);
	
	$display("probe intf: rw = %b cs = %b address =%b data_in = %b  data_out =%b",pi.rw,pi.cs,pi.address,pi.data_in,pi.data_out);

	$display("dut_pkt : opcode =%b operand_1 =%b operand_2 = $b cin =%b alu_op =%b cb =%b ",pkt.opcode,pkt.operand_1,pkt.operand_2,pkt.cin,pkt.alu_op,pkt.cb);
	$display("");
	$display("");
endtask
endclass
