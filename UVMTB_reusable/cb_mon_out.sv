//monitors the output
class cb_mon_out extends uvm_monitor;
	`uvm_component_utils(cb_mon_out)

	virtual encoder_intf dut_intf;// this needs to be declared as virtual else it will generate an error
	uvm_analysis_port #(momsg) pdat1;
	momsg m;	//Packet for data from DUT to scbd
	function new(string name="cb_mon_out",uvm_component parent =null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		pdat1 = new("momsg",this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		if(uvm_config_db#(virtual encoder_intf)::get(null,"sheethal","intf",dut_intf));else begin
			`uvm_fatal("config","dint get sheethal interface");
		end
	endfunction: connect_phase

	task run_phase(uvm_phase phase);
		forever @(posedge(dut_intf.clk))begin
			if(!dut_intf.reset)begin
				m=new;
				m.startout=dut_intf.startout;
				//$display("I am inside output monitor");
				m.pushout=dut_intf.pushout;
				m.dataout=dut_intf.dataout;
				//$display("m.pushout=%h",m.pushout);
				pdat1.write(m);
			end
		end
	endtask: run_phase
endclass: cb_mon_out
