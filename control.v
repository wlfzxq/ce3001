//control unit for write enable and ALU control

`include "define.v"
module control(
  input [3:0] inst, 
  output reg wen,
  output reg alusrc,
  output reg branch,
  output reg memtoreg,
  output reg dmem_read,
  output reg dmem_write,
  output reg [3:0] aluop,
  output reg regdst
  );
  
  always@(*)
  begin
 
    case(inst)
	`ADD: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
	end
        `SUB: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
        end
        `AND: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
        end
        `XOR: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
        end
        `SLL: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=1;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
        end
      `SRL: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=1;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
        end
        `COM: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;        
		regdst<=0;
	end
        `MUL: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=1;
		branch<=0;
		regdst<=0;
        end
	`LW: begin
		wen<=1;
		aluop<=inst[3:0];
		alusrc<=1;
		dmem_read<=1;
		dmem_write<=0;
		memtoreg<=0;
		branch<=0;
		regdst<=0;
	end
	`SW: begin 
		wen<=0;
		aluop<=inst[3:0];
		alusrc<=1;
		dmem_read<=0;
		dmem_write<=1;
		memtoreg<=1;
		branch<=0;
		regdst<=1;
	end
	`BEQ: begin 
		wen<=0;
		aluop<=inst[3:0];
		alusrc<=0;
		dmem_read<=0;
		dmem_write<=0;
		memtoreg<=0;
		branch<=1;
		regdst<=1;
	end
    endcase
  end
  
endmodule
