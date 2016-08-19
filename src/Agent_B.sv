

//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import struct_pkg::*;

class agent_b extends uvm_agent;

    `uvm_component_utils(agent_b)

    uvm_analysis_port #(req_pkt) b_side_analysis_port;
    
    b_monitor b_mon;
    b_driver b_drv;  
    b_sequencer b_seqr;  

    function new(string name, uvm_component parent);
      super.new(name, parent);
      b_seqr = new("b_seqr", this);
    endfunction

    function void build_phase(uvm_phase phase);
      b_mon = b_monitor::type_id::create("b_mon", this);
      b_drv = b_driver::type_id::create("b_drv", this);
      //b_seqr = b_sequencer::type_id::create("b_seqr", this);

      b_side_analysis_port = new ("b_side_analysis_port", this);

    endfunction

    // connections of ports
    function void connect_phase(uvm_phase phase);
      b_drv.seq_item_port.connect(b_seqr.seq_item_export);
      b_mon.b_side_analysis_port.connect(b_side_analysis_port);
      b_mon.b_side_analysis_port.connect(b_drv.b_side_analysis_mon_port);
    endfunction

  endclass: agent_b