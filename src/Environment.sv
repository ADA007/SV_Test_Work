  
`include "uvm_pkg.sv"
import uvm_pkg::*;

class a_b_environment extends uvm_env;

    `uvm_component_utils(a_b_environment)
    
    a_b_agent agent;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      agent = a_b_agent::type_id::create("agent", this);
    endfunction

 endclass