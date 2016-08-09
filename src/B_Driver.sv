`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
import struct_pkg::*;

class b_driver extends uvm_driver #(resp_pkt);

  `uvm_component_utils(b_driver)

  // A_B_req_if Interface (B_Driver side)
  virtual A_B_req_if A_B_req_if_vi;

  function new(string name, uvm_component parent);
      super.new(name, parent);
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

   task make_response (logic [23:0] data_24);
        `uvm_info( "B_DRIVER", $sformatf(" Drive_if with data = 0x%0h \n", data_24), UVM_LOW );
        A_B_req_if_vi.clocking_block_drv_b.Valid_Data <= 1;
        A_B_req_if_vi.clocking_block_drv_b.Data <= data_24;
        repeat(2) @A_B_req_if_vi.clocking_block_drv_b;
        reset_outputs();
        $finish;
   endtask : make_response

  task run_phase(uvm_phase phase);
    resp_pkt resp_pk;
    while (1) begin
      `uvm_info( "B_DRIVER", $sformatf(" Response with data = 0x%0h \n", 8'h11), UVM_LOW );
      seq_item_port.get_next_item(resp_pk);
      `uvm_info( "B_DRIVER", $sformatf(" Response with data = 0x%0h \n", 8'h22), UVM_LOW );
      //make_response(req.data);
    //  #10;
      seq_item_port.item_done();
    end

  endtask: run_phase

endclass: b_driver