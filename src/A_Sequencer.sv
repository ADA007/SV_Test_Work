//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import struct_pkg::*;
  
class a_sequencer extends uvm_sequencer#(req_pkt);
   
   `uvm_component_utils(a_sequencer)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

endclass: a_sequencer
  
class a_sequence extends uvm_sequence #(req_pkt);
   
   `uvm_object_utils(a_sequence)
     
   function new(string name="");
      super.new(name);
   endfunction

   virtual task body();
      
      req_pkt req_pk;

      repeat (5) begin

         req_pk = req_pkt::type_id::create("req_pk",,get_full_name() );

         start_item(req_pk);
            //for (int i = 0; i < 10; i++)
            if (!req_pk.randomize() ) begin 
              `uvm_warning("RNDFLD", "Randomization failed for req_pkt")
            end

            //`uvm_info("A_SEQUENCE", $sformatf("Sent_request address = 0x%0h", req_pk.address), UVM_LOW)
            
         finish_item(req_pk);

      end
   endtask: body

endclass