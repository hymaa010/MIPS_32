module instmem(input [31:0] address, output [31:0] data);
    reg [31:0] mem[255:0];  
    assign data = mem[address[31:2]];  
endmodule