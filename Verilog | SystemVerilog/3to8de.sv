module decoder (
    input logic [2:0] addr,  
    input logic en_b,        
    output logic [7:0] row_sel 
);
    timeunit 1ns/1ns;
    always_comb begin
        if (!en_b) begin // Check if enable is active (low)
            row_sel = 8'b0000_0001 << addr; 
        end else begin
            row_sel = 8'b0000_0000;
        end
    end

endmodule
