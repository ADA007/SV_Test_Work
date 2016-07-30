  

  class testt extends uvm_test;
  
    `uvm_component_utils(testt)
    
    a_b_monitor a_b_mon;
    a_b_driver a_b_drv;

  function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      a_b_drv = a_b_driver::type_id::create("a_b_drv", this);
      a_b_mon = a_b_monitor::type_id::create("a_b_mon", this);
    endfunction
    
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);

      //phase.drop_objection(this);
    endtask
     
  endclass: testt