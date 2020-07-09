//`include "probe_packet.sv"
class risc_ram_scoreboard;

probe_packet ppkt;

mailbox #(probe_packet) mon_sb;

    bit sb_rw;
    bit sb_cs;
    bit [3:0] sb_address;
    bit [15:0] sb_data_in;
    bit [15:0] sb_data_out;

    reg [15:0] mem [15:0];
function new (mailbox #(probe_packet)mon_sb);
	this.mon_sb = mon_sb;
endfunction

task run();

	$display("scoreboard output");
	ppkt = new();
	mon_sb.get(ppkt);

	sb_rw = ppkt.rw;
	sb_cs = ppkt.cs;
	sb_address = ppkt.address;
	sb_data_in = ppkt.data_in;
	sb_data_out = ppkt.data_out;
	
        if(sb_cs)
        begin
            if(~sb_rw)
               mem[sb_address] <= sb_data_in; 
            else
                sb_data_out <= mem[sb_address];
        end
	
	assert (sb_address == ppkt.address)
		$display("address match");
	else
		$error("address mismatch");
	
	assert (sb_data_out == ppkt.data_out)
		$display("data_out match");
	else
		$display("data_out mismatch");

	$display("probe packet : rw = %b cs =%b address = %b data_in = %b data_out = %b",ppkt.rw,ppkt.cs,ppkt.address,ppkt.data_in,ppkt.data_out);
	$display("dummy : rw = %B cs =%b addess = %b data_in = %b data_out = %b ",sb_rw,sb_cs,sb_address,sb_data_in,sb_data_out);
	$display("");
	$display("");
endtask
	task init();
	begin
       		mem[4'b0000] =16'h01;
    		mem[4'b0001 ]=16'h02;
    		mem[4'b0010] =16'h03;
    		mem[4'b0011] =16'h04;
    		mem[4'b0100] =16'h05;
    		mem[4'b0101] =16'h06;
    		mem[4'b0110] =16'h32;
    		mem[4'b0111] =16'h50;
    		mem[4'b1000] =16'h30;
    		mem[4'b1001] =16'h25;
    		mem[4'b1010] =16'h40;
    		mem[4'b1011] =16'h61;
    		mem[4'b1100] =16'h72;
    		mem[4'b1101] =16'h83;
    		mem[4'b1110] =16'h94;
    		mem[4'b1111]=16'h105;
    	end
	endtask
endclass
