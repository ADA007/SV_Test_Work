`timescale 1ns/1fs

module Top_Wrapper;

  bit  clk;
  always #(1/0.45) clk = !clk; //make clock close to 450 MHz

  A_B_req_if A_B_req_interface(clk);

  Test_Program test_a_b(A_B_req_interface);

endmodule
