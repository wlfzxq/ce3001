`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:28 09/23/2014 
// Design Name: 
// Module Name:    sign_extend 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "define.v"
module sign_extend(imm_in, clk, imm_out);
    input [3:0] imm_in;
    input clk;
    output reg[15:0] imm_out;

always@(*) //at (star symbol, "shift+8")
begin
imm_out <= {imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3],imm_in[3:0]};
end

endmodule
