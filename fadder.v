module fadder(input a,b,cin, output s,c);
assign s = a ^ b ^ cin;
assign c = (a & b) | (cin & (a ^ b));
endmodule