module test (
    output logic [2:0] addr,  
    output logic en_b,        
    input logic [7:0] row_sel,
    input logic clk
);

    timeunit 1ns/1ns;

    initial begin: setup_dump
            $fsdbDumpfile("dump.fsdb");
            $fsdbDumpvars;
    end

    initial begin
        en_b=1;
        repeat (2) begin
            @(negedge clk);
            void'(std::randomize(addr));
        end
        en_b=0;
        repeat (8) begin
            @(negedge clk);
            void'(std::randomize(addr));
        end
        @(negedge clk) $finish;
    end
endmodule

module top;
    timeunit 1ns/1ns;
    logic [2:0] addr;
    logic en_b;      
    logic [7:0] row_sel;
    logic clk;

    test test_inst(.*);
    decoder dut(.*);

    initial begin
        clk <= 0;
        forever #5 clk = ~clk;
    end

endmodule:top
