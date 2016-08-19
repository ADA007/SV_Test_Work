  
//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

class testt extends uvm_test;
  
    `uvm_component_utils(testt)

    a_b_environment a_b_env;

    b_sequence x;

    function new(string name, uvm_component parent);
      super.new(name, parent);
      x = new("x_seqs");
    endfunction

    function void build_phase(uvm_phase phase);
      a_b_env = a_b_environment::type_id::create("a_b_env", this);
    endfunction

    task run_phase(uvm_phase phase);
      this.print();
      phase.raise_objection(this);
        x.start(a_b_env.agnt_b.b_seqr);
      phase.drop_objection(this);
    endtask
     
endclass: testt