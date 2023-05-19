`timescale 1ns / 1ps
module FFT_top_tb;

 reg                      clk, rst;
 reg                      start_data;
 reg                      address; 
 wire                     right_data;

 FFT_top#(
	.no_point(),
    .in_frac_bit(),
    .in_int_bit(),
    .out_frac_bit(),
    .out_int_bit()
  ) FFT_UUT(
   .clk(clk),
   .rst(rst),
   .address(address),
   .start_data(start_data),
   .right_data(right_data)
  );

 always #5 clk = ~clk ; 

 initial
    begin
		    clk = 1'b1;
        rst = 1'b0;
        start_data = 1'b0;
        address = 1'b0;
        #20;
        rst = 1'b1;

        #20
        in_data;
        #20;
    end

    task in_data ();
      begin
        start_data = 1'b1;
  
        #50 start_data = 1'b0;
        address = 1'b0;
        #50;
        address = 1'b1;
        #50;
        address = 1'b0;
        #50;
      end
    endtask



endmodule 