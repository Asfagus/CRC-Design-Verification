
// This scoreboard checks if the CRC sends 4 packets after K23.7 packets

class cb_scoreboardcrc4packets extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboardcrc4packets)

	uvm_tlm_analysis_fifo #(momsg) messagecrc4_in_scbd1;	//ip from scbd1
	
	momsg m_act;	//store ip from scbd1
	int count =0;//counter to check if the no of packets is 4
	int flag=0;// flags sets to 1 when K23.7 is detected and it is set back to 0 when K28.5 is detected
	logic[9:0] dout_ed,dout_act,dout_act1;
	function new (string name="cb_scoreboardcrc4packets",uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		messagecrc4_in_scbd1=new("messagecrc4_in_scbd1",this);
	endfunction:build_phase

	task run_phase(uvm_phase phase);

		forever begin
			messagecrc4_in_scbd1.get(m_act);
			if(m_act.pushout) begin
				dout_act=m_act.dataout;
				if(dout_act==10'h27c || dout_act==10'h183) begin
				count=0;
				end
				if(dout_act==10'h3a8 || dout_act==10'h057) begin // if the data packet is K23.7
					flag=1;
				end	
				if(dout_act==10'h17c || dout_act==10'h283) begin
					flag=0;
				end	
				if(flag==1) begin
					dout_act1=dout_act;
						if(dout_act1!=10'h3a8 && dout_act1!=10'h057) begin
							count=count+1;
							//$display("count=%0d,flag=%0d, dout_act from new scbd=%h",count,flag,dout_act1);
						end
				end	
				if(count==4 && flag==0) begin
					
					if(dout_act!=10'h17c && dout_act!=10'h283) begin
						//$display("count=%0d,flag=%0d, dout_act from new scbd=%h",count,flag,dout_act);
						`uvm_fatal(get_type_name(),"4 packets of CRC not received")
					end
					else
				`uvm_info(get_type_name(),$sformatf("4 packets of CRC received"),UVM_MEDIUM)		
				end
			end
		end

	endtask:run_phase

endclass: cb_scoreboardcrc4packets 
