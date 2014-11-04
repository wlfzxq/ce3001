`include "define.v"


module mux(
       clk,
		a,
		b,       
		 sel,		 
		 out);
		 
		 
		 
		 input sel;
		 input [`DSIZE - 1:0]a,b;		 
		 
		 output reg [`DSIZE - 1:0]out;
		 
		 
		 
always @（*）//star symbol,shift+8
begin
//if(sel == 0) out <= a;
//else out <= b;
case(sel)
	0: out <= a;
	1: out <= b;
	default:out <= a;
endcase

end
endmodule	

