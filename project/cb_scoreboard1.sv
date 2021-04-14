// Check that reister 0 reads the same written 32 bits

class cb_scoreboard1 extends uvm_scoreboard;
`uvm_component_utils(cb_scoreboard1)
uvm_tlm_analysis_fifo #(mimsg) empty_in;
int count;
int empty_count;
mimsg sh_empty;
function new (string name="cb_scoreboard1",uvm_component parent=null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	 empty_in=new("message_in",this);
endfunction:build_phase

task run_phase(uvm_phase phase);
	empty_count = 0;
	forever begin
		empty_in.get(sh_empty);
		$display("sh_empty.read=%0d %0d",sh_empty.read,sh_empty.empty);
		if(sh_empty.read && sh_empty.dataout) begin
			count++;
			$display("count from scoreboard1 = %0d %0d",count,sh_empty.clk);
		end 
		else begin
		end
		if(count==4) begin
				if(sh_empty.empty!=1) begin
					$display("investigate");
				`uvm_fatal("FIFOempty","FIFO should be empty but empty is not set")
				end else begin
					$display("EMPTY as been verified");
					count=0;
				end
		end
	end
	
		
endtask:run_phase

endclass: cb_scoreboard1
