//FOr sending packets to the DUT
class cb_seq1 extends uvm_sequence #(cb_seq_item);//along with sequence class decln u need to pass message type 
`uvm_object_utils(cb_seq1)

cb_seq_item c;

function new(string name="cb_seq1");
	super.new(name);
endfunction: new

task body(); // sequence_item requires a task body if it is not there it will generate a warning
	c=cb_seq_item::type_id::create("cb_seq_item");	

	repeat(500)begin
		start_item(c);
		c.randomize();		//Randomize the "data" part of packet  
		finish_item(c);
	end
endtask: body


endclass: cb_seq1
