`timescale 100us/10us

module tb;

reg clk, rst_n;
reg [2:0] inc;
reg [1:0] mode;
wire [6:0] dac_value;
wave_gen dut (.clk(clk), .rst_n(rst_n), .incline(inc), .mode(mode), .dac_value(dac_value));

always #10 clk = ~clk;

initial begin
    $dumpfile("wave_gen.vcd");  
    $dumpvars(0, tb);

    clk = 0;
    rst_n = 1;
	mode = 2'd0;
    inc = 3'd5;

    #2 rst_n = 0;
    #4 rst_n = 1;
    #5000;

    for(int i = 4; i>=0; i--)begin
        inc = i;
        #5000;
    end
    

    mode = 2'd2;
    inc = 3'd5;
    #2 rst_n = 0;
    #4 rst_n = 1;
    #10000;
    for(int i = 4; i>=0; i--)begin
        inc = i;
        #10000;
    end

    mode = 2'd1;
    #2 rst_n = 0;
    #4 rst_n = 1;
    #10000;


    

    $finish;
end

endmodule