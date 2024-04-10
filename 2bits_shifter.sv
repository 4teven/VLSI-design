module shifter (
    input logic [1:0] in,
    input logic s,
    output logic [1:0]out
);
    timeunit 1ns/1ns;
    assign out[0]=~s & in[0],
    out[1]=(~s&in[1])|(s&in[0]);
endmodule
