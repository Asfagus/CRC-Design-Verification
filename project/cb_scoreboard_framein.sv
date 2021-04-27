class cb_scoreboard_framein extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard_framein)

	uvm_tlm_analysis_fifo #(mimsg) message_in_scbd_framein ;//ip from scbd0

	reg [3:0] count_28=0;
	reg [8:0] data_28_1 = 9'b100111100;
	mimsg i_act;

	enum reg[2:0]{Reset,
				  K28_1,
				  Data,
				  K28_5
	}cs,ns;


	function new(string name="cb_scoreboard_framein",uvm_component parent=null);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		message_in_scbd_framein=new("message_in_scbd_framein",this);
	endfunction: build_phase



	task run_phase(uvm_phase phase);
		
		fork
			cs = Reset;
			forever begin
				message_in_scbd_framein.get(i_act);
				//cs=ns;
				case(cs)
					Reset:begin
						count_28=0;
						if(i_act.datain==9'b100111100)begin
							`uvm_info(get_type_name(),$sformatf("K28.1 Match ed:%h, act:%h, cs:%d, ns:%d",data_28_1,i_act.datain,cs,ns),UVM_MEDIUM)
							ns = K28_1;
						end else begin
							`uvm_error("Error Frame in K28.1",$sformatf("Failed ed:%h,act:%h, cs:%d, ns:%d",data_28_1,i_act.datain,cs,ns))
							ns = Reset;
						end
					end
					K28_1:begin
						if(count_28==2)begin
							if(i_act.datain==9'b100111100)begin
								`uvm_info(get_type_name(),$sformatf("K28.1 Match ed:%h, act:%h ",data_28_1,i_act.datain),UVM_MEDIUM)
								ns = Data;
							end else begin
								`uvm_fatal("Error Frame in K28.1",$sformatf("Failed ed:%h,act:%h",data_28_1,i_act.datain))
								ns = Reset;
							end
						end else begin
							if(i_act.datain==9'b100111100)begin
								`uvm_info(get_type_name(),$sformatf("K28.1 Match ed:%h, act:%h ",data_28_1,i_act.datain),UVM_MEDIUM)
								count_28 = count_28+1;
								ns = K28_1;
							end else begin
								`uvm_fatal("Error Frame in K28.1",$sformatf("Failed ed:%h,act:%h",data_28_1,i_act.datain))
								ns = Reset;
							end

						end

					end
					Data:begin
						if(i_act.datain==9'b110111100)begin
							ns = K28_5;
						end else begin
							if(i_act.datain[8]==1)begin
								if(i_act.datain[4:0]==5'b11100)begin
									if(i_act.datain[7:5]==3'b001)begin
										`uvm_error("Error Frame in current packet which has K28.1",$sformatf("Failed act:%h",i_act.datain))
										ns = Reset;
									end else begin
										`uvm_info(get_type_name(),$sformatf("Data is legal  act:%h ",i_act.datain),UVM_MEDIUM)
										ns = Data;
									end
								end else if(i_act.datain[7:5]==3'b111)begin
									if(i_act.datain[4:0]==5'b11011||i_act.datain[4:0]==5'b11101||i_act.datain[4:0]==5'b11110)begin
										`uvm_info(get_type_name(),$sformatf("Data is legal  act:%h ",i_act.datain),UVM_MEDIUM)
										ns = Data;
									end else begin
										`uvm_error("Error Frame in current packet which has wrong control symbols",$sformatf("Failed act:%h",i_act.datain))
										ns = Reset;
									end
								end else begin
									`uvm_error("Error Frame in current packet which has wrong control symbols",$sformatf("Failed act:%h",i_act.datain))
									ns = Reset;
								end
							end else begin
								`uvm_info(get_type_name(),$sformatf("Data is legal  act:%h ",i_act.datain),UVM_MEDIUM)
								ns = Data;
							end
							//ns = Data;
						end

					end
					K28_5:begin
						if(i_act.datain==9'b100111100)begin
							`uvm_info(get_type_name(),$sformatf("Next packet start ed:%h  act:%h ",data_28_1,i_act.datain),UVM_MEDIUM)
							ns = K28_1;
							count_28=0;
						end else if(i_act.datain)begin
							`uvm_error("Error Frame in current packet which has data",$sformatf("Failed act:%h",i_act.datain))
							ns=Reset;
						end else begin
							ns = K28_5;
						end
					end
				endcase
				cs=ns;
			end
		join
	endtask: run_phase
endclass : cb_scoreboard_framein
