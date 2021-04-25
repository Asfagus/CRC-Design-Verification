`timescale 1ns/10ps
`include "encoder_intf.sv"
package sheethal;
//include "fifo_intf.sv"// It is never kept inside package because they need to be accesed by ever1
import uvm_pkg::*;
`include "cb_si.sv"
`include "mimsg.sv"
`include "momsg.sv"
`include "cb_seq1.sv"
`include "cb_seqr.sv"
`include "cb_drv.sv"
`include "cb_mon_in.sv"
`include "cb_mon_out.sv"
`include "cb_agent.sv"
`include "cb_scoreboard0.sv"
`include "cb_scoreboard8b10b.sv"
`include "cb_scoreboard1.sv"
`include "cb_scoreboard_disparity.sv"
`include "cb_scoreboard_datachk.sv"
`include "cb_scoreboard_checkercrc.sv"
`include "cb_scoreboard_crc.sv"
`include "cb_env.sv"
`include "cb_test.sv"
endpackage: sheethal
import uvm_pkg::*;

module top();
//Interface has already been connected to DUT now it needs to be connected to the top module
reg clk;
encoder_intf intf(clk);//instantiate the interface
initial begin
	uvm_config_db #(virtual encoder_intf)::set(null,"sheethal","intf",intf);//?? we have to connect a static DUT to a OOP based envirpnemnt hence this syntax
	run_test("cb_test");
end
initial begin
	clk =0;
	forever begin
		#5 clk = ~clk;
	end
end
initial begin
	$dumpfile("encoder.vcd");
	$dumpvars(9,top);
end
encoder f(intf.dut);//instantiate grey scale which is the DUT to the interface
endmodule:top
`include "encoder.sv"
