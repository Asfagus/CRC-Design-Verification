//packet of seq1 message which is passed into sequencer
//sequence_item
typedef enum {
	Dreset,
	Dwait,
	Dwritek,// control packets
	Dwrited // Data packets
} Dcmd;
	
class cb_seq_item extends uvm_sequence_item;
`uvm_object_utils(cb_seq_item)
	Dcmd cmd;
	rand logic[7:0]data[]; //8-bit data is an dynamic array
	//logic ctrl;
	//logic [8:0] final_data;
	
	constraint c1{data.size()>=6&&data.size()<=11;data[data.size()-1]==8'hBC;};//data size atleast 6 cycles
	
	function new(string name="cb_seq_item");
		super.new(name);
	endfunction: new
	
	
	

endclass: cb_seq_item 

/*
//Unpacked arrays
automatic/dynamic arr 

int a [];
data=new[11];


*/

