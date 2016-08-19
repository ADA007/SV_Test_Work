

//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

package struct_pkg;

class req_pkt extends uvm_sequence_item;
	  
		rand logic [11:0] address;

		//constraint address_c { address == 12'h155;}

		`uvm_object_utils_begin(req_pkt)
		   //////////////// Request Fields
		  `uvm_field_int( address, UVM_ALL_ON | UVM_NOPACK );

		`uvm_object_utils_end

		function new(string name= "req_pkt");
         super.new(name);
        endfunction

endclass

class resp_pkt extends uvm_sequence_item;
	  
		rand logic [23:0] data;
		rand int delay_time;

		constraint delay_time_c { delay_time inside {[1:10]};}
		//constraint data_c { data == 24'h115511;}

		`uvm_object_utils_begin(resp_pkt)
		   //////////////// Response Fields
		  `uvm_field_int( data, UVM_ALL_ON | UVM_NOPACK );
		  `uvm_field_int( delay_time, UVM_ALL_ON | UVM_NOPACK );

		`uvm_object_utils_end

		function new(string name= "resp_pkt");
         super.new(name);
        endfunction

endclass

endpackage