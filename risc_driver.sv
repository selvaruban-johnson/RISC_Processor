
class risc_driver;
risc_packet pkt;
mailbox #(risc_packet) gen_drv;
virtual dut_if i;

function new(mailbox #(risc_packet) gen_drv,virtual dut_if i);
this.gen_drv = gen_drv;
this.i = i;
endfunction

task run();
$display("driver_output");
gen_drv.get(pkt);

@(i.cb_risc);
i.cb_risc.opcode <= pkt.opcode;
i.cb_risc.operand_1 <= pkt.operand_1;
i.cb_risc.operand_2 <= pkt.operand_2;
i.cb_risc.cin <= pkt.cin;

$display("interface : opcode = %b operand_1 = %b operand_2 = %b cin = %b",i.opcode,i.operand_1,i.operand_2,i.cin);
$display("dut_pkt : opcode = %b operand_1 = %b operand_2 = %b cin = %b",pkt.opcode,pkt.operand_1,pkt.operand_2,pkt.cin);

$display("");
$display("");
endtask
endclass
