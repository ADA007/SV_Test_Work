

//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

package struct_pkg;

class req_pkt extends uvm_sequence_item;
	  
		typedef enum bit [1:0] {PKT_SHORT, PKT_MIDDLE, PKT_LONG} pkt_kind_t;

		rand logic [11:0] address;
		rand logic [3:0] pkt_len;
		rand pkt_kind_t pkt_kind;

		constraint address_c { address > 12'd15;} //make 4 little bits zero's only
		constraint pkt_len_c { 
			pkt_len > 1; // addition condition if it happens accidentally
			if (pkt_kind == PKT_SHORT) { pkt_len inside {[2:3]}; }
			else if (pkt_kind == PKT_MIDDLE) { pkt_len inside {[4:7]}; }
			else { pkt_len inside {[8:15]}; }
		}

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