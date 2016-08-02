
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class a_b_agent extends uvm_agent;

    `uvm_component_utils(a_b_agent)
    
    a_b_monitor a_b_mon;
    a_b_driver a_b_drv;
    a_b_scoreboard a_b_scb;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      a_b_drv = a_b_driver::type_id::create("a_b_drv", this);
      a_b_mon = a_b_monitor::type_id::create("a_b_mon", this);
      a_b_scb = a_b_scoreboard::type_id::create("a_b_scb", this);
    endfunction

  endclass