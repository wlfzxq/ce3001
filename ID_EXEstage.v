`include "define.v"

module ID_EXE_stage (
	
	input  clk,  
	input [`DSIZE-1:0] rdata1_in,
	input [`DSIZE-1:0] rdata2_in,
	input [`DSIZE-1:0] mux_in,
	input [`DSIZE-1:0] imm_in,
	input [2:0] opcode_in,
	input [`ASIZE-1:0]waddr_in,
	input [`ISIZE-1:0]pc_in,
	input branch_in, memwrite_in, memread_in,memtoreg_in,wen_in,
	

	output reg [`DSIZE-1:0] rdata1_out,
	output reg [`DSIZE-1:0] rdata2_out,
	output reg [`DSIZE-1:0] mux_out,
	output reg [`DSIZE-1:0] imm_out,
	output reg [2:0] opcode_out,
	output reg[`ASIZE-1:0]waddr_out,
	output reg [`ISIZE-1:0]pc_out,
	output reg branch_out, memwrite_out, memread_out, memtoreg_out,wen_out
	
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	
		 begin
		waddr_out <= waddr_in;
		rdata1_out <= rdata1_in;
		rdata2_out <= rdata2_in;
		imm_out<=imm_in;
		opcode_out<=opcode_in;
		pc_out <=pc_in;
		branch_out <= branch_in;
		memwrite_out <= memwrite_in;
		memread_out <= memread_in;
		memtoreg_out <= memtoreg_in;
		wen_out <= wen_in;
	end
 
end
endmodule


