class risc_generator;

risc_packet pkt;

mailbox #(risc_packet) gen_drv;

function new(mailbox #(risc_packet) gen_drv);
this.gen_drv = gen_drv;
endfunction

task run();
$display("generator output");

pkt = new();

assert(pkt.randomize())
begin
	$display("opcode = %b operand1 = %b operand2 = %b cin = %b",pkt.opcode,pkt.operand_1,pkt.operand_2,pkt.cin);
	gen_drv.put(pkt);
end
else
	$fatal("randomization failed");

$display("");
$display("");
endtask
endclass
