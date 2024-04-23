package definitions_pkg;

  typedef struct {

    logic [3:0] data;

    logic       parity_bit;

  } data_t;

endpackage: definitions_pkg



module parity_checker

 import definitions_pkg::*;

(input  data_t data_in,  // 5-bit structure input

 input  clk,             // clk input

 input  rstN,            // active-low asynchronous reset

 output logic  error     // set if parity error detected

);

  timeunit 1ns; timeprecision 1ns;



  always_ff @(posedge clk or negedge rstN) // async reset

    if (!rstN) error <= 0;                 // active-low reset

    else       error <= ^{data_in.parity_bit, data_in.data};

      // reduction-XOR returns 1 if an odd number of bits are

      // set in the combined data and parity_bit

endmodule: parity_checker
                                                                  
