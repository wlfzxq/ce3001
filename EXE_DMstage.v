`include "define.v"

module EXE_DM_stage (
	
	input  clk,  
	input [`DSIZE-1:0] maddr_in,
	input [`ASIZE-1:0] waddr_in,//regfile writeback addr
	input [`DSIZE-1:0] rdata2_in,
	input memwrite_in, memread_in, memtoreg_in,wen_in,

	output reg [`DSIZE-1:0] maddr_out,
	output reg[`ASIZE-1:0]waddr_out,
	output reg [`DSIZE-1:0] rdata2_out,
	output reg memwrite_out, memread_out, memtoreg_out,wen_out
	
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	
		 begin
		maddr_out <= maddr_in;
		waddr_out <= waddr_in;
		rdata2_out <= rdata2_in;
		memwrite_out <= memwrite_in;
		memread_out <= memread_in;
		memtoreg_out <= memtoreg_in;
		wen_out <= wen_in;

	end
 
end
endmodule


