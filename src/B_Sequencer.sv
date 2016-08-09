
`include "uvm_pkg.sv"
import uvm_pkg::*;
import struct_pkg::*;
  
class b_sequencer extends uvm_sequencer#(resp_pkt);
   `uvm_component_utils(b_sequencer)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
endclass
  
class b_sequence extends uvm_sequence #(resp_pkt);
   `uvm_object_utils(b_sequence)
   resp_pkt resp_pk;
     
   function new(string name="b_sequence");
      super.new(name);
   endfunction

    task body();
      repeat (15) begin
         `uvm_info("B_SEQUENCE_SEQ_BODY", $sformatf("Sent_request address = %0d", resp_pk.delay_time), UVM_LOW)
         resp_pk = resp_pkt::type_id::create("resp_pk"); //`uvm_do_with(resp_pk,{resp_pk.delay_time inside {[2:10]};}) => may use insted this and 8 next lines
         // wait_for_grant();
         //starting_phase.raise_objection(this);
         start_item(resp_pk);
         #10; 
         if (!resp_pk.randomize() with {resp_pk.delay_time inside {[2:10]};} ) begin //assert(resp_pk.randomize() with {resp_pk.delay_time inside {[2:10]};}); => may use insted this and 2 next lines
           `uvm_warning("RNDFLD", "Randomization failed for resp_pkt")
         end
         //send_request(req);
         //wait_for_item_done();
         `uvm_info("B_SEQUENCE_SEQ_BODY", $sformatf("Sent_request address = %0d", resp_pk.delay_time), UVM_LOW)
         //starting_phase.drop_objection(this);      
         finish_item(resp_pk);
      end
   endtask
endclass