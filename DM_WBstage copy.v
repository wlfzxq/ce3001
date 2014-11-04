`include "define.v"

module DM_WB_stage (
	
	input  clk,  
	input [`DSIZE-1:0] rdata_in,
	input [`DSIZE-1:0] aluresult_in,
	input [`ASIZE-1:0] waddr_in,//regfile writeback addr
	input memtoreg_in,wen_in,

	output reg [`DSIZE-1:0] rdata_out,
	output reg [`DSIZE-1:0] aluresult_out,
	output reg[`ASIZE-1:0]waddr_out,
	output reg memtoreg_out,wen_out
	
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	
		 begin
		waddr_out <= waddr_in;
		rdata_out <= rdata_in;
		aluresult_out <= aluresult_in;
		memtoreg_out <= memtoreg_in;
		wen_out <= wen_in;

	end
 
end
endmodule


