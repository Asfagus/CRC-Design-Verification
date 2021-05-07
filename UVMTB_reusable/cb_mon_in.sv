//monitors the input
class cb_mon_in extends uvm_monitor;
`uvm_component_utils(cb_mon_in)

virtual encoder_intf dut_intf;// this needs to be declared as virtual else it will generate an error
uvm_analysis_port #(mimsg) pdat;
mimsg m;
function new(string name="cb_mon_in",uvm_component parent =null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	pdat = new("mimsg",this);

endfunction: build_phase

function void connect_phase(uvm_phase phase);
	if(uvm_config_db#(virtual encoder_intf)::get(null,"sheethal","intf",dut_intf));else begin
		`uvm_fatal("config","dint get sheethal interface");
	end
endfunction: connect_phase

task run_phase(uvm_phase phase);
	forever @(posedge(dut_intf.clk))begin
		if(!dut_intf.reset)begin
			m=new();
			m.startin=dut_intf.startin;
			m.pushin=dut_intf.pushin;
			m.datain=dut_intf.datain;
			pdat.write(m);
		end
	end
	

endtask: run_phase
endclass: cb_mon_in
