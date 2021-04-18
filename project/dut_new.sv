`timescale 1ns/10ps

//`include "crc32.sv"
//Need to reverse the bits for 10bit in dataout
//Eg 0f9==27C

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
	reg [7:0] buffer, buffer_d;
	reg flag, flag_d;

    enum reg [2:0]{IDLE,
				K28,
				DATA,
				//k23_7,
				CRC,
				k28_5
	}cs,ns;

	//assign ones = $countbits(dataout_d,'1);
	//assign zeros = $countbits(dataout_d,'0);
	assign crc32_in = datain[7:0];
	//assign crc32_out1 = crc32_out;

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
			case(cs)
				IDLE:begin
					count_d = 0;
					pushout_d = 0;
					startout_d = 0;
					count_crc_d = 0;
					if(pushin&startin)begin
							if(datain==9'b100111100)begin//first K.28.1
								if(RD==0)begin//RD=-1
									startout_d = 1;
									pushout_d = 1;
									dataout_d = 10'b0011111001;
								end else begin//RD=1
									startout_d = 1;
									pushout_d = 1;
									dataout_d = 10'b1100000110;
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
									dataout_d = 10'b0011111001;
									
							end else begin//RD=1
									startout_d = 0;
									pushout_d = 1;
									dataout_d = 10'b1100000110;
									
							end
							RD_d = ~RD;
							count_d = count+1;
							ns = K28;
						end else if (datain==9'b100111100 & count==2)begin
							if(RD==0)begin //RD=-1
									pushout_d = 1;
									dataout_d = 10'b0011111001;
							end else begin//RD=1
									pushout_d = 1;
									dataout_d = 10'b1100000110;
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
				DATA:begin//data packet
					if(pushin==1)begin//think about k.28.3...
						//crc32_valid_in = 1;
						if(datain==9'b110111100)begin
							crc32_valid_in = 0;
							if(RD==0)begin
								pushout_d = 1;
								dataout_d = 10'b1110101000;
							end else begin
								pushout_d = 1;
								dataout_d = 10'b0001010111;
							end
							RD_d = RD;
							flag_d = 1;
							ns = CRC;
						end else if(datain[8]==0)begin
						crc32_valid_in = 1;
						case(datain[4:0])//5b/6b
							5'b00000:begin//D.00
								if(RD==0)begin
									d6 = 6'b100111;
								end else begin
									d6 = 6'b011000;
								end
							end
							5'b00001:begin//D.01
								if(RD==0)begin
									d6 = 6'b011101;
								end else begin
									d6 = 6'b100010;
								end
							end
							5'b00010:begin//D.02
								if(RD==0)begin
									d6 = 6'b101101;
								end else begin
									d6 = 6'b010010;
								end
							end
							5'b00011:begin//D.03
								d6 = 6'b110001;
							end
							5'b00100:begin//D.04
								if(RD==0)begin
									d6 = 6'b110101;
								end else begin
									d6 = 6'b001010;
								end
							end
							5'b00101:begin//D.05
								d6 = 6'b101001;
							end
							5'b00110:begin//D.06
								d6 = 6'b011001;
							end
							5'b00111:begin//D.07
								if(RD==0)begin
									d6 = 6'b111000;
								end else begin
									d6 = 6'b000111;
								end
							end
							5'b01000:begin//D.08
								if(RD==0)begin
									d6 = 6'b111001;
								end else begin
									d6 = 6'b000110;
								end
							end
							5'b01001:begin//D.09
								d6 = 6'b100101;
							end
							5'b01010:begin//D.10
								d6 = 6'b010101;
							end
							5'b01011:begin//D.11
								d6 = 6'b110100;
							end
							5'b01100:begin//D.12
								d6 = 6'b001101;
							end
							5'b01101:begin//D.13
								d6 = 6'b101100;
							end
							5'b01110:begin//D.14
								d6 = 6'b011100;
							end
							5'b01111:begin//D.15
								if(RD==0)begin
									d6 = 6'b010111;
								end else begin
									d6 = 6'b101000;
								end
							end
							5'b01111:begin//D.15
								if(RD==0)begin
									d6 = 6'b010111;
								end else begin
									d6 = 6'b101000;
								end
							end
							5'b10000:begin//D.16
								if(RD==0)begin
									d6 = 6'b011011;
								end else begin
									d6 = 6'b100100;
								end
							end
							5'b10001:begin//D.17
								d6 = 6'b100011;
							end
							5'b10010:begin//D.18
								d6 = 6'b010011;
							end
							5'b10011:begin//D.19
								d6 = 6'b110010;
							end
							5'b10100:begin//D.20
								d6 = 6'b001011;
							end
							5'b10101:begin//D.21
								d6 = 6'b101010;
							end
							5'b10110:begin//D.22
								d6 = 6'b011010;
							end
							5'b10111:begin//D.23
								if(RD==0)begin
									d6 = 6'b111010;
								end else begin
									d6 = 6'b000101;
								end
							end
							5'b11000:begin//D.24
								if(RD==0)begin
									d6 = 6'b110011;
								end else begin
									d6 = 6'b001100;
								end
							end
							5'b11001:begin//D.25
								d6 = 6'b100110;
							end
							5'b11010:begin//D.26
								d6 = 6'b010110;
							end
							5'b11011:begin//D.27
								if(RD==0)begin
									d6 = 6'b110110;
								end else begin
									d6 = 6'b001001;
								end
							end
							5'b11100:begin//D.28
								d6 = 6'b001110;
							end
							5'b11101:begin//D.29
								if(RD==0)begin
									d6 = 6'b101110;
								end else begin
									d6 = 6'b010001;
								end
							end
							5'b11110:begin//D.30
								if(RD==0)begin
									d6 = 6'b011110;
								end else begin
									d6 = 6'b100001;
								end
							end
							5'b11011:begin//D.31
								if(RD==0)begin
									d6 = 6'b101011;
								end else begin
									d6 = 6'b010100;
								end
							end
						endcase
						case(datain[7:5])//3b/4b
							3'b000:begin
								if(RD==0)begin
									d4 = 4'b1011;
								end else begin
									d4 = 4'b0100;
								end
							end
							3'b001:begin
								d4 = 4'b1001;
							end
							3'b010:begin
								d4 = 4'b0101;
							end
							3'b011:begin
								if(RD==0)begin
									d4 = 4'b1100;
								end else begin
									d4 = 4'b0011;
								end
							end
							3'b100:begin
								if(RD==0)begin
									d4 = 4'b1101;
								end else begin
									d4 = 4'b0010;
								end
							end
							3'b101:begin
								d4 = 4'b1010;
							end
							3'b110:begin
								d4 = 4'b0110;
							end
							3'b111:begin////////////////////////////////////
								if(datain[4:0]==5'b10001 | datain[4:0]==5'b10010 | datain[4:0]==5'b10100)begin
									if(RD==0)begin
										d4 = 4'b0111;
									end else begin
										d4 = 4'b0001;
									end
								end else if(datain[4:0]==5'b01011 | datain[4:0]==5'b01101 | datain[4:0]==5'b01110) begin
									if(RD==0)begin
										d4 = 4'b1110;
									end else begin
										d4 = 4'b1000;
									end
								end else begin
									if(RD==0)begin
										d4 = 4'b1110;
									end else begin
										d4 = 4'b0001;
									end
								end
							end
						endcase
						pushout_d = 1;
						dataout_d= {d6,d4};////////0 and 1 problem
							if($countones(dataout_d)==4'b0101)begin
								RD_d = RD;
								ns = DATA;
							end else if($countones(dataout_d)==4'b0110 | $countones(dataout_d)==4'b0100)begin
								RD_d = ~RD;
								ns = DATA;
							end else begin
								$display("data is invalid");
							end
						end else begin
							crc32_valid_in = 0;
							case(datain[7:0])
								8'b00011100:begin//K.28.0
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011110100;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100001011;
									end
								end
								8'b00111100:begin//K.28.1
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011111001;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100000110;
									end
								end
								8'b01011100:begin//K.28.2
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011110101;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100001010;
									end
								end
								8'b01111100:begin//K.28.3
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011110011;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100001100;
									end
								end
								8'b10011100:begin//K.28.4
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011111001;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100000110;
									end
								end
								8'b11011100:begin//K.28.6
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011110110;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100001001;
									end
								end
								8'b11111100:begin//K.28.7
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0011111001;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1100000110;
									end
								end
								8'b11110111:begin//K.23.7
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b1110101000;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b0001010111;
									end
								end
								8'b11111011:begin//K.27.7
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b1101101000;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b0010010111;
									end
								end
								8'b11111101:begin//K.29.7
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b1011101000;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b0100010111;
									end
								end
								8'b11111110:begin//K.30.7
									if(RD==0)begin
										pushout_d = 1;
										dataout_d = 10'b0111101000;
									end else begin
										pushout_d = 1;
										dataout_d = 10'b1000010111;
									end
								end
							endcase
							if($countones(dataout_d)==4'b0101)begin
								RD_d = RD;
								ns = DATA;
							end else if($countones(dataout_d)==4'b0110 | $countones(dataout_d)==4'b0100)begin
								RD_d = ~RD;
								ns = DATA;
							end else begin
								$display("data is invalid");
							end
						end
						
					end else begin
						ns = DATA;
						//$display("data packet has error");
					end
				end
				/*k23_7:begin
					if(RD==0)begin
						pushout_d = 1;
						dataout_d = 10'b1110101000;
					end else begin
						pushout_d = 1;
						dataout_d = 10'b0001010111;
					end
					RD_d = RD;
					ns = CRC;
				end*/
				CRC:begin//count=3, ns=28_5
					/*if(flag==1)begin
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
						5'b00000:begin//D.00
								if(RD==0)begin
									d6 = 6'b100111;
								end else begin
									d6 = 6'b011000;
								end
							end
							5'b00001:begin//D.01
								if(RD==0)begin
									d6 = 6'b011101;
								end else begin
									d6 = 6'b100010;
								end
							end
							5'b00010:begin//D.02
								if(RD==0)begin
									d6 = 6'b101101;
								end else begin
									d6 = 6'b010010;
								end
							end
							5'b00011:begin//D.03
								d6 = 6'b110001;
							end
							5'b00100:begin//D.04
								if(RD==0)begin
									d6 = 6'b110101;
								end else begin
									d6 = 6'b001010;
								end
							end
							5'b00101:begin//D.05
								d6 = 6'b101001;
							end
							5'b00110:begin//D.06
								d6 = 6'b011001;
							end
							5'b00111:begin//D.07
								if(RD==0)begin
									d6 = 6'b111000;
								end else begin
									d6 = 6'b000111;
								end
							end
							5'b01000:begin//D.08
								if(RD==0)begin
									d6 = 6'b111001;
								end else begin
									d6 = 6'b000110;
								end
							end
							5'b01001:begin//D.09
								d6 = 6'b100101;
							end
							5'b01010:begin//D.10
								d6 = 6'b010101;
							end
							5'b01011:begin//D.11
								d6 = 6'b110100;
							end
							5'b01100:begin//D.12
								d6 = 6'b001101;
							end
							5'b01101:begin//D.13
								d6 = 6'b101100;
							end
							5'b01110:begin//D.14
								d6 = 6'b011100;
							end
							5'b01111:begin//D.15
								if(RD==0)begin
									d6 = 6'b010111;
								end else begin
									d6 = 6'b101000;
								end
							end
							5'b01111:begin//D.15
								if(RD==0)begin
									d6 = 6'b010111;
								end else begin
									d6 = 6'b101000;
								end
							end
							5'b10000:begin//D.16
								if(RD==0)begin
									d6 = 6'b011011;
								end else begin
									d6 = 6'b100100;
								end
							end
							5'b10001:begin//D.17
								d6 = 6'b100011;
							end
							5'b10010:begin//D.18
								d6 = 6'b010011;
							end
							5'b10011:begin//D.19
								d6 = 6'b110010;
							end
							5'b10100:begin//D.20
								d6 = 6'b001011;
							end
							5'b10101:begin//D.21
								d6 = 6'b101010;
							end
							5'b10110:begin//D.22
								d6 = 6'b011010;
							end
							5'b10111:begin//D.23
								if(RD==0)begin
									d6 = 6'b111010;
								end else begin
									d6 = 6'b000101;
								end
							end
							5'b11000:begin//D.24
								if(RD==0)begin
									d6 = 6'b110011;
								end else begin
									d6 = 6'b001100;
								end
							end
							5'b11001:begin//D.25
								d6 = 6'b100110;
							end
							5'b11010:begin//D.26
								d6 = 6'b010110;
							end
							5'b11011:begin//D.27
								if(RD==0)begin
									d6 = 6'b110110;
								end else begin
									d6 = 6'b001001;
								end
							end
							5'b11100:begin//D.28
								d6 = 6'b001110;
							end
							5'b11101:begin//D.29
								if(RD==0)begin
									d6 = 6'b101110;
								end else begin
									d6 = 6'b010001;
								end
							end
							5'b11110:begin//D.30
								if(RD==0)begin
									d6 = 6'b011110;
								end else begin
									d6 = 6'b100001;
								end
							end
							5'b11011:begin//D.31
								if(RD==0)begin
									d6 = 6'b101011;
								end else begin
									d6 = 6'b010100;
								end
							end
						endcase
						case(buffer_d[7:5])//3b/4b
							3'b000:begin
								if(RD==0)begin
									d4 = 4'b1011;
								end else begin
									d4 = 4'b0100;
								end
							end
							3'b001:begin
								d4 = 4'b1001;
							end
							3'b010:begin
								d4 = 4'b0101;
							end
							3'b011:begin
								if(RD==0)begin
									d4 = 4'b1100;
								end else begin
									d4 = 4'b0011;
								end
							end
							3'b100:begin
								if(RD==0)begin
									d4 = 4'b1101;
								end else begin
									d4 = 4'b0010;
								end
							end
							3'b101:begin
								d4 = 4'b1010;
							end
							3'b110:begin
								d4 = 4'b0110;
							end
							3'b111:begin////////////////////////////////////
								if(datain[4:0]==5'b10001 | datain[4:0]==5'b10010 | datain[4:0]==5'b10100)begin
									if(RD==0)begin
										d4 = 4'b0111;
									end else begin
										d4 = 4'b0001;
									end
								end else if(datain[4:0]==5'b01011 | datain[4:0]==5'b01101 | datain[4:0]==5'b01110) begin
									if(RD==0)begin
										d4 = 4'b1110;
									end else begin
										d4 = 4'b1000;
									end
								end else begin
									if(RD==0)begin
										d4 = 4'b1110;
									end else begin
										d4 = 4'b0001;
									end
								end
							end
						endcase
						pushout_d = 1;
						dataout_d= {d6,d4};
						if(count_crc==3)begin
							if($countones(dataout_d)==4'b0101)begin
								RD_d = RD;
								ns = k28_5;
								flag_d = 0;
							end else if($countones(dataout_d)==4'b0110 | $countones(dataout_d)==4'b0100)begin
								RD_d = ~RD;
								ns = k28_5;
								flag_d = 0;
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
						end else begin
							ns = DATA;
						end*/
						ns = k28_5;
					
				end
				k28_5:begin
					if(RD==0)begin
						pushout_d = 1;
						dataout_d = 10'b0011111010;
					end else begin
						pushout_d = 1;
						dataout_d = 10'b1100000101;
					end
					ns = IDLE;
				end
			endcase
		end


		



endmodule : dut
