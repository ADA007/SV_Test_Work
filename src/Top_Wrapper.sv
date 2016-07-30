`timescale 1ns/1fs

`include "uvm_macros.svh"
`include "uvm_pkg.sv"

module Top_Wrapper;

  import uvm_pkg::*;

  bit  clk;
  always #(1/0.45) clk = !clk; //make clock close to 450 MHz

  A_B_req_if A_B_req_interface(clk);

  initial
  begin
    uvm_config_db #(virtual A_B_req_if)::set(null, "*", "A_B_req_if", A_B_req_interface);
     uvm_top.finish_on_completion = 1;
    run_test("testt");
  end

endmodule
