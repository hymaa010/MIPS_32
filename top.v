module top(input clk,output [7:0]out);
    wire Z,N,regdst,branch,memread,memtoreg,
    memwrite,alusrc,regwrite,jump;
    wire [1:0] aluop;
	 wire [2:0]alucontrol;
    wire [31:0] inst,read1,read2,readdata,aluout,signext,in2,regdata;
    wire [4:0] rs,rt,rd,wreg;
    wire [5:0] op,funct;
    wire [15:0]imm;
    reg [31:0] pc;
    wire [31:0] pc_plus4 = pc + 4;
    wire [31:0] branch_offset = signext << 2;
	 assign out=aluout[7:0];
    initial begin
    pc = 32'd0;
    end
    assign rs=inst[25:21];
    assign rt=inst[20:16];
    assign rd=inst[15:11];
    assign op=inst[31:26];
    assign funct=inst[5:0];
    assign imm=inst[15:0];

    instmem im(.address(pc),.data(inst));
    MUX2 #(5) mux1 (.A(rt),.B(rd),.s(regdst),.f(wreg));
    regfile rf(.r_add1(rs),.r_add2(rt),.wr_add(wreg),
    .wr_en(regwrite),.clk(clk),.datain(regdata),.read1(read1),.read2(read2));
    control c(.op(op),.regdst(regdst),.branch(branch),.memread(memread),.memtoreg(memtoreg),
    .memwrite(memwrite),.alusrc(alusrc),.regwrite(regwrite),.aluop(aluop),.jump(jump));
    ALUControl ac(.ALUOp(aluop),.funct(funct),.alucontrol(alucontrol));
    signext se(.A(imm),.f(signext));
    MUX2 #(32) mux2 (.A(read2),.B(signext),.s(alusrc),.f(in2));
    ALU alu(.A(read1),.B(in2),.alucontrol(alucontrol),.out(aluout),.Z(Z),.N(N));
    datamem dm(.address(aluout),.writedata(read2),.wr_en(memwrite),.r_en(memread),
	.clk(clk),.readdata(readdata));
    MUX2 #(32) mux3 (.A(aluout),.B(readdata),.s(memtoreg),.f(regdata));

    always @(posedge clk) begin
        if ((branch && Z) || jump) pc <= pc_plus4 + branch_offset;
        else pc <= pc_plus4;
    end

endmodule