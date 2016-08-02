  
`include "uvm_pkg.sv"
import uvm_pkg::*;

class testt extends uvm_test;
  
    `uvm_component_utils(testt)

    a_b_environment a_b_env;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      a_b_env = a_b_environment::type_id::create("a_b_env", this);
    endfunction
    
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);

      //phase.drop_objection(this);
    endtask
     
endclass: testt