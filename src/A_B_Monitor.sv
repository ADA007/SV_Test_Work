`include "uvm_pkg.sv"
import uvm_pkg::*;

class a_b_monitor extends uvm_monitor;

    `uvm_component_utils(a_b_monitor)

    uvm_tlm_fifo fifo;

    int fifo_data;

    // A_B_req_if Interface (Monitor side)
    virtual A_B_req_if A_B_mon_if_vi;

     function new(string name, uvm_component parent);
      super.new(name, parent);
      fifo = new("fifo", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
      // Get interface reference from config database
      if( !uvm_config_db #(virtual A_B_req_if)::get(this, "", "A_B_req_if", A_B_mon_if_vi) )
        `uvm_error("", "uvm_config_db::get failed")
    endfunction 

    task run_phase(uvm_phase phase);
 
        forever begin

            // Wait for valid address
            @(posedge A_B_mon_if_vi.clocking_block_mon.Valid);
            `uvm_info( "MONITOR", $sformatf(" Monitor catch transaction. 0x%0h\n", A_B_mon_if_vi.clocking_block_mon.Address), UVM_LOW );

            //Check data for U Z X
            if ($isunknown(A_B_mon_if_vi.clocking_block_mon.Address)) `uvm_info( "MONITOR", $sformatf(" address=%b has x's \n", A_B_mon_if_vi.clocking_block_mon.Address), UVM_LOW );

            //Save data in to fifo
            fifo.put(A_B_mon_if_vi.clocking_block_mon.Address);
            `uvm_info( "MONITOR", $sformatf(" Wrote data in to fifo %0d \n",  fifo.used()), UVM_LOW );
            fifo.get(fifo_data); // Checking wrote data
            `uvm_info( "MONITOR", $sformatf(" Read data from fifo. 0x%0h, In fifo now %0d \n", fifo_data,  fifo.used()), UVM_LOW );

        end // forever
    endtask: run_phase

endclass: a_b_monitor

