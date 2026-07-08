module wave_gen(
   input logic clk, rst_n,
   input logic [1:0] mode, //waveform selection, 0-sawtooth, 1-square, 2-triangle
   input logic [2:0] incline,
   output logic [6:0] dac_value
);

logic [6:0] dac_square;
logic [6+5:0] dac_sawtooth;
logic [6+5:0] dac_triangle;
logic [6:0] dac_next;

logic [6:0] period_cnt;
logic [5:0] half_period = 6'd63;
logic up_down;
logic [6:0] amp = 7'd63;

assign dac_next = (mode == 2'd0) ? dac_sawtooth[11:5] :
	(mode == 2'd1) ? dac_square :  dac_triangle[11:5];

always_ff @(posedge clk, negedge rst_n)
	if(!rst_n)
		dac_value <= 7'd0;
	else
		dac_value <= dac_next;

always_ff @(posedge clk, negedge rst_n)
	if(!rst_n)
		period_cnt <= 0;
	else
		if(period_cnt >= 2*half_period)
			period_cnt <= 0;
		else
			period_cnt <= period_cnt + 1;

		
always_ff @(posedge clk, negedge rst_n)
	if(!rst_n)
		dac_square <= 7'd0;
	else
		if (period_cnt < half_period)
			dac_square <= 7'd0;
		else
			dac_square <= 7'd0 + amp;


always_ff @(posedge clk, negedge rst_n)
	if(!rst_n)
		dac_sawtooth <= {7'd0, 5'd0};
	else
		if (period_cnt == half_period || period_cnt == 2*half_period)
			dac_sawtooth <= {7'd0, 5'd0};
		else
			dac_sawtooth <= dac_sawtooth + (1 << (incline < 5 ? incline : 5));

always_ff@(posedge clk, negedge rst_n)
	if(!rst_n)
		up_down <= 1'b1;
	else
		if(period_cnt == half_period - 1)
			up_down <= 1'b0;
			else if(period_cnt >= 2*half_period - 1)
				up_down <= 1'b1;

always_ff @(posedge clk, negedge rst_n)
	if(!rst_n)
		dac_triangle <= 12'd0;
	else
		if (period_cnt == 2*half_period)
			dac_triangle <= 12'd0;
		else
			if (up_down)
				dac_triangle <= dac_triangle + (1 << (incline < 5 ? incline : 5));
			else
				dac_triangle <= dac_triangle - (1 << (incline < 5 ? incline : 5));
endmodule