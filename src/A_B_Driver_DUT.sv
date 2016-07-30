`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class a_b_driver extends uvm_driver;

    `uvm_component_utils(a_b_driver)

    // A_B_req_if Interface (Driver side)
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
        `uvm_info( "DRIVER", " Reset_if.\n", UVM_LOW );
        A_B_req_if_vi.clocking_block_drv.Valid <= 0;
        A_B_req_if_vi.clocking_block_drv.Address <= 0;
    endtask : reset_outputs

    task make_transaction (logic [11:0] addr_12);
        `uvm_info( "DRIVER", $sformatf(" Drive_if with data = 0x%0h \n", addr_12), UVM_LOW );
        A_B_req_if_vi.clocking_block_drv.Valid <= 1;
        A_B_req_if_vi.clocking_block_drv.Address <= addr_12;
        repeat(2) @A_B_req_if_vi.clocking_block_drv;
        reset_outputs();
        repeat(2) @A_B_req_if_vi.clocking_block_drv;
        $finish;
    endtask : make_transaction

    task run_phase(uvm_phase phase);
        @(posedge A_B_req_if_vi.clk);
        reset_outputs();
        @(posedge A_B_req_if_vi.clk);
        //make_transaction(12'h555);
        make_transaction(12'b00000101010Z);
    endtask: run_phase

endclass : a_b_driver