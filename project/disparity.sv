// Code your testbench here
// or browse Examples
// Get the inputs

class disparity;
logic [4:0] a;
logic [5:0] atemp;
logic [2:0] b;
logic[7:0] datain;
  int rd=-1;
  function int update_rd(input logic[5:0] atemp);
	int c1,c0,rd_new, diff;
    $display("I am inside the function atemp=%0b",atemp);
    c1=$countones(atemp);
    c0=$countbits(atemp,'0);
	$display("no of 1=%0d",c1);
	$display("no of 0=%0d",c0);
    diff =c1-c0;
    if (diff + rd > 2 || diff +rd <-2) begin
      rd_new = rd+(-diff);
    end
    else 
      rd_new=rd+diff;
	return rd_new;		
endfunction: update_rd
task sheethal();
  //if(datain) begin
	a=datain;
    $display("datain=%0b a=%0b b=%0b",datain,a,b);
	b=datain>>5;
	if(rd==-1) begin
	$display("I am inside if loop rd=%0d",rd);
		case(a)
		0: begin
			atemp = 6'b111001;			
		end
		1: begin
			atemp = 6'b101110;			
		end
		2: begin
			atemp = 6'b101101;			
		end
		3: begin
			atemp = 6'b100011;			
		end
		4: begin
			atemp = 6'b101011;			
		end
		5: begin
			atemp = 6'b100101;			
		end
		6: begin
			atemp = 6'b100110;			
		end
		7: begin
			atemp = 6'b000111;			
		end
		8: begin
			atemp = 6'b100111;			
		end
		9: begin
			atemp = 6'b101001;			
		end
		10: begin
			atemp = 6'b101010;			
		end
		11: begin
			atemp = 6'b001011;			
		end
		12: begin
			atemp = 6'b101100;			
		end
		13: begin
			atemp = 6'b001101;			
		end
		14: begin
			atemp = 6'b001110;			
		end
		15: begin
			atemp = 6'b111010;			
		end
		16: begin
			atemp = 6'b110100;			
		end
		17: begin
			atemp = 6'b110001;			
		end
		18: begin
			atemp = 6'b110010;			
		end
		19: begin
			atemp = 6'b010011;			
		end
		20: begin
			atemp = 6'b110100;			
		end
		21: begin
			atemp = 6'b010101;			
		end
		22: begin
			atemp = 6'b010110;			
		end
		23: begin
			atemp = 6'b010111;			
		end
		24: begin
			atemp = 6'b110011;			
		end
		25: begin
			atemp = 6'b011001;			
		end
		26: begin
			atemp = 6'b011010;			
		end
		27: begin
			atemp = 6'b011011;			
		end
		28: begin
			atemp = 6'b011100;			
		end
		29: begin
			atemp = 6'b011101;			
		end
		30: begin
			atemp = 6'b011110;			
		end
		31: begin
			atemp = 6'b110101;			
		end
		endcase
	end
    $display("atemp=%0b",atemp);
rd=update_rd(atemp);	
$display("RD=%0d",rd);
//end
endtask
endclass
program tb;
initial begin
disparity d,d1;
d=new();
d1=new();
d.datain=8'b00111100;
d.sheethal();
d1.datain=8'b00000000;
d1.sheethal();
end
endprogram
