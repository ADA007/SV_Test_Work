  
//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

class a_b_environment extends uvm_env;

    `uvm_component_utils(a_b_environment)
    
    agent_a agnt_a;
    agent_b agnt_b;
    scoreboard scb;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      agnt_a = agent_a::type_id::create("agnt_a", this);
      agnt_b = agent_b::type_id::create("agnt_b", this);
      scb = scoreboard::type_id::create("scb", this);
    endfunction

    // connect mon port to scoreboard port thorugh agent_b
    virtual function void connect();
      agnt_b.b_side_analysis_port.connect(scb.b_side_analysis_mon_port);
    endfunction

 endclass