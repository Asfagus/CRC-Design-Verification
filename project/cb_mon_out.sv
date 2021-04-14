//monitors the output
class cb_mon_out extends uvm_monitor;
`uvm_component_utils(cb_mon_out)

virtual fifo_intf dut_intf;// this needs to be declared as virtual else it will generate an error
uvm_blocking_put_port #(logic) pdat1;
uvm_analysis_port #(mimsg) psc1;
logic sh;
mimsg sh_empty;
function new(string name="cb_mon_out",uvm_component parent =null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	pdat1 = new("momsg",this);
	psc1 =  new("score board 1 port",this);
endfunction: build_phase

function void connect_phase(uvm_phase phase);
	if(uvm_config_db#(virtual fifo_intf)::get(null,"sheethal","intf",dut_intf));else begin
		`uvm_fatal("config","dint get sheethal interface");
	end
endfunction: connect_phase

task run_phase(uvm_phase phase);
			forever @(posedge(dut_intf.clk))begin	
				sh_empty=new();			
				sh=	dut_intf.full;
				//$display("full from monout=%0d",sh);
				sh_empty.empty=dut_intf.empty;
				sh_empty.clk=dut_intf.clk;
				sh_empty.read=dut_intf.read;
				sh_empty.pushout=dut_intf.pushout;
				sh_empty.dataout=dut_intf.dataout;
				pdat1.put(sh);
				psc1.write(sh_empty);
			end
endtask: run_phase
endclass: cb_mon_out
