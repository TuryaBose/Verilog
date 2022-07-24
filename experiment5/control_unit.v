module control_unit(clk, clk_en, nReset, DCF_Enable_in, SET_in, STATE_out, DCF_timeAndDate_in,
                     DCF_set_in, SetClock_timeAndDate_in, SetClock_state_in, clock_timeAndDate_In,
                     LCD_timeAndDate_Out, clock_timeAndDate_Out, clock_set_out);

   input          clk;
   input          clk_en;
   input          nReset;
   input          DCF_Enable_in;
   input          SET_in;
   output  [5:0]  STATE_out;
   // -------DATA FROM DCF DECODER
   input  [43:0]  DCF_timeAndDate_in;
   input          DCF_set_in;
   // -------DATA FROM SET CLOCK
   input  [43:0]  SetClock_timeAndDate_in;
   input   [3:0]  SetClock_state_in;
   // -------DATA FROM CLOCK
   input  [43:0]  clock_timeAndDate_In;
   // -------DATA OUTPUT LCD-Matrix-Display
   output [43:0]  LCD_timeAndDate_Out;
   // -------DATA TO CLOCK
   output [43:0]  clock_timeAndDate_Out;
   output         clock_set_out;

   reg        clock_set_out_reg;
   reg [5:0]  STATE_out_reg;
   reg [43:0] LCD_timeAndDate_Out_reg;
   reg [43:0] clock_timeAndDate_Out_reg;
   
   assign clock_set_out = clock_set_out_reg;
   assign STATE_out = STATE_out_reg;
   assign LCD_timeAndDate_Out = LCD_timeAndDate_Out_reg;
   assign clock_timeAndDate_Out = clock_timeAndDate_Out_reg;
      
   // ---------- YOUR CODE HERE ---------- 

	localparam state_select_clock = 2'b00;
	localparam state_select_dcf77 = 2'b01;
	localparam state_set_clock = 2'b10;
	reg [1:0] current_state = 2'b00;
	always@(negedge nReset, posedge clk_en) begin
	if(!nReset) begin
		current_state <= 2'b00;
		end
	else begin
	case(current_state)
		state_select_clock: begin
			if (DCF_Enable_in == 1) begin
				current_state <= 2'b01;
			end
			else if (SET_in == 0 & DCF_Enable_in == 0) begin
				current_state <= 2'b10;
			end
		end
		state_select_dcf77: begin
			if (DCF_Enable_in == 0) begin
				current_state <= 2'b00;
			end
		end
		state_set_clock: begin
			if (DCF_Enable_in == 1) begin
				current_state <= 2'b01;
			end
			else if (SetClock_state_in == 4'hE) begin
				current_state <= 2'b00;
			end
		end
	endcase
	end
	end
	
	always@(*)
	begin
		case(current_state)
			state_select_clock: begin
				STATE_out_reg = 6'b0;
				LCD_timeAndDate_Out_reg = clock_timeAndDate_In;
				clock_timeAndDate_Out_reg = SetClock_timeAndDate_in;
				clock_set_out_reg = 0;
			end
			state_select_dcf77: begin
				STATE_out_reg = 6'b110000;
				LCD_timeAndDate_Out_reg = clock_timeAndDate_In;
				clock_timeAndDate_Out_reg = DCF_timeAndDate_in;
				clock_set_out_reg = DCF_set_in;
			end
			state_set_clock: begin
				LCD_timeAndDate_Out_reg = SetClock_timeAndDate_in;
				clock_timeAndDate_Out_reg = SetClock_timeAndDate_in;
				if ( SetClock_state_in == 4'hE | SetClock_state_in == 4'hD) begin
					clock_set_out_reg = 1;
				end
				else begin
					clock_set_out_reg = 0;
				end
				STATE_out_reg[5:4] = 2'b10;
				STATE_out_reg[3:0] = SetClock_state_in;
			end
		default:
			begin
				STATE_out_reg = 6'b0;
				LCD_timeAndDate_Out_reg = clock_timeAndDate_In;
				clock_timeAndDate_Out_reg = SetClock_timeAndDate_in;
				clock_set_out_reg = 0;
			end
		endcase
	end	  
endmodule