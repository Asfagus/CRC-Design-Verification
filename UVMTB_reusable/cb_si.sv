//packet of seq1 message which is passed into sequencer
//sequence_item

typedef enum {
	Reset,
	Emptypkt,//Send no Data or Control packets, only the header and the tail of the pkt
	Datapkt, // sends only data packets with the control bit 9th bit set to 0
	Ctrlpkt, // sends only control packets with the control bit 9th bit set to 1
	Datactrl,// sends both data& control packets with the control bit 9th bit set to 0 or 1 respectively
	Dbadpkt // badpacket
} Dcmd;

	
class cb_seq_item extends uvm_sequence_item;
`uvm_object_utils(cb_seq_item)
	Dcmd cmd;
	rand logic[8:0]data[$]; //9-bit data is an dynamic array cntrl 1 bit+8bits data bits 
	rand reg[3:0] postdelay;
	
	/*constraint c1{data.size()>=6&&data.size()<=10;data[$]==8'hBC;};//data size atleast 6 cycles,3c is K.28.1 bc is K.28.5
	
	//constraint c2 {data[4:$-1]!==8'h3C;data[4:$-1]!==8'hBC;data[4:$-1]!==8'hF7;};//actual data must not have control bits 
	
	constraint c4{data[4]==8'h0a;data[5]==8'h0c;data[6]==8'h0e;data.size()==8;};//sets data to known values
	
	constraint c3 {
		foreach (data[i]){
			if (i==0 ||i==1 ||i==2 ||i==3)
				data[i]==8'h3C;		//K.28.1
			else if (i==data.size())
				data[i]==8'hBC;	    //K.28.5
		}
	};*/
	
	function new(string name="cb_seq_item");
		super.new(name);
	endfunction: new
	
endclass: cb_seq_item 


