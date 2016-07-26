
class a_b_driver;

    // A_B_req_if Interface (Driver side)
    virtual A_B_req_if.DUT_A a_b_driver_if;

    function new ( virtual A_B_req_if.DUT_A a_b_driver_if);
        this.a_b_driver_if = a_b_driver_if;
    endfunction : new

    task reset_outputs();
        $display ("@%0d : Reset_if", $time);
        a_b_driver_if.clocking_block.Valid <= 0;
        a_b_driver_if.clocking_block.Address <= 0;
    endtask : reset_outputs

    task make_transaction (logic [11:0] addr_12);
        $display ("@%0d : Drive_if with data = 0x%0h", $time, addr_12);
        a_b_driver_if.clocking_block.Valid <= 1;
        a_b_driver_if.clocking_block.Address <= addr_12;
        repeat(2) @a_b_driver_if.clocking_block;
        reset_outputs();
        repeat(2) @a_b_driver_if.clocking_block;
    endtask : make_transaction

endclass : a_b_driver