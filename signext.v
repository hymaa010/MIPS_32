module signext ( input [15:0]A,output [31:0]f);
    assign f={{16{A[15]}},A};    
endmodule
