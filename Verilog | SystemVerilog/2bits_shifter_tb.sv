module test (
    output logic [1:0] in,
    output logic s,
    input logic [1:0]out,
    input logic clk
);

    timeunit 1ns/1ns;

    initial begin: setup_dump
            $fsdbDumpfile("dump.fsdb");
            $fsdbDumpvars;
    end

    initial begin
        repeat (8) begin
            @(negedge clk);
            void'(std::randomize(in));
            void'(std::randomize(s));
        end
        @(negedge clk) $finish;
    end
endmodule

module top;
    timeunit 1ns/1ns;
    logic [1:0]out,in;
    logic clk,s;

    test test_inst(.*);
    shifter dut(.*);

    initial begin
        clk <= 0;
        forever #5 clk = ~clk;
    end

endmodule:top
