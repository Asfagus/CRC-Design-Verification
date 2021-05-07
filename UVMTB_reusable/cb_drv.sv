class cb_drv extends uvm_driver #(cb_seq_item);

`uvm_component_utils(cb_drv)

cb_seq_item message_received;

rand logic ctrl;
rand logic tb_pushin;
virtual encoder_intf xx;// interface and driver are connected// Virtual because it was static
logic[8:0]sdata[];
int i=0;
function new(string name="cb_drv",uvm_component parent =null);
	super.new(name,parent);
endfunction: new

function void connect_phase(uvm_phase phase);
	if(uvm_config_db#(virtual encoder_intf)::get(null,"sheethal","intf",xx)); else begin // From config db data signals are get by driver
		`uvm_fatal("config","dint get Interface sheethal")
	end
endfunction: connect_phase
/*task doWritek(reg [7:0] data,reg start);	//Sends control packets
	 @(posedge(xx.clk));#1;
	 	xx.reset=0;
	 	ctrl=1'b1;		//9th bit control 
		xx.datain={ctrl,data};	//9 bit data
		xx.pushin=1;	
		//std::randomize(tb_pushin);	
		//xx.pushin=tb_pushin;			
		xx.startin=start;
		ctrl=1'b0;
endtask:doWritek 
//constraint c4{ctrl==0;};
task doWrited(cb_seq_item m);	//Sends Data Packets
	@(posedge(xx.clk)) #1;
		xx.reset=0;		
		//xx.pushin=1;
		
		xx.startin=0;
		for (int i =4; i<m.data.size-1;i++)begin
			std::randomize(ctrl) with {if(ctrl==0) m.data[i] inside {[0:255]}; if(ctrl==1) m.data[i] inside {8'h1c,8'h5c,8'h7c,8'h9c,8'hdc,8'hfb,8'hfd,8'hfe};};
			//ctrl=1'b1; // uncomment this and the below line to test the constraint when only control pkts are sent
			//std::randomize(m.data[i]) with {m.data[i] inside {8'h1c,8'h5c,8'h7c,8'h9c,8'hdc,8'hfb,8'hfd,8'hfe};};
			xx.datain={ctrl,m.data[i]};
			std::randomize(tb_pushin);	
			xx.pushin=tb_pushin;
			if(i<m.data.size-2)	//added to avoid last data double clocking
				@(posedge(xx.clk)); #1;
			//$display("Data");
		end
		//xx.pushin=0;
endtask:doWrited 

task doReset();
	xx.reset=1;
	xx.datain=0;
	xx.pushin=0;
	xx.startin=0;
	@(posedge(xx.clk));#1;
endtask:doReset


task doWait(cb_seq_item m);
		@(posedge(xx.clk)) #1;
			xx.pushin=0;

endtask: doWait

task drive (cb_seq_item m);
	//Send packets to DUT
	$display("Driving Packet of VAlues :%p",m.data);
	$display("Driving Packet of size :%d",m.data.size());
	//K.28.1
	doWritek(m.data[0],1'b1);		//Startin High
	repeat(3)begin
		doWritek(m.data[0],1'b0);	//Startin Low send rem 3 K.28.1
	end

	doWrited(m);// Data

	doWritek(8'hBC,1'b0);			//K.28.5, start bit low
	
	repeat($urandom_range(10,20)) begin	//wait for 10-20 clock cycles
	doWait(m);
	end
endtask : drive
*/
task doWait(cb_seq_item m);
		@(posedge(xx.clk)) #1;
			xx.pushin=0;

endtask: doWait
task doEmptypkt(cb_seq_item m);
	xx.reset=0;
	$display("I am inside Do empty task");
	for(int i=0;i<5;i++) begin
		@(posedge(xx.clk)); #1;
		if(i==0) begin
		//$display("I am inside for loop Do empty task xx.datain=%h,m.data[i]=%h",xx.datain,m.data[i]);
		xx.pushin=1;
		xx.startin=1;
		xx.datain=m.data[i];
		end
		else begin
		xx.pushin=1;
		xx.startin=0;
		xx.datain=m.data[i];
		end
	end	
	repeat($urandom_range(10,20)) begin	//wait for 10-20 clock cycles
	doWait(m);
	end
endtask
task doDatapkt(cb_seq_item m);
	xx.reset=0;
	//$display("I am inside Do datapkt task");
	for(int i=0;i<m.data.size();i++) begin
		@(posedge(xx.clk)); #1;
		if(i==0) begin
		//$display("I am inside for loop Do empty task xx.datain=%h,m.data[i]=%h",xx.datain,m.data[i]);
		xx.pushin=1;
		xx.startin=1;
		xx.datain=m.data[i];
		end
		else begin
		xx.pushin=1;
		xx.startin=0;
		xx.datain=m.data[i];
		end
	end	
	repeat($urandom_range(10,20)) begin	//wait for 10-20 clock cycles
	doWait(m);
	end
endtask

task doCtrlpkt(cb_seq_item m);
	xx.reset=0;
	//$display("I am inside Do datapkt task");
	for(int i=0;i<m.data.size();i++) begin
		@(posedge(xx.clk)); #1;
		if(i==0) begin
		//$display("I am inside for loop Do empty task xx.datain=%h,m.data[i]=%h",xx.datain,m.data[i]);
		xx.pushin=1;
		xx.startin=1;
		xx.datain=m.data[i];
		end
		else begin
		xx.pushin=1;
		xx.startin=0;
		xx.datain=m.data[i];
		end
	end	
	repeat($urandom_range(10,20)) begin	//wait for 10-20 clock cycles
	doWait(m);
	end
endtask

task doDatactrl(cb_seq_item m);
	xx.reset=0;
	//$display("I am inside Do datapkt task");
	for(int i=0;i<m.data.size();i++) begin
		@(posedge(xx.clk)); #1;
		if(i==0) begin
		//$display("I am inside for loop Do empty task xx.datain=%h,m.data[i]=%h",xx.datain,m.data[i]);
		xx.pushin=1;
		xx.startin=1;
		xx.datain=m.data[i];
		end
		else begin
		xx.pushin=1;
		xx.startin=0;
		xx.datain=m.data[i];
		end
	end	
	repeat($urandom_range(10,20)) begin	//wait for 10-20 clock cycles
	doWait(m);
	end
endtask

task doReset();
	
	xx.reset=1;
	xx.datain=0;
	xx.pushin=0;
	xx.startin=0;
	@(posedge(xx.clk)); #1;
	//$display("I am inside doreset");
	
endtask

task run_phase(uvm_phase phase); // if this task is not there in the driver phase simuln runs forver and next sequence not recived from the driver
	//Reset
	int count=0;
	repeat(5) begin
		doReset();
	end
	forever begin
		seq_item_port.get_next_item(message_received);	
		$display("driving packets of values=%p Packet =%0d",message_received.data,count);		
		case(message_received.cmd)
			Emptypkt: doEmptypkt(message_received);
			Datapkt: doDatapkt(message_received);
			Ctrlpkt: doCtrlpkt(message_received);
			Datactrl: doDatactrl(message_received);
		endcase
		count++;
		seq_item_port.item_done();	// in bracket you can put response to seq1 back
	end
endtask: run_phase

endclass: cb_drv
