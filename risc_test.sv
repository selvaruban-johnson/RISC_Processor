program risc_test(probe_intf pi,dut_if i);

	risc_environment dutenv;
	
	initial
	begin
		dutenv = new(pi,i);
		dutenv.build();
		
		repeat(65535)
		begin
		dutenv.run();
		if(pi.rst)
			dutenv.dutscb.init();
		$display("");
		$display("*******************************************************************************************************");
		$display("");
		#10 ;
		end

	end
endprogram

	