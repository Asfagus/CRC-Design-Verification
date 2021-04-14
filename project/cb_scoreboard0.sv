//Scoreboard receives inputs from monin and monoutput
//`uvm_analysis_decl(_a); 
//`uvm_analysis_decl(_c);

//`uvm_blocking_put_imp_decl(_1)
class cb_scoreboard0 extends uvm_scoreboard;
`uvm_component_utils(cb_scoreboard0)
uvm_tlm_analysis_fifo #(mimsg) message_in;
//uvm_tlm_analysis_fifo #(logic) message_out;
uvm_blocking_put_imp #(logic,cb_scoreboard0) message_out;

mimsg m;
int count;
logic sh_full;
function new (string name="cb_scoreboard0",uvm_component parent=null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	message_in=new("message_in",this);
	message_out=new("message_out",this);
endfunction:build_phase
task put(logic sh_full);
		//$display("sh_full=%0d",sh_full);		
			if(count >=4) begin
				if(sh_full!=1) begin
				`uvm_fatal("FIFOfull","FIFO should be full but full is not set")
				end
			end
endtask
task run_phase(uvm_phase phase);
	forever begin
		message_in.get(m);
		//$display("pushin of m",m.pushin);
		if(m.pushin && m.write && !m.full) begin
			count++;
			$display("count++ UVM=%0d",count);		
		end
		else begin
			if(!m.pushin && !m.write) begin
			count--;
			end
		end
	end
endtask:run_phase

endclass: cb_scoreboard0
