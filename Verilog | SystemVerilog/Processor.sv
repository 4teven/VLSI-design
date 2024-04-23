module processor (
    input logic [31:0] data_in, i_data,
    input logic [15:0] status_flags,
    input logic clk, data_select,rstN,
    output logic [31:0] data_out,
    output logic [7:0] status,
    output logic [2:0] Q
);
    timeunit 1ns/1ns;

    Mux2to1 mux32(.a(data_in),.b(i_data),.sel(data_select),.y(data_out));

    status_reg sreg(.clk(clk),.rstN(rstN),.int_en(status_flags[7]),.zero(status_flags[4]),.carry(status_flags[3]),.neg(status_flags[2]),.parity(status_flags[1:0]),.status(status[7:0]));
    //status_flags[7:0] assigned to status register as required
    PriorityEncoder_8to3 Prio83(.D(status_flags[15:8]),.Q(Q[2:0]));
    //the other higher bits of the status register assigned to priority
    //encoder

endmodule:processor

module PriorityEncoder_8to3 (
    input logic [7:0] D,
    output logic [2:0] Q
);
timeunit 1ns/1ns;
always_comb begin
    casex(D)
        8'b00000001: Q = 3'b000;  //priority bit locates at 0 position
        8'b0000001: Q = 3'b001;
        8'b000001xx: Q = 3'b010;
        8'b00001xxx: Q = 3'b011;
        8'b0001xxxx: Q = 3'b100;
        8'b001xxxxx: Q = 3'b101;
        8'b01xxxxxx: Q = 3'b110;
        8'b1xxxxxxx: Q = 3'b111; // locates at the 7th position which the left most
        default: Q = 3'b000; // Default case, when no input is high
    endcase
end
endmodule:PriorityEncoder_8to3


module  Mux2to1(
    input logic [31:0]a,b,
    input logic sel,
    output logic [31:0] y
);
    timeunit 1ns/1ns;
    always_comb begin   
        if (sel) y = a;
        else y = b;
    end
endmodule:Mux2to1



module status_reg (
    input logic clk,rstN, int_en, zero,carry,neg,
    input logic [1:0]parity,
    output logic [7:0]status
);
    timeunit 1ns/1ns;
    always_ff @(posedge clk or negedge rstN) begin:main_logic
        if(!rstN)  //according to the description, once reset is activated which is 0, all set to 0
            status <= {1'b0, 2'b11, 5'b0};
        else
            status <= {int_en, 2'b11, zero, carry, neg, parity};
    end:main_logic
endmodule: status_reg


