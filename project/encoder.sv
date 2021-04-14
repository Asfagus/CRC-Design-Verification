//module fifo(clk,rst,read,write,pushin,datain,pushout,dataout);
//`include "fifo_intf.sv"
module encoder(encoder_intf.dut m);
/*input clk,rst,read,write,pushin;
input logic [31:0] datain;
output logic [31:0] dataout;
output logic pushout;*/
logic [3:0][8:0]fifomem ;
int wcounter;
//logic empty,full;
/*always @(*) begin
	if(count <=0) begin
			m.empty = 1;
			$display("FIFO !!! EMPTY ");
		end else begin
			m.empty = 0;
		end
		if(count >= 4 ) begin
			m.full = 1;
			//count <= #1 3;
			$display("FIFO OVERFLOW!!! %h", fifomem);
		end
		else begin
			m.full =  0;
		end
end*/


always @ (posedge m.clk or posedge m.reset) begin
	if (m.reset) begin
		m.dataout<=0;
		m.pushout<=0;
		m.startout<=0;
		wcounter <=0;
		for(int i=0;i<4;i++) begin
				fifomem[i] <= 8'h0;
		end	
	end
	else begin
		
		if(m.startin && m.pushin && wcounter<5) begin
			fifomem[wcounter] <= #1 m.datain;
			wcounter <= #1 wcounter+1;
			$display(" data in =%0b startin =%0b pushin =%0b fifomem=%h wcounter=%0d",m.datain,m.startin,m.pushin,fifomem,wcounter);
		
		end
	end

end
endmodule
