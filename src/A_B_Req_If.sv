`timescale 1ns/1fs

interface A_B_req_if(input bit clk); 

  // signals definitions
  bit Valid;
  logic [11:0] Address;

  clocking clocking_block @(posedge clk); 
      output Valid, Address; //sync interface with clock
  endclocking

  modport DUT_A ( clocking clocking_block );
  
  modport iUVC_B ( input Valid, Address );

endinterface

