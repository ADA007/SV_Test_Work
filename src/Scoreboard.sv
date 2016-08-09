
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
  
class scoreboard extends uvm_scoreboard;

  uvm_analysis_imp #(int, scoreboard) analysis_mon_port;
  int internal_state;
  
  `uvm_component_utils(scoreboard)

  function new (string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_mon_port = new("analysis_mon_port", this);
  endfunction
  
  function void write (int pkt);
    internal_state += pkt;
    `uvm_info( "SCOREBOARD", $sformatf(" Transaction. 0x%0h\n", internal_state), UVM_LOW );
  endfunction

endclass: scoreboard