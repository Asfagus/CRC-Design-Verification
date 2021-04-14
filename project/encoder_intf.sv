interface encoder_intf(input clk);

logic reset,startin,pushin;
logic [8:0] datain;
logic [9:0] dataout;
logic startout,pushout;
	
modport dut(input clk,input reset,input pushin,input datain,input startin,output pushout,output dataout,output startout);

endinterface: encoder_intf
