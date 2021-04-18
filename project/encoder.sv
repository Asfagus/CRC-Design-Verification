// Converts the interface to dut signals

`include "dut_new.sv"
module encoder(encoder_intf.dut m);

dut d1(m.clk, m.reset, m.pushin,m.datain,m.startin, m.pushout, m.dataout, m.startout);

endmodule
