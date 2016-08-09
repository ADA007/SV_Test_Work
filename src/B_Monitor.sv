
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class b_monitor extends uvm_monitor;

    `uvm_component_utils(b_monitor)

    //uvm_tlm_fifo fifo;
    uvm_analysis_port #(int) analysis_port;

    // A_B_req_if Interface (Monitor side)
    virtual A_B_req_if A_B_mon_if_vi;
   

    function new(string name = "scoreboard", uvm_component parent = null);
      super.new(name, parent);
      //fifo = new("fifo", this);
      analysis_port = new ("analysis_port", this);
    endfunction
    
    function void build_phase(uvm_phase phase);
      // Get interface reference from config database
      if( !uvm_config_db #(virtual A_B_req_if)::get(this, "", "A_B_req_if", A_B_mon_if_vi) )
        `uvm_error("", "uvm_config_db::get failed")
    endfunction 

    task run_phase(uvm_phase phase);
 
        forever begin

            // Wait for valid address
            @(posedge A_B_mon_if_vi.clocking_block_mon.Valid_Addr);
            `uvm_info( "MONITOR", $sformatf(" Monitor catch transaction. 0x%0h\n", A_B_mon_if_vi.clocking_block_mon.Address), UVM_LOW );

            //Check data for U Z X
            if ($isunknown(A_B_mon_if_vi.clocking_block_mon.Address)) `uvm_info( "MONITOR", $sformatf(" address=%b has x's \n", A_B_mon_if_vi.clocking_block_mon.Address), UVM_LOW );
            //Send data in to Scoreboard
            analysis_port.write(A_B_mon_if_vi.clocking_block_mon.Address);
            // Running Sequence
            phase.raise_objection(this, "Starting Sequence");
            //b_seq.start(b_seqr);
            phase.drop_objection(this, "Finishing Sequence");

        end // forever
    endtask: run_phase

endclass: b_monitor

