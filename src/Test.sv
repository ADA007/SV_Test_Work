  
//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

class testt extends uvm_test;
  
    `uvm_component_utils(testt)

    a_b_environment a_b_env;
    const int N = 3; // Set number of transactions during the test

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      a_b_env = a_b_environment::type_id::create("a_b_env", this);
    endfunction

    task check_test_length (uvm_phase phase);
      forever begin

          @(posedge a_b_env.agnt_a.a_drv.A_B_req_if_vi.clk);

          if (a_b_env.agnt_a.a_drv.transaction_num == N) begin //Check number of transactions every clock
            phase.drop_objection(this);
          end
      end
      
    endtask

    task run_phase(uvm_phase phase);
      this.print();
      phase.raise_objection(this);

      fork
        run_test();
        check_test_length(phase);
      join_any
      disable fork;
      phase.drop_objection(this);

    endtask
     
endclass: testt