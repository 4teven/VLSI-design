module test(
    output logic [15:0] X,Y,
    output logic cin,
    input logic [15:0] S,
    input logic C,clk
);
    timeunit 1ns/1ns;
    
    initial begin: fsdb_dump
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars;
    end: fsdb_dump  
   
    initial begin: gen_stimuli
    repeat(3) begin
    @(negedge clk);
    void'(std::randomize(X));
    void'(std::randomize(Y));
    void'(std::randomize(cin));
    end
    @(negedge clk) $finish;
end: gen_stimuli

initial begin:monitor
$monitor("At %t: \t X=%d Y=%d cin=%b S=%d C=%b",$realtime, X, Y, cin, S, C);
end: monitor

endmodule:test
    

module top;
timeunit 1ns/1ns;
logic [15:0] X,Y,S;
logic cin,C,clk;
test test (.*);
rtl_16bits_adder dut (.*);
initial begin
clk <= 0;
forever #5 clk = ~clk;
end
endmodule: top
