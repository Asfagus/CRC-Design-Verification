class cb_scoreboard_frameout extends uvm_scoreboard;
	`uvm_component_utils(cb_scoreboard_frameout)

	uvm_tlm_analysis_fifo #(momsg) message_in_scbd1b;

	reg[3:0]count_28_1;
	reg[3:0]count_crc;
	momsg o_act;
	

	enum reg[2:0]{Reset,
				  K28_1,
				  Data,
				  CRC,
				  K28_5
	}cs,ns;

	function new(string name="cb_scoreboard_frameout",uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		message_in_scbd1b=new("message_in_scbd1b",this);
	endfunction: build_phase


	task run_phase(uvm_phase phase);
		fork
			cs = Reset;
			forever begin
				message_in_scbd1b.get(o_act);
				case(cs)
					Reset:begin
						count_28_1=0;
						count_crc=0;
						if(o_act.pushout==1)begin
							if((o_act.dataout==10'b1001111100)||(o_act.dataout==10'b0110000011))begin
								`uvm_info(get_type_name(),$sformatf("K28.1 Output Match act:%h ",o_act.dataout),UVM_MEDIUM)
								ns = K28_1;
							end else begin
								`uvm_error("Error Output Frame in K28.1",$sformatf("Failed act:%h",o_act.dataout))
								ns = Reset;
							end
						end else begin
							ns = Reset;
						end
					end
					K28_1:begin
						if(o_act.pushout==1)begin
							if(count_28_1==2)begin
								if((o_act.dataout==10'b1001111100)||(o_act.dataout==10'b0110000011))begin
									`uvm_info(get_type_name(),$sformatf("K28.1 Output Match  act:%h ",o_act.dataout),UVM_MEDIUM)
									ns = Data;
								end else begin
									`uvm_fatal("Error Output Frame in K28.1",$sformatf("Failed act:%h",o_act.dataout))
									ns = Reset;
								end
							end else begin
								if((o_act.dataout==10'b1001111100)||(o_act.dataout==10'b0110000011))begin
									`uvm_info(get_type_name(),$sformatf("K28.1 Output Match act:%h ",o_act.dataout),UVM_MEDIUM)
									count_28_1 = count_28_1+1;
									ns = K28_1;
								end else begin
									`uvm_fatal("Error Output Frame in K28.1",$sformatf("Failed act:%h",o_act.dataout))
									//ns = Reset;
								end
							end
						end else begin
							ns=K28_1;
						end
					end
					Data:begin
						if(o_act.pushout==1)begin
							if((o_act.dataout==10'b0001010111)||(o_act.dataout==10'b1110101000))begin//k23.7
								`uvm_info(get_type_name(),$sformatf("Data is K23.7 and go to CRC  act:%h ",o_act.dataout),UVM_MEDIUM)
								ns = CRC;
							end else if((o_act.dataout==10'b0101111100)||(o_act.dataout==10'b1010000011)) begin
								`uvm_error("Error Frame in current data packet which has K28.5",$sformatf("Failed act:%h",o_act.dataout))
								ns = Data;
							end else if((o_act.dataout==10'b1001111100)||(o_act.dataout==10'b0110000011))begin
								`uvm_error("Error Frame in current data packet which has K28.1",$sformatf("Failed act:%h",o_act.dataout))
								ns = Reset;
							end else begin
								`uvm_info(get_type_name(),$sformatf("Here is data  act:%h ",o_act.dataout),UVM_MEDIUM)
								ns = Data;
							end
						end else begin
							ns=Data;
						end
					end
					CRC:begin
						if(o_act.pushout==1)begin
							if(count_crc==3)begin
								if((o_act.dataout==10'b0101111100)||(o_act.dataout==10'b1010000011))begin//k28.5
									`uvm_fatal("Error Frame which K28_5 in crc packet",$sformatf("Failed act:%h",o_act.dataout))
									ns = Reset;
								end else if((o_act.dataout[5:0]==6'b111100)||(o_act.dataout[5:0]==6'b000011))begin//k28.x
									`uvm_error("Error Frame in current crc packet which has K28.x",$sformatf("Failed act:%h",o_act.dataout))
									ns = Reset;
								end else begin
									`uvm_info(get_type_name(),$sformatf("CRC Output act:%h ",o_act.dataout),UVM_MEDIUM)
									ns = K28_5;
								end
							end else begin
								if((o_act.dataout==10'b0101111100)||(o_act.dataout==10'b1010000011))begin//k28.5
									`uvm_fatal("Error Frame which K28_5 in crc packet",$sformatf("Failed act:%h",o_act.dataout))
									ns = Reset;
								end else if((o_act.dataout[5:0]==6'b111100)||(o_act.dataout[5:0]==6'b000011))begin//k28.x
									`uvm_error("Error Frame in current crc packet which has K28.x",$sformatf("Failed act:%h",o_act.dataout))
									ns = Reset;
								end else begin
									`uvm_info(get_type_name(),$sformatf("CRC Output act:%h ",o_act.dataout),UVM_MEDIUM)
									count_crc=count_crc+1;
									ns = CRC;
								end
							end
						end else begin
							ns = CRC;
						end
					end
					K28_5:begin
						count_crc=0;
						if(o_act.pushout==1)begin
							if((o_act.dataout==10'b0101111100)||(o_act.dataout==10'b1010000011))begin
								`uvm_info(get_type_name(),$sformatf("final data k28_5 in packet act:%h ",o_act.dataout),UVM_MEDIUM)
								ns = Reset;
							end else begin
								`uvm_error("Error Frame in the end of packet",$sformatf("Failed act:%h",o_act.dataout))
								ns=Reset;
							end
						end else begin
							ns=K28_5;
						end
					end
				endcase
				cs=ns;
			end
		join
	endtask : run_phase
endclass : cb_scoreboard_frameout
