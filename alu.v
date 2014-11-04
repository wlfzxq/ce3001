`include "define.v"// defines


module alu(
   a,   //1st operand
   b,   //2nd operand
   op,   //4-bit operation
   out,   //output
   flag
   );


   
   input [`DSIZE-1:0] a, b;
   input [3:0] op;
   //input [`DSIZE-1:0] imm;
   output [`DSIZE-1:0] out;
   output flag;   

	reg [`DSIZE-1:0] out; 
      	reg flag;
always @(a or b or op)
begin
   case(op)
       `ADD: begin flag <= 0;
		   out <= a+b;
	     end
       `SUB: begin flag <= 0;
		   out <= a - b;
	     end
       `AND: begin flag <= 0;
		   out <= a & b;
	     end
       `XOR: begin flag <= 0;
		   out <= a^b;
	     end
       `SLL: begin flag <= 0;
		   out <= (a << b);
	     end
       `SRL: begin flag <= 0;
		   out <= (a >> b);
	     end
       `COM: begin flag <= 0; 
		   out <= (a<=b);
	     end
       `MUL: begin flag <= 0;
		  out <= a*b;
	     end
       `SW: begin flag <= 0;
		  out <= a+b;
            end
       `LW: begin flag <= 0;
		  out <= a+b;
	    end
       `BEQ:begin 
		  flag <= (a==b);
		  out <= 0;
	    end

   endcase
end

endmodule
   
       
