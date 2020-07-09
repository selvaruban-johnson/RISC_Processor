//`include "probe_packet.sv"
class risc_alu_scoreboard;

probe_packet ppkt;

mailbox #(probe_packet)mon_sb;

logic [15:0] sb_alu_opr_1 ,sb_alu_opr_2;
logic [3:0] sb_alu_opr;
logic [15:0] sb_alu_op;
logic sb_cin;
logic sb_cb;

function new(mailbox #(probe_packet)mon_sb);
	this.mon_sb = mon_sb;
endfunction

task run();
	$display("scoreboard output");
	ppkt = new();
	mon_sb.get(ppkt);
	sb_alu_opr_1 = ppkt.alu_operand_1;
	sb_alu_opr_2 = ppkt.alu_operand_2;
	sb_alu_opr = ppkt.alu_operation;
	sb_cin = ppkt.cin;

	if(sb_alu_opr == 4'b0000)
          if(~sb_cin)
           begin
              sb_alu_op = sb_alu_opr_1 + sb_alu_opr_2 ;
           end
           else
           begin
              {sb_cb,sb_alu_op} = sb_alu_opr_1 + sb_alu_opr_2;
           end
	
	else if (sb_alu_opr == 4'b0001)
          if(sb_cin)
           begin
              sb_alu_op = sb_alu_opr_1 - sb_alu_opr_2 ;
           end
           else
           begin
              {sb_cb,sb_alu_op} = sb_alu_opr_1 - sb_alu_opr_2;
           end

	else if (sb_alu_opr == 4'b0010)
	   if(sb_cin)
	   begin
		sb_alu_op = sb_alu_opr_1 + 1'b1;
	   end
	
	else if(sb_alu_opr == 4'b0011)
		sb_alu_op = sb_alu_opr_1 - 1'b1;
	
	else if (sb_alu_opr == 4'b0100)
		sb_alu_op = sb_alu_opr_1 & sb_alu_opr_2;

	else if (sb_alu_opr == 4'b0101)
		sb_alu_op = sb_alu_opr_1 | sb_alu_opr_2;
	
	else if (sb_alu_opr == 4'b0110)
		sb_alu_op = ~sb_alu_opr_1;

	else if (sb_alu_opr == 4'b1000)
		sb_alu_op = ~(sb_alu_opr_1 & sb_alu_opr_2);

	else if (sb_alu_opr == 4'b1001)
		sb_alu_op = ~(sb_alu_opr_1 | sb_alu_opr_2);

	else if (sb_alu_opr == 4'b1010)
		sb_alu_op = (sb_alu_opr_1 ^ sb_alu_opr_2);

	else if (sb_alu_opr == 4'b1011)
		sb_alu_op = ~(sb_alu_opr_1 ^ sb_alu_opr_2);

	else if (sb_alu_opr == 4'b1100)
		sb_alu_op = (sb_alu_opr_1<<1);

	else if (sb_alu_opr == 4'b1101)
		sb_alu_op = (sb_alu_opr_1>>1);

	else if (sb_alu_opr == 4'b1111)
		sb_alu_op = {sb_alu_opr_1[15],sb_alu_opr_1[14:0]};

	else if (sb_alu_opr == 4'b1110)
		sb_alu_op = ({sb_alu_opr_1[14:0],sb_alu_opr_1[15]});

	else
		{sb_cb,sb_alu_op} = 1'b0;

	assert (ppkt.alu_op == sb_alu_op)
		$display("alu_op match");
	else
		$error("alu_op mismatch");

	assert (ppkt.cb == sb_cb)
		$display("cb match");
	else
		$error("cb mis match");


	$display("probe packet : alu_operand_1 = %b alu_operand_2 = %b cin = %b alu_operation = %b alu_op =%b cb = %b",ppkt.alu_operand_1,ppkt.alu_operand_2,ppkt.cin,ppkt.alu_operation,ppkt.alu_op,ppkt.cb );

	$display("dummy :alu_operand_1 = %b alu_operand_2 = %b cin = %b alu_operation = %b alu_op =%b cb = %b",sb_alu_opr_1,sb_alu_opr_2,sb_cin,sb_alu_opr,sb_alu_op,sb_cb);

	$display("");
	$display("");
endtask

	task init();
            sb_alu_op = 1'b0;
            sb_cb = 1'b0;
	endtask
endclass 