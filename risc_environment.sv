class risc_environment;

risc_packet pkt;
risc_generator dutgen;
risc_driver dutdrv;
risc_ram_monitor dutmon;
risc_coverage dutcov;
risc_ram_scoreboard dutscb;

virtual probe_intf pi;
virtual dut_if i;

mailbox #(risc_packet)gen_drv;
mailbox #(probe_packet)mon_sb;

function new (virtual probe_intf pi,virtual dut_if i);
	this.i = i;
	this.pi = pi;
endfunction

task build ();
	gen_drv = new();
	mon_sb = new();
	
	dutgen = new(gen_drv);
	dutdrv = new(gen_drv,i);
	dutmon = new(mon_sb,i,pi);
	dutscb = new(mon_sb);
	dutcov = new(i);
endtask

task run();
	dutgen.run();
	dutdrv.run();
	dutmon.run();
	dutcov.sample();
	dutscb.run();
endtask

endclass 