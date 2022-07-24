// ------------------------------------------------------------------------- --
// Title         : DCF77-Decoder
// Project       : Praktikum FPGA-Entwurfstechnik
// ------------------------------------------------------------------------- --
// File          : timeAndDateClock.v
// Author        : Tim Stadtmann
// Company       : IDS RWTH Aachen 
// Created       : 2018/09/20
// ------------------------------------------------------------------------- --
// Description   : Decodes the dcf77 signal
// ------------------------------------------------------------------------- --
// Revisions     :
// Date        Version  Author  Description
// 2018/09/20  1.0      TS      Created
// ------------------------------------------------------------------------- --

module dcf77_decoder(clk,             // Global 10MHz clock 
                     clk_en_1hz,      // Indicates start of second
                     nReset,          // Global reset
                     minute_start_in, // New minute trigger
                     dcf_Signal_in,   // DFC Signal
                     timeAndDate_out,
                     data_valid,      // Control signal, High if data is valid
                     dcf_value);      // Decoded value of dcf input signal
                     
input clk, 
      clk_en_1hz,     
      nReset,  
      minute_start_in,
      dcf_Signal_in;  
      
output reg[43:0]  timeAndDate_out;
output reg        data_valid;
output reg           dcf_value;
   
// ---------- YOUR CODE HERE ---------- 
reg minute_start_observed = 0;
reg [7:0] counter = 0;
reg [58:0]full_dcf_signal;


initial begin
timeAndDate_out[6:0] = 7'b0;
end


reg error_1 = 1;
reg error_2 = 1;
reg error_3 = 1;
reg [31:0] second_count = 0;
reg [31:0] ms_count = 0;
reg start_read;
reg start_ms_count;
reg another_flag;

always @(posedge clk) begin

	if( minute_start_in == 1) begin
		minute_start_observed = 1;
	end
	if(minute_start_observed == 1) begin
		second_count = second_count+1;
	end
	if (second_count == 10000000) begin
		start_read = 1;
		second_count = 0;
		minute_start_observed = 0;
	end
end

always @(negedge dcf_Signal_in, negedge another_flag ) begin
	if(!dcf_Signal_in) begin
		start_ms_count = 1;
	end	
	if( !another_flag) begin
		start_ms_count = 0;
	end
end

//count 150 ms
always @( clk) begin
	if( start_ms_count ==1) begin
		ms_count = ms_count +1;	
			another_flag =1;
	end
	
	if (ms_count == 1500000) begin
		counter = counter+1;
		full_dcf_signal[counter] <= ~dcf_Signal_in;
		ms_count = 0;
		another_flag = 0;
	end
	if (counter == 59) begin
		counter = 0;
		data_valid = 1;
	end
	else begin
		data_valid = 0;
	end
		
end
/*
always @(negedge clk_en_1hz) begin
	if(start_read == 1) begin 
		counter = counter+1;
		full_dcf_signal[counter] <= ~dcf_Signal_in;
	end
	if (counter == 59) begin
		counter = 0;
		data_valid = 1;
	end
	else begin
		data_valid = 0;
	end		
end
*/
		
always @(posedge clk) begin

	if(!nReset) begin
		timeAndDate_out <= 0;
	end
	
	else begin
		timeAndDate_out[13:7] <= full_dcf_signal[27:21];
		// assign hours
		timeAndDate_out[19:14] <= full_dcf_signal[34:29];
		// assign days
		timeAndDate_out[25:20]	<= full_dcf_signal[41:36];
		//weekday
		timeAndDate_out[41:39]	<= full_dcf_signal[44:42];
		//month
		timeAndDate_out[30:26]	<= full_dcf_signal[49:45];
		//year
		timeAndDate_out[38:31]	<= full_dcf_signal[57:50];
		//timezone
		timeAndDate_out[43:42] <= full_dcf_signal[18:17];
	end

end
            
endmodule          
/*
always @(posedge minute_start_in, negedge clk_en_1hz, negedge nReset) begin
	if(!nReset) begin
		counter <= 0;
		data_valid <= 1;
	end
	if(minute_start_in) begin
		minute_start_observed <= 1;
	end
	
	else if(!clk_en_1hz) begin
		if(!start_read) begin
			minute_start_observed <= 0;
			data_valid <= 1;
			if(!error_1 & !error_2 & !error_3) begin
				data_valid <= 1;
			end
			counter <= 0;
			dcf_value <= ~dcf_Signal_in;
			full_dcf_signal[counter] <= ~dcf_Signal_in;
		end
		else begin
			data_valid <= 0;
			dcf_value <= ~dcf_Signal_in;
			full_dcf_signal[counter+1] <= ~dcf_Signal_in;
			counter <= counter + 1;
		end
	end
end


always @( posedge clk) begin
	
	if(min_counter == 0) begin
	start_read = 1;
	end
	
	if(!nReset) begin
		error_1 <= 1;
		error_2 <= 1;
		error_3 <= 1;
		timeAndDate_out <= 0;
	end
	else begin
		timeAndDate_out[13:7] <= full_dcf_signal[27:21];
		// assign hours
		timeAndDate_out[19:14] <= full_dcf_signal[34:29];
		// assign days
		timeAndDate_out[25:20]	<= full_dcf_signal[41:36];
		//weekday
		timeAndDate_out[41:39]	<= full_dcf_signal[44:42];
		//month
		timeAndDate_out[30:26]	<= full_dcf_signal[49:45];
		//year
		timeAndDate_out[38:31]	<= full_dcf_signal[57:50];
		//timezone
		timeAndDate_out[43:42] <= full_dcf_signal[18:17];
		
		if(counter == 1'b1) begin
			error_1 <= 1;
			error_2 <= 1;
			error_3 <= 1;
		end
		else if(counter == 28) begin
			error_1 <= ^ full_dcf_signal[28:21];
		end
		else if(counter == 35) begin	
			error_2 <= ^ full_dcf_signal[35:29];
		end
		else if(counter == 58) begin
			error_3 <= ^ full_dcf_signal[58:36];
		end
	end
end
            
endmodule   
*/ 

