module rtl_16bits_adder (
    input logic [15:0] X,Y,
    input logic cin,
    output logic [15:0] S,
    output logic C
);
   timeunit 1ns/1ns;
   wire [3:0]cc;
   rtl_4bit_adder adder4_1(.a(X[3:0]),.b (Y[3:0]),.cin(cin),.sum(S[3:0]),.Cout(cc[0]));
   rtl_4bit_adder adder4_2(.a(X[7:4]),.b (Y[7:4]),.cin(cc[0]),.sum(S[7:4]),.Cout(cc[1]));
   rtl_4bit_adder adder4_3(.a(X[11:8]),.b (Y[11:8]),.cin(cc[1]),.sum(S[11:8]),.Cout(cc[2]));
   rtl_4bit_adder adder4_4(.a(X[15:12]),.b (Y[15:12]),.cin(cc[2]),.sum(S[15:12]),.Cout(cc[3]));
   assign C=cc[3];
endmodule 

module rtl_4bit_adder(
    input logic [3:0] a,b,
    input logic cin,
    output logic [3:0] sum,
    output logic Cout
);
    timeunit 1ns/1ns;
    assign {Cout,sum}=a+b+cin;
endmodule
