//packet of seq1 message which is passed into sequencer
//sequence_item
	
class cb_seq_item extends uvm_sequence_item;
`uvm_object_utils(cb_seq_item)
	//Dcmd cmd;
	rand logic[7:0]data[]; //8-bit data is an dynamic array
	
	constraint c1{data.size()>=6&&data.size()<=10;data[0]==8'h3C;data[1]==8'h3C;data[2]==8'h3C;data[3]==8'h3C;data[$]==8'hBC;};//data size atleast 6 cycles,3c is K.28.1 bc is K.28.5
	
	function new(string name="cb_seq_item");
		super.new(name);
	endfunction: new
	
endclass: cb_seq_item 


