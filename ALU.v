module ALU( input [31:0] A,B,input [2:0] alucontrol,
    output reg [31:0] out,output reg Z,N);
	wire [31:0]add,sub;
	wire [32:1] w2,w3;
	
genvar i,j;

fadder fa (A[0],B[0],1'b0,add[0],w2[1]);
generate
	for (j = 1; j < 32; j = j + 1) begin : add_loop
		fadder fa (A[j],B[j],w2[j],add[j],w2[j+1]);
	end
endgenerate

fadder fs (A[0],~B[0],1'b1,sub[0],w3[1]);
generate
	for (i = 1; i < 32; i = i + 1) begin : sub_loop
		fadder fa (A[i],~B[i],w3[i],sub[i],w3[i+1]);
	end
endgenerate

always @(*) begin
	 case (alucontrol)
		  3'b000: out = A&B;
		  3'b001: out = A|B;
		  3'b010: out = add;
		  3'b110: out = sub;
		  3'b111: out = (A < B) ? 32'b1 : 32'b0;
		  default: out = 32'bx;
	 endcase
	 Z = (out == {32{1'b0}});
	 N = (out[31] == 1);
end
endmodule
