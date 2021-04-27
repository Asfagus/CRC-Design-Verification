//Scoreboard receives inputs from monin and monoutput
//`uvm_analysis_decl(_a); 
//`uvm_analysis_decl(_c);

//`uvm_blocking_put_imp_decl(_1)
class cb_scoreboard0 extends uvm_scoreboard;
`uvm_component_utils(cb_scoreboard0)

uvm_tlm_analysis_fifo #(mimsg) message_in;
uvm_analysis_port #(mimsg) message_out;
uvm_analysis_port #(mimsg) message_out1;//port to scbdcrc
uvm_analysis_port #(mimsg) message_out2;


mimsg m;
//int count;
//logic sh_full;
function new (string name="cb_scoreboard0",uvm_component parent=null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	message_in=new("message_in",this);
	message_out=new("message_out",this);
	message_out1=new("message_out1",this);
	message_out2=new("message_out2",this);

endfunction:build_phase

task run_phase(uvm_phase phase);
	forever begin
		m=new();
		message_in.get(m);
		if((m.pushin)) begin
			//$display("Data from Scoreboard0 UVM =%h",m.datain);	
			message_out.write(m);
			message_out1.write(m);
			message_out2.write(m);		
		end
		//else
		//$display("I dint get anyting");
	end
endtask:run_phase

endclass: cb_scoreboard0
