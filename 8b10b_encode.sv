module 8b10b_encoder(input clk, input reset, input pushin,input [8:0] datain,
					input startin, output reg pushot, output reg [9:0] dataout, output reg startout);
	reg [5:0] d6;
	reg [3:0] d4;
	reg sel;// select RD
	reg signed [1:0] curr_RD, next_RD;
	reg signed [2:0] disparity;

	//typedef enum{IDLE,

	//}cs,ns;

	always@(posedge clk)
		if(reset)begin

		end else begin


		end

		always@(posedge clk)begin
			if(startin)begin
				//case(cs)
					//IDLE:begin
						if(curr_RD == -1)begin
							if(disparity==0)begin
								next_RD <= -1；
							end else if (disparity==2)begin
								next_RD <= 1;
							end 
						end else if(curr_RD==1)begin
							if(disparity==0)begin
								next_RD <= 1；
							end else if (disparity==-2)begin
								next_RD <= -1;
							end 
					//end

			end

		end




endmodule : 8b_10b_encoder
