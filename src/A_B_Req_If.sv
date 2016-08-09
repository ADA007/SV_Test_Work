
interface A_B_req_if(input bit clk); 

  // signals definitions
  logic Valid_Addr, Valid_Data;
  logic [11:0] Address;
  logic [23:0] Data;

  clocking clocking_block_drv_a @(posedge clk); 
      output Valid_Addr, Address; //sync interface with clock
  endclocking

  clocking clocking_block_drv_b @(posedge clk); 
      output Valid_Data, Data; //sync interface with clock
  endclocking

  clocking clocking_block_mon @(negedge clk); 
      input Valid_Addr, Address; //sync interface with clock
  endclocking

  //modport DUT_A ( clocking clocking_block_drv );
  
  //modport iUVC_B ( input Valid, Address );

endinterface

