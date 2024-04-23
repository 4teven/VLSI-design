module test(
    output logic [31:0] data_in, i_data,
    output logic [15:0] status_flags,
    output logic data_select,rstN,
    input logic [31:0] data_out,
    input logic [7:0] status,
    input logic [2:0] Q,
    input logic clk
);
    timeunit 1ns/1ns;
    
    initial begin: fsdb_dump
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars;
    end: fsdb_dump  
   
   initial begin:gen_stimuli
	rstN=1;  //operating, and giving three random values and testing
	repeat(3)begin
		@(negedge clk);
		void'(std::randomize(data_in));
		void'(std::randomize(i_data));
		void'(std::randomize(data_select));
		void'(std::randomize(status_flags));
		@(negedge clk)check_results;
	end
	rstN=0; //test for reset
	@(negedge clk) check_results;
	rstN=1;
	@(negedge clk) 
	$finish;
end:gen_stimuli

task check_results;
	$write("At time=%t: data_in=%d i_data=%d data_select=%b data_out=%d status_flags=%b rstN=%b status=%b Q=%b"
        ,$realtime, data_in, i_data, data_select, data_out,status_flags,rstN, status, Q);
	case(rstN)
		1'b0: begin
			if (status == 8'b01100000)
				$display("\nYou are actually reset the processor");
			else
				$display("False");
		end 
		1'b1: begin
			if(status == {status_flags[7], 2'b11, status_flags[4],status_flags[3], status_flags[2], status_flags[1:0]})  
				$display("\nThe processor is operating very well");
			else
				$display("Nooooooooo!");
		end
	endcase
endtask

endmodule:test
    

module top;
timeunit 1ns/1ns;
logic [31:0] data_in, i_data,data_out;
logic clk, data_select,rstN;
logic [15:0] status_flags;
logic [7:0] status;
logic [2:0] Q;
test test (.*);
processor dut (.*);
initial begin
clk <= 0;
forever #5 clk = ~clk;
end
endmodule: top
