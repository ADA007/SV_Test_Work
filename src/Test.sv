`timescale 1ns/1fs

program Test_Program (A_B_req_if UI);

	`include "./src/A_B_Monitor.sv"
	`include "./src/A_B_Driver_DUT.sv"

	a_b_monitor a_b_mon = new(UI.iUVC_B);
	a_b_driver a_b_drv = new(UI.DUT_A);

	initial begin
		#10;
		$display ("@%0d : Start test", $time);
		fork
			a_b_mon.monitoring();
			a_b_drv.make_transaction(12'h55);
		join_any;
		$display ("@%0d : Stop test", $time);
		$finish;
	end

endprogram