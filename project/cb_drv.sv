class cb_drv extends uvm_driver #(cb_seq_item);

`uvm_component_utils(cb_drv)

cb_seq_item message_received;

logic ctrl;

virtual encoder_intf xx;// interface and driver are connected// Virtual because it was static

function new(string name="cb_drv",uvm_component parent =null);
	super.new(name,parent);
endfunction: new

function void connect_phase(uvm_phase phase);
	if(uvm_config_db#(virtual encoder_intf)::get(null,"sheethal","intf",xx)); else begin // From config db data signals are get by driver
		`uvm_fatal("config","dint get Interface sheethal")
	end
endfunction: connect_phase
task doWritek(reg [7:0] data,reg start);	//Sends control packets
		 @(posedge(xx.clk));#1;
		 	xx.reset=0;
		 	ctrl=1'b1;		//9th bit control 
			xx.datain={ctrl,data};	//9 bit data
			xx.pushin=1;				
			xx.startin=start;
endtask:doWritek 

task doWrited(cb_seq_item m);	//Sends Data Packets
		 @(posedge(xx.clk)) #1;
		 	xx.reset=0;
		 	ctrl=1'b0;
			xx.pushin=1;
			xx.startin=0;
			for (int i =4; i<m.data.size-1;i++)begin
				xx.datain={ctrl,m.data[i]};
				@(posedge(xx.clk)); #1;
				//$display(m.data.size);
			end
			xx.pushin=0;
endtask:doWrited 

task doReset();
			xx.reset=1;
			xx.datain=0;
			xx.pushin=0;
			xx.startin=0;
			@(posedge(xx.clk));#1;
endtask:doReset

/*
task doWait(cb_seq_item m);
		@(posedge(xx.clk));
			xx.pushin=0;

endtask: doWait
*/

task run_phase(uvm_phase phase); // if this task is not there in the driver phase simuln runs forver and next sequence not recived from the driver
	forever begin
		seq_item_port.get_next_item(message_received);		
		//Send packets to DUT
		
		//Reset
		repeat(5) begin
			doReset();
		end
		
		//K.28.1
		doWritek(message_received.data[0],1'b1);		//Startin High
		repeat(3)begin
			doWritek(message_received.data[0],1'b0);	//Startin Low send rem 3 K.28.1
		end
		
		// Data
		doWrited(message_received);
		
		//K.28.5
		doWritek(8'hBC,1'b0);		//Startin High
		
		
		
		seq_item_port.item_done();	// in bracket you can put response to seq1 back
	end
endtask: run_phase

endclass: cb_drv
