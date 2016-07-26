
class a_b_monitor;

    // A_B_req_if Interface (Monitor side)
    virtual A_B_req_if.iUVC_B a_b_monitor_if;

    function new ( virtual A_B_req_if.iUVC_B a_b_monitor_if);
        this.a_b_monitor_if = a_b_monitor_if;
    endfunction : new

    task monitoring();
 
        forever begin

            // Wait for valid address
            @(posedge a_b_monitor_if.Valid);
            $display ("@%0d : Monitor catch transaction", $time);

            //Check data for U Z X

            //Save data to fifo
            
        end // forever
    endtask: monitoring

endclass: a_b_monitor

