module filter_3x3_240px
#(
    parameter BLOCK_LENGTH = 240,
    parameter FILTER_SIZE = 3,

    // weight of each pixel, change these parameters to make difference effect of filter
    // |WA3|WB3|WA3|
    // |WB3|WA1|WB3|
    // |WA3|WB3|WA3|
    parameter WA3 = 0,
    parameter WB3 = 1,
    parameter WA1 = -4,
    parameter DIV = 1

)
(
    // system
    input	reset,
    input	clk,

    // io
    input [15:0] d_in,
    output wire [15:0] d_out,

    // control
    input wren,
    output wire d_rdy,
    input [9:0] cursor
);
	
//To Do: filter the input image
//	- increase efficiency by eliminating redundancy
//	- read each clock cycle a new line of pixels (except for the first three rows, since you need three rows to start filtering (because of the 3x3 filter))
//	- keep the two already loaded lines for reuse
//	- if necessary use an additional pointer to keep track of your first input pixel of the image
//	- be aware that there could be timing issues:
//	-synchronize your internal pointer with the custom master pointer
//	- validate your design via SignalTap
		
   

endmodule

