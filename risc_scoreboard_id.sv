//`include"probe_packet.sv"
class risc_scoreboard;

probe_packet ppkt;

mailbox #(probe_packet) mon_sb;

    logic [3:0] sb_opcode;
    logic [3:0] sb_operand_1;
    logic [7:0] sb_operand_2;
    logic [15:0] sb_data_out;
    

    logic sb_rw;
    logic sb_cs;
    logic [3:0] sb_address;
    logic [3:0] sb_alu_operation;
    logic [15:0] sb_alu_opr1;
    logic [7:0] sb_alu_opr2;
    logic sb_wb;
    
    enum{INIT,FETCH,DECODE,EXECUTE,LOAD}sb_state,sb_next;
function new (mailbox #(probe_packet)mon_sb);
this.mon_sb = mon_sb;
endfunction

task run();
	$display("scoreboard output");
	ppkt = new();
	mon_sb.get(ppkt);
	sb_opcode = ppkt.opcode;
	sb_operand_1 = ppkt.operand_1;
	sb_operand_2 = ppkt.operand_2;
	sb_data_out = ppkt.data_out;

        case(sb_state)
       
        sb_state'(0) :  sb_next = sb_state'(1);
        sb_state'(1) : begin
                sb_alu_operation = sb_opcode;
                sb_address = sb_operand_1;
                sb_alu_opr2 = sb_operand_2;
                sb_rw = 1'b1;
                sb_cs = 1'b1;
                sb_wb = 1'b0;
                sb_next = sb_state'(2);
                end
            
        sb_state'(2) : begin
                 sb_alu_opr1 = sb_data_out;
                 sb_rw = 1'b0;
                 sb_cs = 1'b0;
                 sb_wb = 1'b0;
                 sb_next = sb_state'(3);
                 end
        sb_state'(3) : begin
                  sb_alu_opr1 = sb_data_out;
                  sb_cs = 1'b1;
                  sb_wb = 1'b1;
                  sb_rw = 1'b0;
                  sb_next = sb_state'(4);
                  end
        sb_state'(4) : begin
               sb_cs = 1'b0;
               sb_wb = 1'b0;
               sb_rw = 1'b0;
               sb_next = sb_state'(1);     
               end
         endcase

	assert (ppkt.address == sb_address)
		$display("address match");
	else
		$display("address mismatch");
	
	assert (ppkt.alu_operation == sb_alu_operation)
		$display("alu_operation match");
	else
		$display("alu_operation mismatch");
	assert (ppkt.alu_opr1 == sb_alu_opr1)
		$display("alu_opr1 match");
	else
		$display("alu_opr1 mismatch");
	assert (ppkt.alu_opr2 == sb_alu_opr2)
		$display("alu_opr2 match");
	else
		$display("alu_opr2 mismatch");
	assert (ppkt.rw == sb_rw)
		$display("rw match");
	else
		$display("rw mismatch");
	assert (ppkt.cs == sb_cs)
		$display("cs match");
	else
		$display("cs mismatch");
	assert (ppkt.wb == sb_wb)
		$display("wb match");
	else
		$display("wb mismatch");

	$display("probe_pkt: opcode = %b operand_1 =%b operand_2 = %b data_out = %b address = %b alu_operation = %b alu_opr1 = %b alu_opr2 = %b rw =%b wb =%b cs = %b",ppkt.opcode,ppkt.operand_1,ppkt.operand_2,ppkt.data_out,ppkt.address,ppkt.alu_operation,ppkt.alu_opr1,ppkt.alu_opr2,ppkt.rw,ppkt.wb,ppkt.cs);
	$display("dummy: opcode = %b operand_1 =%b operand_2 = %b data_out = %b address = %b alu_operation = %b alu_opr1 = %b alu_opr2 = %b rw =%b wb =%b cs = %b",sb_opcode,sb_operand_1,sb_operand_2,sb_data_out,sb_address,sb_alu_operation,sb_alu_opr1,sb_alu_opr2,sb_rw,sb_wb,sb_cs);
endtask
	task init();
		sb_next = sb_state'(0);
	endtask

endclass
