

//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import struct_pkg::*;

class a_driver extends uvm_driver;

    `uvm_component_utils(a_driver)

    // A_B_req_if Interface (A_Driver side)
    virtual A_B_req_if A_B_req_if_vi;

    req_pkt req_pk = new();
    int transaction_num;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      // Get interface reference from config database
      if( !uvm_config_db #(virtual A_B_req_if)::get(this, "", "A_B_req_if", A_B_req_if_vi) )
        `uvm_error("", "uvm_config_db::get failed")
    endfunction

    task reset_outputs();
        `uvm_info( "A_DRIVER", " Reset_if.\n", UVM_LOW );
        A_B_req_if_vi.clocking_block_drv_a.Valid_Addr <= 0;
        A_B_req_if_vi.clocking_block_drv_a.Address <= 0;
    endtask : reset_outputs

    task make_transaction (req_pkt req_pkt_fields);
        `uvm_info( "A_DRIVER", $sformatf(" Drive_if with data = 0x%0h \n", req_pkt_fields.address), UVM_LOW );
        A_B_req_if_vi.clocking_block_drv_a.Valid_Addr <= 1;
        A_B_req_if_vi.clocking_block_drv_a.Address <= req_pkt_fields.address;
        repeat(2) @A_B_req_if_vi.clocking_block_drv_a;
        reset_outputs();

    endtask : make_transaction

    task run_phase(uvm_phase phase);

        @(posedge A_B_req_if_vi.clk);
        reset_outputs();
        @(posedge A_B_req_if_vi.clk);

        forever begin
            if (!req_pk.randomize() ) begin //Data randomisation
                `uvm_warning("RNDFLD", "Randomization failed for req_pk")
            end
            make_transaction(req_pk);
            transaction_num = transaction_num + 1;
            //make_transaction(12'b00010101010Z);
            repeat(20) @(posedge A_B_req_if_vi.clk); // Wait 20 cycles of clock before next request
        end
        
    endtask: run_phase

endclass : a_driver