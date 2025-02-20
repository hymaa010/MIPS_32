module MUX2 #(parameter width=32 )(input [width-1:0]A,B,input s,output [width-1:0]f);
    assign f=(s)?B:A;
endmodule
