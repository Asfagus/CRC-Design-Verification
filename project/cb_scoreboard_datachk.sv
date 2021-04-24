//Checks if data from DUT was coded correctly


class cb_scoreboard_datachk extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard_datachk)

	uvm_tlm_analysis_fifo #(logic[9:0]) message_in_scbd8b10b;//ip from scbd8b10b
	uvm_tlm_analysis_fifo #(momsg) message_in_scbd1;	//ip from scbd1
	
	logic[9:0] dout_ed,dout_ed1;//store data from scbd0;
	logic[9:0] dout_act;	//store actual data from scbd1
	reg crcstart=0;		//pass if crc started in scbd1 for alignment
	momsg m_act;	//store ip from scbd1
	
	
	function new (string name="cb_scoreboard_datachk",uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		message_in_scbd8b10b=new("message_in_scbd8b10b",this);
		message_in_scbd1=new("message_in_scbd1",this);
	endfunction:build_phase
	
	function logic [9:0] data_in (logic [9:0]dout_ed );
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
	
	task compare(logic [9:0] dout_ed1,dout_act);
		//$display(dout_ed1,dout_act);
		if (dout_ed1==dout_act)
			`uvm_info(get_type_name(),$sformatf("Data Coded Correctly ed:%h, act:%h ",dout_ed1,dout_act),UVM_MEDIUM)
		else `uvm_error("Data Mismatch",$sformatf("Failed ed:%h,act:%h",dout_ed1,dout_act));
	endtask : compare
	
	task run_phase(uvm_phase phase);
		forever begin
			if(crcstart==0)
				message_in_scbd8b10b.get(dout_ed);
			message_in_scbd1.get(m_act);
			//`uvm_info("datachk_scbd",$sformatf("dout_ed:%h m_act:%p crcstart:%d",dout_ed,m_act,crcstart	),UVM_MEDIUM);
			
			dout_ed1=data_in(dout_ed);	//stores INPUT data in variable
			dout_act=data_out(m_act);   //stores Output data in variable
			
			if(crcstart==0)
				compare(dout_ed1,dout_act); //Compares to check if equal
		end
	endtask:run_phase

endclass: cb_scoreboard_datachk
