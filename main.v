`timescale 1ns / 1ps
`include "define.v"

module main(clk, rst, fileid, PCOUT, INST, aluop, rdata1, rdata2, rdata1_ID_EXE,rdata2_ID_EXE, rdata2_EXE_DM,aluop_ID_EXE,regmuxout_ID_EXE, aluout,dmem_out,regmux);

input clk;				
											
input	rst;
input fileid; 
 
output [`ISIZE-1:0] PCOUT;
output [`DSIZE-1:0] rdata1;
output [`DSIZE-1:0] rdata1_ID_EXE;//output from ID_EXE stage
output [`DSIZE-1:0] rdata2;
output [`DSIZE-1:0] rdata2_ID_EXE,rdata2_EXE_DM;//output from ID_EXE stage
output [`DSIZE-1:0]INST;
output [2:0] aluop;
output [2:0] aluop_ID_EXE;//output from ID_EXE stage
output [`DSIZE-1:0] aluout;//output from DM_WB stage	
output [`DSIZE-1:0] dmem_out;//output from DM_WB Stage
output [`DSIZE-1:0] regmux;
output [`DSIZE-1:0] regmuxout_ID_EXE;
//output PCsrc,branch_1,branch_2;				
								
 	 
//Program counter
reg [`ISIZE-1:0]PC_plus1;

wire [`ISIZE-1:0] pc_branch;//                 = 16'b0;


PC1 pc(.clk(clk),.rst(rst),.nextPC(pc_branch),.currPC(PCOUT));

always @(PCOUT) //list is at (PCOUT)
//~~~~~~~~
begin

PC_plus1 = PCOUT+16'b1;
end

//instruction memory
memory im( .clk(clk), .rst(rst), .wen(1'b0), .addr(PCOUT), .data_in(16'b0), .fileid(4'b0000),.data_out(INST));

//here we are not taking the multiplexers for initialization as initialization is done within reg file itself.
wire wen_1,wen_2,wen_3,wen_4, alusrc,branch_1,memread_1,memread_2,memread_3,memwrite_1,memwrite_2,memwrite_3,memtoreg_1,memtoreg_2,memtoreg_3,memtoreg_4,RegDst;
wire branch_1, branch_2,PCsrc;
wire [`DSIZE-1:0] imm_ID_EXE;
wire [`DSIZE-1:0] imm_extended;
wire [`DSIZE-1:0] aluoutput;
wire [`ASIZE-1:0] waddr_out_ID_EXE,waddr_out_EXE_DM,waddr_out_DM_WB;
wire [`ISIZE-1:0] pc_pipe_out;
//wire [`DSIZE-1:0] regmux_out;
wire [`DSIZE-1:0] wbmux_out;
wire [3:0] rtmux_out;



control C0 (.inst(INST[15:12]),.wen(wen_1),.regdst(RegDst), .aluop(aluop),.alusrc(alusrc),.branch(branch_1),.memtoreg(memtoreg_1),.dmem_read(memread_1),.dmem_write(memwrite_1));



mux rt_muxer(.a(INST[3:0]),.b(INST[11:8]),.sel(RegDst),.out(rtmux_out));//mux before registerfile


sign_extend SE1(.imm_in(INST[3:0]),.imm_out(imm_extended));




mux regmuxer(.a(rdata2),.b(imm_extended),.sel(alusrc),.out(regmux));

ID_EXE_stage PIPE1(.clk(clk), .rdata1_in(rdata1),.rdata2_in(rdata2),.mux_in(regmux),.imm_in(imm_extended),.opcode_in(aluop), .waddr_in(INST[11:8]), .pc_in(PC_plus1),.branch_in(branch_1),.memwrite_in(memwrite_1),.memread_in(memread_1),.memtoreg_in(memtoreg_1),.wen_in(wen_1), .waddr_out(waddr_out_ID_EXE), .rdata1_out(rdata1_ID_EXE), .rdata2_out(rdata2_ID_EXE),.mux_out(regmuxout_ID_EXE), .imm_out(imm_ID_EXE), .opcode_out(aluop_ID_EXE),.pc_out(pc_pipe_out),.branch_out(branch_2),.memwrite_out(memwrite_2),.memread_out(memread_2), .memtoreg_out(memtoreg_2),.wen_out(wen_2));



reg [`ISIZE-1:0] branch_result;

always @(pc_pipe_out or imm_ID_EXE) //list is at (pc_pipe_out or imm_ID_EXE)
begin

branch_result <= pc_pipe_out + imm_ID_EXE;
end
//~~~~!


wire flag;
alu ALU0 ( .a(rdata1_ID_EXE), .b(regmuxout_ID_EXE), .op(aluop_ID_EXE), .out(aluoutput), .flag(flag));

//wire PCsrc;


//branch_and BA(.branch(branch_2),.flag(flag),.PCSrc(PCsrc));
//~~~~!
always @(flag or branch_2) //at (flag or branch_2)
begin
PCsrc <= flag&&branch_2;
end

mux pc_mux(.a(PC_plus1),.b(branch_result),.sel(PCsrc), .out(pc_branch));


wire [`DSIZE-1:0] maddr;
wire [`DSIZE-1:0] m_out;
EXE_DM_stage PIPE2(.clk(clk), .maddr_in(aluoutput), .waddr_in(waddr_out_ID_EXE),.rdata2_in(rdata2_ID_EXE), .maddr_out(maddr), .waddr_out(waddr_out_EXE_DM),.rdata2_out(rdata2_EXE_DM),.memwrite_in(memwrite_2),.memread_in(memread_2),.memtoreg_in(memtoreg_2),.wen_in(wen_2),.memwrite_out(memwrite_3),.memread_out(memread_3),.memtoreg_out(memtoreg_3),.wen_out(wen_3));



dmemory dm(.clk(clk),.rst(rst),.wen(1'b1),.MemWrite(memwrite_3),.MemRead(memread_3),.addr(maddr),.data_in(rdata2_EXE_DM),.fileid(4'b1000),.data_out(m_out));


//~~~data memory how??

wire [`DSIZE-1:0] mout_2;

wire [`DSIZE-1:0] aluresult_2;


DM_WB_stage
PIPE3(.clk(clk),.rdata_in(m_out),.aluresult_in(maddr),.waddr_in(waddr_out_EXE_DM),.memtoreg_in(memtoreg_3),.wen_in(wen_3),.rdata_out(mout_2),.waddr_out(waddr_out_DM_WB),.aluresult_out(aluresult_2),.memtoreg_out(memtoreg_4),.wen_out(wen_4));




mux wb_mux(.a(mout_2),.b(aluresult_2),.out(wbmux_out),.sel(memtoreg_4));

regfile  RF0 ( .clk(clk), .rst(rst), .wen(wen_4), .raddr1(INST[7:4]), .raddr2(rtmux_out), .waddr(waddr_out_DM_WB), .wdata(wbmux_out), .rdata1(rdata1), .rdata2(rdata2));
//~~~~~


endmodule


