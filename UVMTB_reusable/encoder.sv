// Converts the interface to dut signals

`include "dut.sv"
module encoder(encoder_intf.dut m);

wire [9:0] dout;
assign m.dataout=dout;//{dout[0],dout[1],dout[2],dout[3],dout[4],dout[5],dout[6],dout[7],dout[8],dout[9]};	//reversed dout

dut d1(m.clk, m.reset, m.pushin,m.datain,m.startin, m.pushout, dout, m.startout);

endmodule
