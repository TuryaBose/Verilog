// ------------------------------------------------------------------------- --
// Title         : Clockwork
// Project       : Praktikum FPGA-Entwurfstechnik
// ------------------------------------------------------------------------- --
// File          : timeAndDateClock.v
// Author        : Shutao Zhang
// Company       : IDS RWTH Aachen 
// Created       : 2018/08/16
// ------------------------------------------------------------------------- --
// Description   : Clockwork for a DCF77 radio-controlled clock
// ------------------------------------------------------------------------- --
// Revisions     :
// Date        Version  Author  Description
// 2018/08/16  1.0      SH      Created
// 2018/09/20  1.1      TS      Clean up, comments
// ------------------------------------------------------------------------- --

module timeAndDateClock(input clk,                // global 10Mhz clock
                        input clkEn1Hz,           // 1Hz clock
                        input nReset,             // asynchronous reset (active low)  
                        input setTimeAndDate_in,  
                        input[43:0] timeAndDate_In,     
                        output reg[43:0] timeAndDate_Out);   

// ---------- YOUR CODE HERE ---------- 
initial
	begin
		timeAndDate_Out <= 0;
	end
always@(posedge clk or negedge nReset or posedge setTimeAndDate_in)
begin
	if(!nReset) 
		begin
			timeAndDate_Out<=0;
		end
	else if (setTimeAndDate_in)
		begin
			timeAndDate_Out[43:0] <= timeAndDate_In;
		end
	else if(clkEn1Hz == 1)		
		begin
		timeAndDate_Out[3:0] <= timeAndDate_Out[3:0] + 1'b1;
		//second low bit
		if (timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[3:0] <= 0;
			timeAndDate_Out[6:4] <= timeAndDate_Out[6:4] + 1'b1;
		end
		//second high bit
		if (timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[6:0] <= 0;
			timeAndDate_Out[10:7] <= timeAndDate_Out[10:7] + 1'b1;
		end
		//minute low bit
		if (timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[10:0] <= 0;
			timeAndDate_Out[13:11] <= timeAndDate_Out[13:11] + 1'b1;
		end
		// minute high bit 
		if (timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[13:0] <= 0;
			timeAndDate_Out[17:14] <= timeAndDate_Out[17:14] + 1'b1;
		end
		// hour low bit
		if (timeAndDate_Out[17:14] == 4'd9 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[17:0] <= 0;
			timeAndDate_Out[19:18] <= timeAndDate_Out[19:18] + 1'b1;
		end
		//checking hour higher bit
		if (timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[19:0] <= 0;
			timeAndDate_Out[23:20] <= timeAndDate_Out[23:20] + 1'b1;
		end
		//checking day lower bit
		if (timeAndDate_Out[23:20] == 4'd9 & timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[23:0] <= 0;
			timeAndDate_Out[25:24] <= timeAndDate_Out[25:24] + 1'b1;
		end
		//checking day higher bit 
		if (timeAndDate_Out[25:24] == 2'd3 & timeAndDate_Out[23:20] == 4'd1 & timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[25:24] <= 0;
			timeAndDate_Out[23:20] <= 4'b0001;
			timeAndDate_Out[19:0]	<=0;
			timeAndDate_Out[29:26] <= timeAndDate_Out[29:26] + 1'b1;
		end
		//checking month lower bit
		if (timeAndDate_Out[29:26] == 4'd9 & timeAndDate_Out[25:24] == 2'd3 & timeAndDate_Out[23:20] == 4'd1 & timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[29:0] <= 0;
			timeAndDate_Out[30] <= timeAndDate_Out[30] + 1'b1;
		end
		//checking month higher bit 
		if (timeAndDate_Out[30] == 1 & timeAndDate_Out[29:26] == 4'd1 & timeAndDate_Out[25:24] == 2'd3 & timeAndDate_Out[23:20] == 4'd1 & timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[30] <= 0;
			timeAndDate_Out[29:26] <= 4'b0001;
			timeAndDate_Out[25:24] <= 0;
			timeAndDate_Out[23:20] <= 4'b0001;
			timeAndDate_Out[19:0]	<=0;
			timeAndDate_Out[34:31] <= timeAndDate_Out[34:31] + 1'b1;
		end
		//checking year lower order
		if (timeAndDate_Out[34:31]== 4'd9 & timeAndDate_Out[30] == 1 & timeAndDate_Out[29:26] == 4'd1 & timeAndDate_Out[25:24] == 2'd3 & timeAndDate_Out[23:20] == 4'd1 & timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[34:0] <= 0;
			timeAndDate_Out[38:35] <= timeAndDate_Out[38:35] + 1'b1;
		end
		//checking year higher order
		if (timeAndDate_Out[38:35] == 4'd9 & timeAndDate_Out[34:31]== 4'd9 & timeAndDate_Out[30] == 1 & timeAndDate_Out[29:26] == 4'd1 & timeAndDate_Out[25:24] == 2'd3 & timeAndDate_Out[23:20] == 4'd1 & timeAndDate_Out[19:18] == 2'd2 & timeAndDate_Out[17:14] == 4'd3 & timeAndDate_Out[13:11] == 3'd5 & timeAndDate_Out[10:7] == 4'd9 & timeAndDate_Out[6:4] == 3'd5 & timeAndDate_Out[3:0] == 4'd9)
		begin
			timeAndDate_Out[38:0] <= 38'b00000000000010000010000000000000000000;
		end
	end	
end
endmodule
