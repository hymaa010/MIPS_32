module control (input [5:0]op,
	output regdst,branch,memread,memtoreg,memwrite,alusrc,regwrite,jump,
	output [1:0]aluop);
	wire lw,sw,r,beq,addi;
	assign lw=(op==6'b100011);
	assign sw=(op==6'b101011);
	assign r=(op==6'b000000);
	assign beq=(op==6'b000100);
	assign addi=(op==6'b001000);
	assign jump=(op==6'b000010);

	assign regdst=r;
	assign branch=beq;
	assign memread=lw;
	assign memtoreg=lw;
	assign memwrite=sw;
	assign alusrc=lw||sw||addi;
	assign regwrite=r||lw||addi;
	assign aluop[1]=r||addi;
	assign aluop[0]=beq||addi;
endmodule