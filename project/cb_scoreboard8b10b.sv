//Scoreboard receives inputs from monin and monoutput
//`uvm_analysis_decl(_a); 
//`uvm_analysis_decl(_c);

//`uvm_blocking_put_imp_decl(_1)
class cb_scoreboard8b10b extends uvm_scoreboard;
`uvm_component_utils(cb_scoreboard8b10b)
uvm_tlm_analysis_fifo #(mimsg) message_in_8b10b;
uvm_analysis_port #(logic[9:0]) message_out;	//output dout to scbd for compare
//uvm_tlm_analysis_fifo #(logic) message_out;
//uvm_blocking_put_imp #(logic,cb_scoreboard0) message_out;

mimsg m;
logic [4:0] a;
logic [5:0] atemp;
logic [2:0] b;
logic [3:0] btemp;
logic[9:0] dout,dout1;
logic[7:0] kdatain;
int rd=-1;
int rd_b=-1;
int rd_k=-1;
logic k;
//int count;
//logic sh_full;
function new (string name="cb_scoreboard8b10b",uvm_component parent=null);
	super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
	message_in_8b10b=new("message_in",this);
	message_out=new("message_out",this);
endfunction:build_phase

function int update_rd(input logic[5:0] atemp);
	int c1,c0,rd_new, diff;
    //$display("I am inside the function atemp=%0b",atemp);
    c1=$countones(atemp);
    c0=$countbits(atemp,'0);
	//$display("no of 1=%0d",c1);
	//$display("no of 0=%0d",c0);
    diff =c1-c0;
    if (diff + rd > 2 || diff +rd <-2) begin
      rd_new = rd+(-diff);
    end
    else 
      rd_new=rd+diff;
	return rd_new;		
endfunction: update_rd

function int update_rd_b(input logic[3:0] btemp);
	int c1,c0,rd_new, diff;
    //$display("I am inside the function btemp=%0b",btemp);
    c1=$countones(btemp);
    c0=$countbits(btemp,'0);
	//$display("no of 1=%0d",c1);
	//$display("no of 0=%0d",c0);
	//$display("before rd_b=%0d",rd_b);
    diff =c1-c0;
    if (diff + rd_b > 2 || diff +rd_b <-2) begin
      rd_new = rd_b+(-diff);
    end
    else 
      rd_new=rd_b+diff;
   //$display("rd_new=%0d",rd_new);
	return rd_new;		
endfunction: update_rd_b

function int update_rd_k(input logic[9:0] dout);
	int c1,c0,rd_new, diff;
    //$display("I am inside the function kdatain=%0b",kdatain);
    c1=$countones(dout);
    c0=$countbits(dout,'0);
	//$display("no of 1=%0d",c1);
	//$display("no of 0=%0d",c0);
    diff =c1-c0;
    if (diff + rd_k > 2 || diff +rd_k <-2) begin
      rd_new = rd_k+(-diff);
    end
    else 
      rd_new=rd_k+diff;
	return rd_new;		
endfunction: update_rd_k


task disparity(mimsg m);
a=m.datain;   
b=m.datain>>5;
k=m.datain>>8;
//$display("datain=%b a=%0b b=%b k=%b",m.datain,a,b,k);
	if(k==1) begin
		kdatain=m.datain;
		if(rd_k==-1) begin
			case(kdatain)
			8'h1c: begin
				dout=10'b0010111100;
			end
			8'h3c: begin
				dout=10'b1001111100;
				//$display("shhhhhhhhhh");
			end
			8'h5c: begin
				dout=10'b1010111100;
			end
			8'h7c: begin
				dout=10'b1100111100;
			end
			8'h9c: begin
				dout=10'b0100111100;
			end
			8'hbc: begin
				dout=10'b0101111100;
			end
			8'hdc: begin
				dout=10'b0110111100;
			end
			8'hfc: begin
				dout=10'b0001111100;
			end
			8'hf7: begin
				dout=10'b0001010111;
			end
			8'hfb: begin
				dout=10'b1110100100;
			end
			8'hfd: begin
				dout=10'b0001011101;
			end
			8'hfe: begin
				dout=10'b0001011110;
			end
			endcase
		//$display("1.Expected output=%0b",dout);
		end
		if(rd_k==1) begin
			case(kdatain)
			8'h1c: begin
				dout=10'b1101000011;
			end
			8'h3c: begin
				dout=10'b0110000011;
			end
			8'h5c: begin
				dout=10'b0101000011;
			end
			8'h7c: begin
				dout=10'b0011000011;
			end
			8'h9c: begin
				dout=10'b1011000011;
			end
			8'hbc: begin
				dout=10'b1010000011;
			end
			8'hdc: begin
				dout=10'b1001000011;
			end
			8'hfc: begin
				dout=10'b1110000011;
			end
			8'hf7: begin
				dout=10'b1110101000;
			end
			8'hfb: begin
				dout=10'b1110100100;
			end
			8'hfd: begin
				dout=10'b1110100010;
			end
			8'hfe: begin
				dout=10'b1110100001;
			end
			endcase
			//$display("2.Expected output=%0b",dout);
		end
		rd_k=update_rd_k(kdatain);
		//$display("Final RD_k for out=%0d",rd_k);
	end
 if(k==0) begin
	if(rd==-1) begin
      //$display("I am inside if loop of 5bits rd=%0d",rd);
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
	if(rd_b==-1) begin
	case(b)
	0: begin
		btemp = 4'b1101;
	end
	1: begin
		btemp = 4'b1001;
	end
	2: begin
		btemp = 4'b1010;
	end
	3: begin
		btemp = 4'b0011;
	end
	4: begin
		btemp = 4'b1011;
	end
	5: begin
		btemp = 4'b0101;
	end
	6: begin
		btemp = 4'b0110;
	end
	7: begin
		if(atemp==6'b110001 || atemp==6'b110010 ||atemp==6'b110100) begin
		btemp = 4'b1110;
		end
		else begin
		btemp = 4'b0111;
		end
	end
	endcase
	dout={btemp,atemp};
	//$display("3.Expected output=%0b",dout);
	end
	if(rd==1) begin
      //$display("I am inside if loop of 5bits rd=%0d",rd);
		case(a)
		0: begin
			atemp = 6'b000110;			
		end
		1: begin
			atemp = 6'b010001;			
		end
		2: begin
			atemp = 6'b010010;			
		end
		3: begin
			atemp = 6'b100011;			
		end
		4: begin
			atemp = 6'b010100;			
		end
		5: begin
			atemp = 6'b100101;			
		end
		6: begin
			atemp = 6'b100110;			
		end
		7: begin
			atemp = 6'b111000;			
		end
		8: begin
			atemp = 6'b011000;			
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
			atemp = 6'b000101;			
		end
		16: begin
			atemp = 6'b001001;			
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
			atemp = 6'b101000;			
		end
		24: begin
			atemp = 6'b001100;			
		end
		25: begin
			atemp = 6'b011001;			
		end
		26: begin
			atemp = 6'b011010;			
		end
		27: begin
			atemp = 6'b100100;			
		end
		28: begin
			atemp = 6'b011100;			
		end
		29: begin
			atemp = 6'b100010;			
		end
		30: begin
			atemp = 6'b100001;			
		end
		31: begin
			atemp = 6'b001010;			
		end
	endcase
	end
	if(rd_b==1) begin
	case(b)
	0: begin
		btemp = 4'b0010;
	end
	1: begin
		btemp = 4'b1001;
	end
	2: begin
		btemp = 4'b1010;
	end
	3: begin
		btemp = 4'b1100;
	end
	4: begin
		btemp = 4'b0100;
	end
	5: begin
		btemp = 4'b0101;
	end
	6: begin
		btemp = 4'b0110;
	end
	7: begin
		if(atemp==6'b001011 || atemp==6'b001101 ||atemp==6'b001110) begin
		btemp = 4'b0001;
		end
		else begin
		btemp = 4'b1000;
		end
	end
	endcase
	dout={btemp,atemp};
	//$display("4.Expected output=%0b",dout);
	end
		rd=update_rd(atemp);	
		//$display("Final RD for atemp=%0d",rd);
		rd_b=update_rd_b(btemp);
		//$display("Final RD for btemp=%0d",rd_b);
		
	
 end	
endtask
task run_phase(uvm_phase phase);
	forever begin
		message_in_8b10b.get(m);
		if((m.pushin)) begin
			$display("Data from Scoreboard8b10b UVM =%h",m.datain);
			disparity(m);	
			//Write dout to scbd_disparity
			message_out.write(dout);	
		end
	end
endtask:run_phase

endclass: cb_scoreboard8b10b
