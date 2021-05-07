//FOr sending packets to the DUT
class cb_seq1 extends uvm_sequence #(cb_seq_item);//along with sequence class decln u need to pass message type 
`uvm_object_utils(cb_seq1)

cb_seq_item c;
cb_seq_item d,e,f;
logic[8:0] sdata[$];
logic[8:0] temp;
int i=0;
function new(string name="cb_seq1");
	super.new(name);
endfunction: new

task Header();

	for(int i=0;i<4;i++) begin
		sdata[i]=9'h13C;
		//$display("sdata[%d]=%h",i,sdata[i]);
	end

endtask : Header


task Mid(cb_seq_item m1);// This task ends only data packets
m1.randomize() with{m1.data.size()>=6 && m1.data.size()<=10;};//m1.data[i] inside {[0:255]};};
	for(i=4;i<m1.data.size();i++) begin
		m1.randomize() with {m1.data[i] inside {[0:255]};};
		temp=m1.data[i];
		temp[8]=0;
		sdata[i]=temp;
	end
endtask : Mid

task Mid1(cb_seq_item m2);// This task ends only control packets
m2.randomize() with{m2.data.size()>=6 && m2.data.size()<=10;}; //&& (m2.data[i] inside {9'h01c,9'h05c,9'h07c,9'h09c,9'h0dc,9'h0fb,9'h0fd,9'h0fe});};
	for(i=4;i<m2.data.size()-1;i++) begin
		m2.randomize() with {m2.data[i] inside {9'h01c,9'h05c,9'h07c,9'h09c,9'h0dc,9'h0fb,9'h0fd,9'h0fe};};
		temp=m2.data[i];
		temp[8]=1;
		sdata[i]=temp;
		//sdata[i]=m2.data[i];
		//$display("from mid1 with data pkts m2.data=%h sdata[%d]=%h",m2.data[i],i,sdata[i]);
	end
endtask : Mid1

task Mid2(cb_seq_item m3);// This task ends data + control packets
m3.randomize() with{m3.data.size()>=6 && m3.data.size()<=10;};
	for(i=4;i<m3.data.size()-1;i++) begin
			m3.randomize() with {m3.data[i] inside {[0:255]} || m3.data[i] inside {9'h11c,9'h15c,9'h17c,9'h19c,9'h1dc,9'h1fb,9'h1fd,9'h1fe};};
			sdata[i]=m3.data[i];
		$display("from mid2 with data pkts m3.data=%h sdata[%d]=%h",m3.data[i],i,sdata[i]);
	end
endtask : Mid2

task Tail(cb_seq_item m1);
		if(m1.data.size()) begin
		//$display("m1.data.size()=%0d",m1.data.size());
		sdata[m1.data.size()-1]=9'h1BC;
		//$display("sdata[bc]=%h",sdata[m1.data.size()]);
		end
		else begin
		sdata[$+1]=9'h1BC;
		//$display("sdata[bc]=%h",sdata[$+1]);
		end

endtask : Tail

task Wait();

endtask

task body(); // sequence_item requires a task body if it is not there it will generate a warning
	c=cb_seq_item::type_id::create("cb_seq_item");
	d=cb_seq_item::type_id::create("cb_seq_item2");
	e=cb_seq_item::type_id::create("cb_seq_item3");
	f=cb_seq_item::type_id::create("cb_seq_item4");
	// SENDING EMPTY PACKETS
	repeat(8) begin	
	int i=0;
		start_item(c);
		c.cmd=Emptypkt;
		Header();
		Tail(c);
		while(i<5) begin
			c.data[i]=sdata[i];
			//$display("from seq1 c.data=%h sdata[%d]=%h",c.data[i],i,sdata[i]);
			i++;
		end
		Wait();
		finish_item(c);
	end
	// SENDING DATA PACKETS
	repeat(8) begin	
	int i=0;
		start_item(d);
		//d.randomize() with{d.data.size()>=6 && d.data.size()<=10;};		//Randomize the "data" part of packet  
		d.cmd=Datapkt;
		Header();
		Mid(d);
		Tail(d);
		while(i<d.data.size()) begin
			d.data[i]=sdata[i];
			//$display("from seq1 with data pkts c.data=%h sdata[%d]=%h",d.data[i],i,sdata[i]);
			i++;
		end
		Wait();
		finish_item(d);
	end
	// SENDING ONLY CONTROL PACKETS
	repeat(8) begin	
	int i=0;
		start_item(e);
		//d.randomize() with{d.data.size()>=6 && d.data.size()<=10;};		//Randomize the "data" part of packet  
		e.cmd=Ctrlpkt;
		Header();
		Mid1(e);
		Tail(e);
		while(i<e.data.size()) begin
			e.data[i]=sdata[i];
			//$display("from seq1 with data pkts e.data=%h sdata[%d]=%h",e.data[i],i,sdata[i]);
			i++;
		end
		Wait();
		finish_item(e);
	end
	// SENDING DATA+ CONTROL PACKETS
	repeat(20) begin	
	int i=0;
		start_item(f);
		//d.randomize() with{d.data.size()>=6 && d.data.size()<=10;};		//Randomize the "data" part of packet  
		f.cmd=Datactrl;
		Header();
		Mid2(f);
		Tail(f);
		while(i<f.data.size()) begin
			f.data[i]=sdata[i];
			//$display("from seq1 with data pkts e.data=%h sdata[%d]=%h",e.data[i],i,sdata[i]);
			i++;
		end
		Wait();
		finish_item(f);
	end
	
endtask: body


endclass: cb_seq1
