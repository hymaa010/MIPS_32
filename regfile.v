module regfile(input[4:0]r_add1,r_add2,wr_add,
	input wr_en,clk,input[31:0] datain,
	output [31:0]read1,read2);
	reg [31:0]regfile[31:0];

	integer i;

	initial begin
		regfile[0] = 32'h0;    
		for (i = 1; i < 32; i = i + 1) 
			regfile[i] = 32'h0; 
	end

	always @(posedge clk)
	begin
		if(wr_en && (wr_add!=0))
			regfile[wr_add] <= datain;
	end

	assign	read1 = regfile[r_add1];
	assign	read2 = regfile[r_add2];
endmodule
