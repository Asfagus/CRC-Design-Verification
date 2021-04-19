// Takes data from scbd1 for actual
// Takes data from scbd8b/10b for expected
//compares both for equality


class cb_scoreboard_disparity extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard_disparity)

	uvm_tlm_analysis_fifo #(logic[9:0]) message_in_scbd8b10b;//ip from scbd8b10b
	uvm_tlm_analysis_fifo #(momsg) message_in_scbd1;	//ip from scbd1
	
	momsg m_act;	//store ip from scbd1
	logic[9:0] dout_ed,dout_act;
	function new (string name="cb_scoreboard_disparity",uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		message_in_scbd8b10b=new("message_in_scbd8b10b",this);
		message_in_scbd1=new("message_in_scbd1",this);
	endfunction:build_phase

	task extract_data(momsg m);
	;
	endtask

	task run_phase(uvm_phase phase);
	fork
		forever begin
			message_in_scbd8b10b.get(dout_ed);
			$display("ED dout:%h",dout_ed);
			//message_in_scbd1.get(m_act);
			//$display("AD dout:%h",m_act.dataout);
			//extract_data(m_act);//extract data from actual
		end
		forever begin
			message_in_scbd1.get(m_act);
			if(m_act.pushout) begin
				$display("AD dout:%h",m_act.dataout);
				dout_act=m_act.dataout;
				if(dout_ed!==dout_act) begin
				`uvm_fatal("Data Mismatch",$sformatf("Failed ed:%h,act:%h",dout_ed,dout_act))
				end			
			end
		end
		/*forever begin
			if(dout_ed!==dout_act) begin
				`uvm_fatal("Data Mismatch","Expected out not matching output from the DUT")
			end
		end*/
	join
	endtask:run_phase

endclass: cb_scoreboard_disparity
