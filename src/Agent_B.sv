
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class agent_b extends uvm_agent;

    `uvm_component_utils(agent_b)

    //uvm_tlm_fifo fifo;
    uvm_analysis_port #(int) analysis_port;
    
    b_monitor b_mon;
    b_driver b_drv;  
    b_sequencer b_seqr;  

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      b_mon = b_monitor::type_id::create("b_mon", this);
      b_drv = b_driver::type_id::create("b_drv", this);
      b_seqr = b_sequencer::type_id::create("b_seqr", this);

      //uvm_config_db#(uvm_object_wrapper)::set(this, "b_seqr.run_phase", "default_sequence", b_sequencer::get_type());
      uvm_config_db#(uvm_object_wrapper)::set(this, "b_seqr.run_phase", "b_sequencer", b_sequencer::get_type());

      analysis_port = new ("analysis_port", this);

    endfunction

    // connect drv port to sequencer port
    function void connect_phase(uvm_phase phase);
      b_drv.seq_item_port.connect(b_seqr.seq_item_export);
      b_mon.analysis_port.connect(analysis_port);
    endfunction

  endclass: agent_b