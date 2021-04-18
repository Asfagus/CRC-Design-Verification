module testbench();
    // Module inputs
	logic clk;
	logic rst_n;
 	logic [7:0] crc32_in;
    logic crc32_valid_in;

	// Module outputs
  logic [31:0] crc32_out;
  
  crc32 dut(.clk(clk),.rst_n(rst_n),.crc32_in(crc32_in),.crc32_valid_in(crc32_valid_in),.crc32_out(crc32_out));
  
  initial
    begin
    	clk=0;
      rst_n=0;
      crc32_valid_in=1;
      #10	
      rst_n=1;	
   	  crc32_in=8'h0a;
      #10
      crc32_in=8'h0c;
      #10
      $display("crc32_in %h and crc32_out %h",crc32_in,crc32_out);
      
      #200
      $finish();
    end
  
  
  always 
    #5  clk =  ! clk; 
  
    initial begin

    $dumpfile("test.vcd");
    $dumpvars;
  end
  
endmodule
