// Takes data from scbd1 for actual data from K23.7 packet
//compares both for equality from cb_scoreboard_crc and cb_scoreboard1

class cb_scoreboard_checkercrc extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard_checkercrc)

	uvm_tlm_analysis_fifo #(momsg) message_in_scbd1a;	//ip from scbd1
	uvm_tlm_analysis_fifo #(logic[9:0]) message_in_scbdcrca;//ip from scbdcrc
	
	momsg m_act;	//store ip from scbd1
	logic[9:0] dout_ed,dout_act,dout_ed1;
	logic[5:0][9:0] finalcrc_scb,finalcrc_dut;
	int flag=0;
	int count=0,flag_d,count_d;
	function new (string name="cb_scoreboard_checkercrc",uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		message_in_scbd1a=new("message_in_scbd1a",this);
		message_in_scbdcrca=new("message_in_scbdcrca",this);
	endfunction:build_phase
	task compare();
		for(int i=0;i<6;i++) begin
			if(finalcrc_dut[i]==finalcrc_scb[i]) begin
				`uvm_info(get_type_name(),$sformatf("Data Coded Correctly ed:%h, act:%h ",finalcrc_scb[i],finalcrc_dut[i]),UVM_MEDIUM)
			end
				else begin
				`uvm_error("Data Mismatch",$sformatf("Failed ed:%h,act:%h",finalcrc_scb[i],finalcrc_dut[i]))
				end
			
		end
	endtask
	task run_phase(uvm_phase phase);
	
	fork
		forever begin
			message_in_scbd1a.get(m_act);	
			dout_act=m_act.dataout;
			if(dout_act==10'b0001010111 || dout_act==10'b1110101000) begin
			flag_d=1;
			//$display("Received start if CRC from DUT");
			count_d=0;
			end
			if(flag_d==1) begin
			finalcrc_dut[count_d]=dout_act;
			count_d=count_d+1;
			//$display("CRC if 1. Received = %h",dout_act);
			end
			if(dout_act==10'b0101111100 || dout_act==10'b1010000011) begin
			flag_d=0;
			compare();
			/*$display("Call compare logic \n %h \n %h",finalcrc_dut,finalcrc_scb);
				if (finalcrc_dut==finalcrc_scb)
					`uvm_info(get_type_name(),$sformatf("Data Coded Correctly ed:%h, act:%h ",finalcrc_scb,finalcrc_dut),UVM_MEDIUM)
				else `uvm_error("Data Mismatch",$sformatf("Failed ed:%h,act:%h",finalcrc_scb,finalcrc_dut));*/
			end

		end
		forever begin 

			message_in_scbdcrca.get(dout_ed);
			if(dout_ed==10'b0001010111 || dout_ed==10'b1110101000) begin
			flag=1;
			count=0;
			end
			if(flag==1) begin
			finalcrc_scb[count]=dout_ed;
			count=count+1;
			//$display("CRC if 1. Expected = %h",dout_ed);
			end
			if(dout_ed==10'b0101111100 || dout_ed==10'b1010000011) begin
			flag=0;
			end

		end
		
	join
		/*forever begin 
			//m_act=new();
			//message_in_scbd1a.get(m_act);		
			//dout_act=m_act.dataout;
			message_in_scbdcrca.get(dout_ed);
			$display("from checker crc=%h",dout_ed);
			if(dout_ed!=dout_act) begin
						//`uvm_fatal("Data Mismatch",$sformatf("1.Expected =%h DUT Received=%h",dout_ed,dout_act))
						$display("CRC if 1. Expected = %h, Received=%h",dout_ed,dout_act);
			end
			else begin
				$display("CRC else 1. Expected = %h, Received=%h",dout_ed,dout_act);
			end
			
		end*/

	endtask:run_phase

endclass: cb_scoreboard_checkercrc
