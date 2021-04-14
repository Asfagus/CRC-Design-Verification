//monitors the input
class cb_mon_in extends uvm_monitor;
`uvm_component_utils(cb_mon_in)

virtual fifo_intf dut_intf;// this needs to be declared as virtual else it will generate an error
uvm_analysis_port #(mimsg) pdat;
mimsg m;
function new(string name="cb_mon_in",uvm_component parent =null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	pdat = new("mimsg",this);

endfunction: build_phase

function void connect_phase(uvm_phase phase);
	if(uvm_config_db#(virtual fifo_intf)::get(null,"sheethal","intf",dut_intf));else begin
		`uvm_fatal("config","dint get sheethal interface");
	end
endfunction: connect_phase
/*initial begin
assert property(@ ( posedge dut_intf.clk)m.rw |->m.data);
end*/
task run_phase(uvm_phase phase);
	forever @(posedge(dut_intf.clk))begin
		if(!dut_intf.rst)begin
			m=new();
			m.write=dut_intf.write;
			m.pushin=dut_intf.pushin;
			m.datain=dut_intf.datain;
			m.read=dut_intf.read;
			m.full=dut_intf.full;
				pdat.write(m);
		end
	/*assert (dut_intf.clk==1)$display("PASSED");
		else $display("FAIL");*/ // Worked
		/*assert property(@ ( posedge dut_intf.clk)m.rw |->m.data);*/ // This dint work
	end
	

endtask: run_phase
endclass: cb_mon_in
