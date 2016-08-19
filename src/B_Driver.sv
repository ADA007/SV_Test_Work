
//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import struct_pkg::*;

class b_driver extends uvm_driver #(resp_pkt);

  `uvm_component_utils(b_driver)

  uvm_analysis_imp #(req_pkt, b_driver) b_side_analysis_mon_port;
  resp_pkt pkt = new;
  event e1;

  // A_B_req_if Interface (B_Driver side)
  virtual A_B_req_if A_B_req_if_vi;

  function new(string name, uvm_component parent);
      super.new(name, parent);
      b_side_analysis_mon_port = new("b_side_analysis_mon_port", this);
    endfunction

  function void build_phase(uvm_phase phase);
      // Get interface reference from config database
      if( !uvm_config_db #(virtual A_B_req_if)::get(this, "", "A_B_req_if", A_B_req_if_vi) )
        `uvm_error("", "uvm_config_db::get failed")
  endfunction

  task reset_outputs();
        `uvm_info( "B_DRIVER", " Reset_if.\n", UVM_LOW );
        A_B_req_if_vi.clocking_block_drv_b.Valid_Data <= 0;
        A_B_req_if_vi.clocking_block_drv_b.Data <= 0;
   endtask : reset_outputs

   task make_response (resp_pkt resp_pkt_fields);
        `uvm_info( "B_DRIVER", $sformatf(" Drive_if with data = 0x%0h with delay = %0d \n", resp_pkt_fields.data, resp_pkt_fields.delay_time), UVM_LOW );

        repeat(resp_pkt_fields.delay_time) @A_B_req_if_vi.clocking_block_drv_b; //Wait random cycle number before response
        A_B_req_if_vi.clocking_block_drv_b.Valid_Data <= 1;
        A_B_req_if_vi.clocking_block_drv_b.Data <= resp_pkt_fields.data;
        repeat(1) @A_B_req_if_vi.clocking_block_drv_b;
        reset_outputs();

   endtask : make_response

  function void write (req_pkt pkt_req);
    -> e1; //Trigg event for response
  endfunction

  task run_phase(uvm_phase phase);

    while (1) begin
     
      wait(e1.triggered); //Wait request transaction
      if (!pkt.randomize()  with {pkt.delay_time inside {[1:10]};} ) begin 
        `uvm_warning("RNDFLD", "Randomization failed for resp_pkt")
      end

      make_response(pkt);
      
    end

  endtask: run_phase

endclass: b_driver