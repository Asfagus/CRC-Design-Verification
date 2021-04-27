class cb_scoreboard_RD extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard_RD)

	//output from scbd8b10b and scbd1 to scbd_RD for checking disparity
	uvm_tlm_analysis_fifo #(logic[9:0]) message_in_scbd8b10b;
	uvm_tlm_analysis_fifo #(momsg) message_in_scbd1;
	
	logic[9:0] dout_ed,dout_ed1,dout_act;	//store actual data from scbd8b10b and scbd1
	reg crcstart=0;
	momsg m_act;	//store ip from scbd1

	int rd_ed=-1;
	int rd_act=-1;
	
	//new - constructor
	function new (string name="cb_scoreboard_RD",uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		message_in_scbd8b10b=new("message_in_scbd8b10b",this);
		message_in_scbd1=new("message_in_scbd1",this);
	endfunction:build_phase

	function logic [9:0] data_in (logic [9:0]dout_ed);
		casez (dout_ed)//Data coming from input converted to 10bit
			10'h27C,10'h183:data_in=dout_ed;//$display("K.28.1: Control packet");
			10'h17C,10'h283:data_in=dout_ed;//$display("K.28.5: Ending data");	
			10'b??????????:data_in=dout_ed; //$display("Data Packet");	//This might interfere with other cases with Case
			
			default: $display("Illegal Packet");	
		endcase
	endfunction
	
	function logic[9:0] data_out(momsg m_act);
		casez (m_act.dataout)//Data coming from Output 
			10'h27C,10'h183:data_out=m_act.dataout;//$display("K.28.1: Control packet");
			10'h17C,10'h283:begin data_out=m_act.dataout;crcstart=0;end //$display("K.28.5: Ending Full Packet");		//This will not occur since data will block 
			10'h57,10'h3A8:begin data_out=m_act.dataout;crcstart=1;end//$display("K.23.7: Ending data,CRC next");	
			10'b??????????:data_out=m_act.dataout;//$display("Data Packet");//dout_ed1=dout_ed;					//This might interfere with other cases with Case
			
			default: $display("Illegal Packet");	
		endcase
		return data_out;
	endfunction: data_out
	
	function int update_rd_ed(int rd_ed,logic [9:0]dout_ed1);
		int c1,c0,rd_ed_new, diff_ed;
		c1=$countones(dout_ed1);
		c0=$countbits(dout_ed1 ,'0);
		diff_ed =c1-c0;
			rd_ed_new=rd_ed+diff_ed;
			`uvm_info(get_type_name(),$sformatf("rd_ed update using diff_ed:%d,ed data:%h",diff_ed,dout_ed1),UVM_MEDIUM)
			return rd_ed_new;	
	endfunction: update_rd_ed
	
	function int update_rd_act(int rd_act,logic [9:0] dout_act);
		int d1,d0,rd_act_new, diff_act;
		d1=$countones(dout_act);
		d0=$countbits(dout_act ,'0);
		diff_act =d1-d0;
		if (diff_act!=2 && diff_act!=-2 && diff_act!=0) begin
		`uvm_error("disparity out of range {+2,0,-2}",$sformatf("Failed diff_act:%d",diff_act));
		end else
			rd_act_new=rd_act+diff_act;
			`uvm_info(get_type_name(),$sformatf("rd_act update using diff_act:%d,act data:%h",diff_act,dout_act),UVM_MEDIUM)
			return rd_act_new;	
	endfunction: update_rd_act
	

	task checkRD(int rd_ed,int rd_act);
		if (rd_act!=1 && rd_act!=-1)
			`uvm_error("actual RD out of range {+1,-1}",$sformatf("Failed act:%d",rd_act));
			
		if (rd_ed==rd_act)
				`uvm_info(get_type_name(),$sformatf("RD Coded Correctly and matching ed:%d, act:%d ",rd_ed,rd_act),UVM_MEDIUM)
		else 
				`uvm_error("RD Mismatch or RD out of range",$sformatf("Failed ed:%d,act:%d",rd_ed,rd_act));
	endtask : checkRD
	
	task run_phase(uvm_phase phase);
		forever begin

			message_in_scbd8b10b.get(dout_ed);
			message_in_scbd1.get(m_act);
			$display("scoreboard_RD: rd_ed:%d, rd_act:%d",rd_ed,rd_act);	
			checkRD(rd_ed,rd_act); //Compares to check if equal
			dout_ed1=data_in(dout_ed);	//stores INPUT data in variable
			dout_act=data_out(m_act);   //stores Output data in variable
			rd_ed=update_rd_ed(rd_ed,dout_ed); 
			rd_act=update_rd_act(rd_act,dout_act);   //stores Output data in variable
		end
	endtask:run_phase
		
endclass: cb_scoreboard_RD