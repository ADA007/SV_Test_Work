
//`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import struct_pkg::*;
  
class b_sequencer extends uvm_sequencer#(resp_pkt);
   `uvm_component_utils(b_sequencer)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

endclass: b_sequencer
  
class b_sequence extends uvm_sequence #(resp_pkt);
   `uvm_object_utils(b_sequence)
     
   function new(string name="");
      super.new(name);
   endfunction

   virtual task body();
      
      resp_pkt resp_pk;
      
      repeat (8) begin

         resp_pk = resp_pkt::type_id::create("resp_pk",,get_full_name() );

         start_item(resp_pk);
            // Some code of sequence
         finish_item(resp_pk);

      end
   endtask: body

endclass