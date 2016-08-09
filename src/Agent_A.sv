
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class agent_a extends uvm_agent;

    `uvm_component_utils(agent_a)
    
    a_driver a_drv;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      a_drv = a_driver::type_id::create("a_drv", this);
    endfunction

  endclass