

//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

class agent_a extends uvm_agent;

    `uvm_component_utils(agent_a)
    
    a_driver a_drv;
    a_sequencer a_seqr;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      a_drv = a_driver::type_id::create("a_drv", this);
      a_seqr = a_sequencer::type_id::create("a_seqr", this);

      uvm_config_db#(uvm_object_wrapper)::set(this, "a_seqr.run_phase", "a_sequencer", a_sequencer::get_type());
    endfunction

    // connections of ports
    function void connect_phase(uvm_phase phase);
      a_drv.seq_item_port.connect(a_seqr.seq_item_export);
	endfunction

  endclass