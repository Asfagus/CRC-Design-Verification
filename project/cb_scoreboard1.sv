// Takes output from mon_out 

class cb_scoreboard1 extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard1)

	uvm_tlm_analysis_fifo #(momsg) message_in;
	uvm_analysis_port #(momsg) message_out;
	momsg m;

	function new (string name="cb_scoreboard1",uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		message_in=new("message_in_momsg",this);
		message_out=new("message_out_momsg",this);
	endfunction:build_phase

	task run_phase(uvm_phase phase);
	forever begin
		m=new();	//Not required
		message_in.get(m);
		//$display("pushout from Scoreboard1 UVM =%h",m.pushout);	
		if((m.pushout)) begin
			//$display("Data from Scoreboard1 UVM =%h",m.dataout);	
			message_out.write(m);	
		end
	end
	endtask:run_phase

endclass: cb_scoreboard1
