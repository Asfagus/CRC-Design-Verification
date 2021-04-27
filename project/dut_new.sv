`timescale 1ns/10ps

`include "crc32.sv"

module dut(input clk, input reset, input pushin,input [8:0] datain,
					input startin, output reg pushout, output reg [9:0] dataout, output reg startout);
	reg [5:0] d6;
	reg [3:0] d4;
	reg RD, RD_d;
	reg [9:0] dataout_d;
	reg [3:0] ones,zeros;
	reg startout_d, pushout_d;
	integer count, count_d, count_crc, count_crc_d;
	reg [9:0] dataout_temp, dataout_temp_d;
	reg [7:0] crc32_in;
	reg crc32_valid_in;
	wire [31:0] crc32_out;
	//reg [31:0] crc32_out1, crc32_out1_d;
	reg rst_n;
	reg [7:0] buffer, buffer_d;
	reg flag, flag_d;
	reg [8:0] data_buffer, data_buffer_d;
	
	crc32 a(.clk(clk),.rst_n(rst_n),.crc32_in(crc32_in),.crc32_valid_in(crc32_valid_in),.crc32_out(crc32_out));

    enum reg [2:0]{IDLE,
				K28,
				DATA,
				//DATA_3b,
				//k23_7,
				CRC,
				k28_5
	}cs,ns;

	//assign ones = $countbits(dataout_d,'1);
	//assign zeros = $countbits(dataout_d,'0);
	assign crc32_in = datain[7:0];
	//assign crc32_out1 = crc32_out;
	//assign rst_n = reset;
	

	always@(posedge clk)begin
		if(reset)begin
			pushout<=0;
			dataout<=0;
			startout<=0;
			RD<=0;
			count<=0;
			dataout_temp<=0;
			cs<=0;
			crc32_valid_in <= 0;
			count_crc<=0;
			//crc32_out1<=0;
			buffer<=0;
			flag<=0;
			data_buffer<=0;
			rst_n=1;
		end else begin
			RD<= RD_d;
			count<=count_d;
			dataout<=dataout_d;
			pushout<=pushout_d;
			startout<=startout_d;
			cs<=ns;
			count_crc<= count_crc_d;
		//	crc32_out1<=crc32_out1_d;
			buffer<=buffer_d;
			flag<=flag_d;
			data_buffer<=data_buffer_d;
			rst_n=0;
		end
	end

	always@(*)begin
		ns = cs;
		RD_d = RD;
		count_d = count;
		dataout_d = dataout;
		pushout_d = pushout;
		startout_d = startout;
		count_crc_d = count_crc;
		//crc32_out1_d = crc32_out1;
		flag_d = flag;
		buffer_d = buffer;
		data_buffer_d = data_buffer;
			case(cs)
				IDLE:begin
					rst_n=1;
					count_d = 0;
					pushout_d = 0;
					startout_d = 0;
					count_crc_d = 0;
					if(pushin&startin)begin
							if(datain==9'b100111100)begin//first K.28.1
								if(RD==0)begin//RD=-1
									startout_d = 1;
									pushout_d = 1;
									dataout_d = 10'b1001111100;
								end else begin//RD=1
									startout_d = 1;
									pushout_d = 1;
									dataout_d = 10'b0110000011;
								end
								RD_d = ~RD;
								ns = K28;
							end else begin
								ns = IDLE;
							end
					end else begin
						ns = IDLE;
					end
				end
				K28:begin
					if(pushin)begin
						crc32_valid_in = 0;
						if(datain==9'b100111100 & count<2)begin
							if(RD==0)begin //RD=-1
									startout_d = 0;
									pushout_d = 1;
									dataout_d = 10'b1001111100;
									
							end else begin//RD=1
									startout_d = 0;
									pushout_d = 1;
									dataout_d = 10'b0110000011;
									
							end
							RD_d = ~RD;
							count_d = count+1;
							ns = K28;
						end else if (datain==9'b100111100 & count==2)begin
							if(RD==0)begin //RD=-1
									pushout_d = 1;
									dataout_d = 10'b1001111100;
							end else begin//RD=1
									pushout_d = 1;
									dataout_d = 10'b0110000011;
							end
							RD_d = ~RD;
							ns = DATA;
							count_d = 0;
						end else begin
							ns = IDLE;
							$display("K.28.1 has error");
						end
					end else begin
						ns = K28;
						$display("pushin has error during K.28.1");
					end
				end
				DATA:begin
					if(pushin==1)begin
						if(datain==9'b110111100)begin
							crc32_valid_in = 0;
							if(RD==0)begin
								pushout_d = 1;
								dataout_d = 10'b0001010111;
							end else begin
								pushout_d = 1;
								dataout_d = 10'b1110101000;
							end
							RD_d = RD;
							ns = CRC;
						end else if(datain[8]==0)begin
							crc32_valid_in = 1;
							case(datain[4:0])
							0:begin
								if(RD==0)begin
									d6 = 6'b111001;
								end else begin
									d6 = 6'b000110;
								end
								//RD_d = ~RD;
							end
							1:begin
								if(RD==0)begin
									d6 = 6'b101110;
								end else begin
									d6 = 6'b010001;
								end
								//RD_d = ~RD;
							end
							2:begin
								if(RD==0)begin
									d6 = 6'b101101;
								end else begin
									d6 = 6'b010010;
								end
								//RD_d = ~RD;
							end
							3:begin
								d6 = 6'b100011;
								//RD_d = RD;
							end
							4:begin
								if(RD==0)begin
									d6 = 6'b101011;
								end else begin
									d6 = 6'b010100;
								end
								//RD_d = ~RD;
							end
							5:begin
								d6 = 6'b100101;
								//RD_d = RD;
							end
							6:begin
								d6 = 6'b100110;
								//RD_d = RD;
							end
							7:begin////check
								if(RD==0)begin
									d6 = 6'b000111;
								end else begin
									d6 = 6'b111000;
								end
								//RD_d = RD;
							end
							8:begin
								if(RD==0)begin
									d6 = 6'b100111;
								end else begin
									d6 = 6'b011000;
								end
								//RD_d = ~RD;
							end
							9:begin
								d6 = 6'b101001;
								//RD_d = RD;
							end
							10:begin
								d6 = 6'b101010;
								//RD_d = RD;
							end
							11:begin
								d6 = 6'b001011;
								//RD_d = RD;
							end
							12:begin
								d6 = 6'b101100;
								//RD_d = RD;
							end
							13:begin
								d6 = 6'b001101;
								//RD_d = RD;
							end
							14:begin
								d6 = 6'b001110;
								//RD_d = RD;
							end
							15:begin
								if(RD==0)begin
									d6 = 6'b111010;
								end else begin
									d6 = 6'b000101;
								end
								//RD_d = ~RD;
							end
							16:begin
								if(RD==0)begin
									d6 = 6'b110110;
								end else begin
									d6 = 6'b001001;
								end
								//RD_d = ~RD;
							end
							17:begin
								d6 = 6'b110001;
								//RD_d = RD;
							end
							18:begin
								d6 = 6'b110010;
								//RD_d = RD;
							end
							19:begin
								d6 = 6'b010011;
								//RD_d = RD;
							end
							20:begin
								d6 = 6'b110100;
								//RD_d = RD;
							end
							21:begin
								d6 = 6'b010101;
								//RD_d = RD;
							end
							22:begin
								d6 = 6'b010110;
								//RD_d = RD;
							end
							23:begin
								if(RD==0)begin
									d6 = 6'b010111;
								end else begin
									d6 = 6'b101000;
								end
								//RD_d = ~RD;
							end
							24:begin
								if(RD==0)begin
									d6 = 6'b110011;
								end else begin
									d6 = 6'b001100;
								end
								//RD_d = ~RD;
							end
							25:begin
								d6 = 6'b011001;
								//RD_d = RD;
							end
							26:begin
								d6 = 6'b011010;
								//RD_d = RD;
							end
							27:begin
								if(RD==0)begin
									d6 = 6'b011011;
								end else begin
									d6 = 6'b100100;
								end
								//RD_d = ~RD;
							end
							28:begin
								d6 = 6'b011100;
								//RD_d = RD;
							end
							29:begin
								if(RD==0)begin
									d6 = 6'b011101;
								end else begin
									d6 = 6'b100010;
								end
								//RD_d = ~RD;
							end
							30:begin
								if(RD==0)begin
									d6 = 6'b011110;
								end else begin
									d6 = 6'b100001;
								end
								//RD_d = ~RD;
							end
							31:begin
								if(RD==0)begin
									d6 = 6'b110101;
								end else begin
									d6 = 6'b001010;
								end
								//RD_d = ~RD;
							end
							endcase
							case(datain[7:5])
							0:begin
								if($countones(d6)==3'b011)begin
									if(RD==0)begin
										d4 = 4'b1101;
									end else begin
										d4 = 4'b0010;
									end
								end else begin
									if(RD==1)begin
										d4 = 4'b1101;
									end else begin
										d4 = 4'b0010;
									end
								end
							end
							1:begin
								d4 = 4'b1001;
							end
							2:begin
								d4 = 4'b1010;
							end
							3:begin
								if($countones(d6)==3'b011)begin
									if(RD==0)begin
										d4 = 4'b0011;
									end else begin
										d4 = 4'b1100;
									end
								end else begin
									if(RD==0)begin
										d4 = 4'b1100;
									end else begin
										d4 = 4'b0011;
									end
								end
							end
							4:begin
								if($countones(d6)==3'b011)begin
									if(RD==0)begin
										d4 = 4'b1011;
									end else begin
										d4 = 4'b0100;
									end
								end else begin
									if(RD==1)begin
										d4 = 4'b1011;
									end else begin
										d4 = 4'b0100;
									end
								end
							end
							5:begin
								d4 = 4'b0101;
							end
							6:begin
								d4 = 4'b0110;
							end
							7:begin
								if($countones(d6)==3'b011)begin
									if(datain[4:0]==5'b10001 | datain[4:0]==5'b10010 | datain[4:0]==5'b10100)begin
										if(RD==0)begin
											d4 = 4'b1110;
										end else begin
											d4 = 4'b1000;
										end
									end else if(datain[4:0]==5'b01011 | datain[4:0]==5'b01101 | datain[4:0]==5'b01110) begin
										if(RD==0)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b0001;
										end	
									end else begin
										if(RD==0)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b1000;
										end		
									end
								end else begin
									if(datain[4:0]==5'b10001 | datain[4:0]==5'b10010 | datain[4:0]==5'b10100)begin
										if(RD==1)begin
											d4 = 4'b1110;
										end else begin
											d4 = 4'b1000;
										end
									end else if(datain[4:0]==5'b01011 | datain[4:0]==5'b01101 | datain[4:0]==5'b01110) begin
										if(RD==1)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b0001;
										end	
									end else begin
										if(RD==1)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b1000;
										end		
									end
								end
							end
							endcase
							pushout_d = 1;
							dataout_d = {d4,d6};
							if($countones(dataout_d)==4'b0101)begin
								RD_d = RD;
							end else if($countones(dataout_d)==4'b0110 | $countones(dataout_d)==4'b0100)begin
								RD_d = ~RD;
							end else begin
								$display("data is invalid");
							end
							ns = DATA;
						end else begin
							crc32_valid_in=0;
							case(datain[7:0])
							8'h1c:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b0010111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b1101000011;
								end
								RD_d = RD;
							end
							8'h3c:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b1001111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b0110000011;
								end
								RD_d = ~RD;
							end
							8'h5c:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b1010111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b0101000011;
								end
								RD_d = ~RD;
							end
							8'h7c:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b1100111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b0011000011;
								end
								RD_d = ~RD;
							end
							8'h9c:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b0100111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b1011000011;
								end
								RD_d = RD;
							end
							8'hDC:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b0110111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b1001000011;
								end
								RD_d = ~RD;
							end
							8'hFC:begin
								if(RD==0)begin
									pushout_d=1;
									dataout_d = 10'b0001111100;
								end else begin
									pushout_d=1;
									dataout_d = 10'b1110000011;
								end
								RD_d = RD;
							end
						8'hF7:begin
							if(RD==0)begin
								pushout_d=1;
								dataout_d = 10'b0001010111;
							end else begin
								pushout_d=1;
								dataout_d = 10'b1110101000;
							end
							RD_d = RD;
						end
						8'hFB:begin
							if(RD==0)begin
								pushout_d=1;
								dataout_d = 10'b0001011011;
							end else begin
								pushout_d=1;
								dataout_d = 10'b1110100100;
							end
							RD_d = RD;
						end
						8'hFD:begin
							if(RD==0)begin
								pushout_d=1;
								dataout_d = 10'b0001011101;
							end else begin
								pushout_d=1;
								dataout_d = 10'b1110100010;
							end
							RD_d = RD;
						end
						8'hFE:begin
							if(RD==0)begin
								pushout_d=1;
								dataout_d = 10'b0001011110;
							end else begin
								pushout_d=1;
								dataout_d = 10'b1110100001;
							end
							RD_d = RD;
						end
						endcase
						ns = DATA;
					end
				end else begin
					pushout_d = 0;
					ns = DATA;
				end
			end

				CRC:begin//count=3, ns=28_5
					//if(flag==1)begin
					case(count_crc)
						0:begin
							buffer_d = crc32_out[7:0];
						end
						1:begin
							buffer_d = crc32_out[15:8];
						end
						2:begin
							buffer_d = crc32_out[23:16];
						end
						3:begin
							buffer_d = crc32_out[31:24];
						end
					endcase
					case(buffer_d[4:0])
							0:begin
								if(RD==0)begin
									d6 = 6'b111001;
								end else begin
									d6 = 6'b000110;
								end
								//RD_d = ~RD;
							end
							1:begin
								if(RD==0)begin
									d6 = 6'b101110;
								end else begin
									d6 = 6'b010001;
								end
								//RD_d = ~RD;
							end
							2:begin
								if(RD==0)begin
									d6 = 6'b101101;
								end else begin
									d6 = 6'b010010;
								end
								//RD_d = ~RD;
							end
							3:begin
								d6 = 6'b100011;
								//RD_d = RD;
							end
							4:begin
								if(RD==0)begin
									d6 = 6'b101011;
								end else begin
									d6 = 6'b010100;
								end
								//RD_d = ~RD;
							end
							5:begin
								d6 = 6'b100101;
								//RD_d = RD;
							end
							6:begin
								d6 = 6'b100110;
								//RD_d = RD;
							end
							7:begin////check
								if(RD==0)begin
									d6 = 6'b000111;
								end else begin
									d6 = 6'b111000;
								end
								//RD_d = RD;
							end
							8:begin
								if(RD==0)begin
									d6 = 6'b100111;
								end else begin
									d6 = 6'b011000;
								end
								//RD_d = ~RD;
							end
							9:begin
								d6 = 6'b101001;
								//RD_d = RD;
							end
							10:begin
								d6 = 6'b101010;
								//RD_d = RD;
							end
							11:begin
								d6 = 6'b001011;
								//RD_d = RD;
							end
							12:begin
								d6 = 6'b101100;
								//RD_d = RD;
							end
							13:begin
								d6 = 6'b001101;
								//RD_d = RD;
							end
							14:begin
								d6 = 6'b001110;
								//RD_d = RD;
							end
							15:begin
								if(RD==0)begin
									d6 = 6'b111010;
								end else begin
									d6 = 6'b000101;
								end
								//RD_d = ~RD;
							end
							16:begin
								if(RD==0)begin
									d6 = 6'b110110;
								end else begin
									d6 = 6'b001001;
								end
								//RD_d = ~RD;
							end
							17:begin
								d6 = 6'b110001;
								//RD_d = RD;
							end
							18:begin
								d6 = 6'b110010;
								//RD_d = RD;
							end
							19:begin
								d6 = 6'b010011;
								//RD_d = RD;
							end
							20:begin
								d6 = 6'b110100;
								//RD_d = RD;
							end
							21:begin
								d6 = 6'b010101;
								//RD_d = RD;
							end
							22:begin
								d6 = 6'b010110;
								//RD_d = RD;
							end
							23:begin
								if(RD==0)begin
									d6 = 6'b010111;
								end else begin
									d6 = 6'b101000;
								end
								//RD_d = ~RD;
							end
							24:begin
								if(RD==0)begin
									d6 = 6'b110011;
								end else begin
									d6 = 6'b001100;
								end
								//RD_d = ~RD;
							end
							25:begin
								d6 = 6'b011001;
								//RD_d = RD;
							end
							26:begin
								d6 = 6'b011010;
								//RD_d = RD;
							end
							27:begin
								if(RD==0)begin
									d6 = 6'b011011;
								end else begin
									d6 = 6'b100100;
								end
								//RD_d = ~RD;
							end
							28:begin
								d6 = 6'b011100;
								//RD_d = RD;
							end
							29:begin
								if(RD==0)begin
									d6 = 6'b011101;
								end else begin
									d6 = 6'b100010;
								end
								//RD_d = ~RD;
							end
							30:begin
								if(RD==0)begin
									d6 = 6'b011110;
								end else begin
									d6 = 6'b100001;
								end
								//RD_d = ~RD;
							end
							31:begin
								if(RD==0)begin
									d6 = 6'b110101;
								end else begin
									d6 = 6'b001010;
								end
								//RD_d = ~RD;
							end
							endcase
							case(buffer_d[7:5])
							0:begin
								if($countones(d6)==3'b011)begin
									if(RD==0)begin
										d4 = 4'b1101;
									end else begin
										d4 = 4'b0010;
									end
								end else begin
									if(RD==1)begin
										d4 = 4'b1101;
									end else begin
										d4 = 4'b0010;
									end
								end
							end
							1:begin
								d4 = 4'b1001;
							end
							2:begin
								d4 = 4'b1010;
							end
							3:begin
								if($countones(d6)==3'b011)begin
									if(RD==0)begin
										d4 = 4'b0011;
									end else begin
										d4 = 4'b1100;
									end
								end else begin
									if(RD==0)begin
										d4 = 4'b1100;
									end else begin
										d4 = 4'b0011;
									end
								end
							end
							4:begin
								if($countones(d6)==3'b011)begin
									if(RD==0)begin
										d4 = 4'b1011;
									end else begin
										d4 = 4'b0100;
									end
								end else begin
									if(RD==1)begin
										d4 = 4'b1011;
									end else begin
										d4 = 4'b0100;
									end
								end
							end
							5:begin
								d4 = 4'b0101;
							end
							6:begin
								d4 = 4'b0110;
							end
							7:begin
								if($countones(d6)==3'b011)begin
									if(datain[4:0]==5'b10001 | datain[4:0]==5'b10010 | datain[4:0]==5'b10100)begin
										if(RD==0)begin
											d4 = 4'b1110;
										end else begin
											d4 = 4'b1000;
										end
									end else if(datain[4:0]==5'b01011 | datain[4:0]==5'b01101 | datain[4:0]==5'b01110) begin
										if(RD==0)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b0001;
										end	
									end else begin
										if(RD==0)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b1000;
										end		
									end
								end else begin
									if(datain[4:0]==5'b10001 | datain[4:0]==5'b10010 | datain[4:0]==5'b10100)begin
										if(RD==1)begin
											d4 = 4'b1110;
										end else begin
											d4 = 4'b1000;
										end
									end else if(datain[4:0]==5'b01011 | datain[4:0]==5'b01101 | datain[4:0]==5'b01110) begin
										if(RD==1)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b0001;
										end	
									end else begin
										if(RD==1)begin
											d4 = 4'b0111;
										end else begin
											d4 = 4'b1000;
										end		
									end
								end
							end
							endcase
						pushout_d = 1;
						dataout_d= {d4,d6};
						if(count_crc==3)begin
							if($countones(dataout_d)==4'b0101)begin
								RD_d = RD;
								ns = k28_5;
								//flag_d = 0;
							end else if($countones(dataout_d)==4'b0110 | $countones(dataout_d)==4'b0100)begin
								RD_d = ~RD;
								ns = k28_5;
								//flag_d = 0;
							end else begin
								$display("data is invalid");
							end
						end else begin
							count_crc_d = count_crc+1;
							if($countones(dataout_d)==4'b0101)begin
								RD_d = RD;
								ns = CRC;
							end else if($countones(dataout_d)==4'b0110 | $countones(dataout_d)==4'b0100)begin
								RD_d = ~RD;
								ns = CRC;
							end else begin
								$display("data is invalid");
							end
						end
						//end else begin
							//ns = DATA;
						//end
						
					
				end
				k28_5:begin
					if(RD==0)begin
						pushout_d = 1;
						dataout_d = 10'b0101111100;
						RD_d = ~RD;
					end else begin
						pushout_d = 1;
						dataout_d = 10'b1010000011;
						RD_d = ~RD;
					end
					ns = IDLE;
				end
			endcase
		end


		



endmodule : dut
