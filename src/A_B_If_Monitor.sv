
class apb_monitor;

    // APB Interface (Monitor side)
    virtual A_B_req_if.Monitor a_b_monitor_if;

    task main();
 
        forever begin

            // Wait for valid address
            wait (A_B_req_if.Valid == 1);

            //Check data for U Z X

            //Save data to fifo
            
        end // forever
    endtask: main

endclass: apb_monitor

