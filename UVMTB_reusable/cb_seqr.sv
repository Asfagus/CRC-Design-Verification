class cb_seqr extends uvm_sequencer #(cb_seq_item);
`uvm_component_utils(cb_seqr)

function new(string name="cb_seqr",uvm_component parent =null);
	super.new(name,parent);
endfunction: new

endclass: cb_seqr
