
//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import struct_pkg::*;
  
class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(req_pkt, scoreboard) b_side_analysis_mon_port;
  req_pkt internal_state;

  function new (string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    b_side_analysis_mon_port = new("b_side_analysis_mon_port", this);
  endfunction
  
  function void write (req_pkt pkt);
    internal_state = pkt;
    `uvm_info( "SCOREBOARD", $sformatf(" Transaction. 0x%0h\n", internal_state.address), UVM_LOW );
  endfunction

endclass: scoreboard