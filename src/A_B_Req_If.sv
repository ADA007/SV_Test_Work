
interface A_B_req_if(input bit clk); 

  // signals definitions
  logic Valid;
  logic [11:0] Address;

  clocking clocking_block_drv @(posedge clk); 
      output Valid, Address; //sync interface with clock
  endclocking

  clocking clocking_block_mon @(posedge clk); 
      input Valid, Address; //sync interface with clock
  endclocking

  //modport DUT_A ( clocking clocking_block_drv );
  
  //modport iUVC_B ( input Valid, Address );

endinterface

