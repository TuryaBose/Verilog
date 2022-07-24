module tb_statemachines();


reg clock;
reg clk_en;
reg rst;
reg DCF_Enable_in;
reg SET_in;
reg [43:0] DCF_timeAndDate_in;
reg DCF_set_in;
reg [43:0] SetClock_timeAndDate_in;
reg SetClock_state_in;
reg [43:0] clock_timeAndDate_In;
wire [43:0] LCD_timeAndDate_Out;
wire [43:0] clock_timeAndDate_Out;
wire clock_set_out;

always
 #1 clock = ~clock;
 
 initial
 begin
 $display($time, " << Starting the Simulation >>");
 clock = 1'b0;
 rst = 1'b0;
 
 clock_timeAndDate_In[3:0]   <= 4'b0101;   // lower digit of second is 5
 clock_timeAndDate_In[6:4]   <= 3'b100;    // higher digit of second is 4
 clock_timeAndDate_In[10:7]  <= 4'b1001;   // lower digit of minute is 9
 clock_timeAndDate_In[13:11] <= 3'b101;    // higher digit of minute is 5
 clock_timeAndDate_In[17:14] <= 4'b0011;   // lower digit of hour is 3
 clock_timeAndDate_In[19:18] <= 2'b10;     // higher digit of hour is 2
 clock_timeAndDate_In[23:20] <= 4'b0001;   // lower digit of day is 1
 clock_timeAndDate_In[25:24] <= 2'b11;     // higher digit of day is 3
 clock_timeAndDate_In[29:26] <= 4'b0111;   // lower digit of month is 7
 clock_timeAndDate_In[30]    <= 1'b0;      // higher digit of month is 0
 clock_timeAndDate_In[34:31] <= 4'b1001;   // lower digit of year is 9
 clock_timeAndDate_In[38:35] <= 4'b0001;   // higher digit of year is 1
 clock_timeAndDate_In[41:39] <= 3'b010;    // weekday is Tuesday
 clock_timeAndDate_In[43:42] <= 2'b00;     // timezone is 0
 
 SetClock_timeAndDate_in[3:0]   <= 4'b0111;   // lower digit of second is 7
 SetClock_timeAndDate_in[6:4]   <= 3'b101;    // higher digit of second is 5
 SetClock_timeAndDate_in[10:7]  <= 4'b1001;   // lower digit of minute is 9
 SetClock_timeAndDate_in[13:11] <= 3'b101;    // higher digit of minute is 5
 SetClock_timeAndDate_in[17:14] <= 4'b0011;   // lower digit of hour is 3
 SetClock_timeAndDate_in[19:18] <= 2'b10;     // higher digit of hour is 2
 SetClock_timeAndDate_in[23:20] <= 4'b0001;   // lower digit of day is 1
 SetClock_timeAndDate_in[25:24] <= 2'b11;     // higher digit of day is 3
 SetClock_timeAndDate_in[29:26] <= 4'b0110;   // lower digit of month is 6
 SetClock_timeAndDate_in[30]    <= 1'b0;      // higher digit of month is 0
 SetClock_timeAndDate_in[34:31] <= 4'b1001;   // lower digit of year is 9
 SetClock_timeAndDate_in[38:35] <= 4'b0001;   // higher digit of year is 1
 SetClock_timeAndDate_in[41:39] <= 3'b010;    // weekday is Tuesday
 SetClock_timeAndDate_in[43:42] <= 2'b00;     // timezone is 0
  
 DCF_timeAndDate_in[3:0]   <= 4'b0001;   // lower digit of second is 1
 DCF_timeAndDate_in[6:4]   <= 3'b010;    // higher digit of second is 2
 DCF_timeAndDate_in[10:7]  <= 4'b1001;   // lower digit of minute is 9
 DCF_timeAndDate_in[13:11] <= 3'b101;    // higher digit of minute is 5
 DCF_timeAndDate_in[17:14] <= 4'b0011;   // lower digit of hour is 3
 DCF_timeAndDate_in[19:18] <= 2'b10;     // higher digit of hour is 2
 DCF_timeAndDate_in[23:20] <= 4'b0010;   // lower digit of day is 2
 DCF_timeAndDate_in[25:24] <= 2'b11;     // higher digit of day is 3
 DCF_timeAndDate_in[29:26] <= 4'b0110;   // lower digit of month is 6
 DCF_timeAndDate_in[30]    <= 1'b0;      // higher digit of month is 0
 DCF_timeAndDate_in[34:31] <= 4'b1001;   // lower digit of year is 9
 DCF_timeAndDate_in[38:35] <= 4'b0001;   // higher digit of year is 1
 DCF_timeAndDate_in[41:39] <= 3'b010;    // weekday is Tuesday
 DCF_timeAndDate_in[43:42] <= 2'b00;     // timezone is 0
 
 #100 DCF_Enable_in = 1'b1;
 #100 DCF_Enable_in = 1'b0;
 #100 DCF_Enable_in = 1'b0;
 #100 SET_in = 1'b0;
 end
 
 control_unit DUT(
	.cll(clock),
	.clk_en(clk_en),
	.nReset(rst),
	.SET_in(SET_in),
	.DCF_timeAndDate_in(DCF_timeAndDate_in),
	.DCF_set_in(DCF_set_in),
	.SetClock_timeAndDate_in(SetClock_timeAndDate_in),
	.clock_timeAndDate_In(clock_timeAndDate_In),
	.LCD_timeAndDate_Out(LCD_timeAndDate_Out),
	.clock_timeAndDate_Out(clock_timeAndDate_Out),
	.clock_set_out(clock_set_out));

endmodule
	
	