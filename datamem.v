module datamem(input [31:0]address,input [31:0] writedata,
   input wr_en,r_en,clk, output reg [31:0]readdata);
   reg [31:0]mem[127:0];
   always @(posedge clk) begin
      if(wr_en) begin
          mem[address] <= writedata;
      end
   end
	always@(*) begin
		if(r_en)
			readdata <= mem[address];
	end
endmodule