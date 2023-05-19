`timescale 1ns / 1ps
module butterfly_tb;

 reg                         clk , rst;
 reg    [7:0]                in1_real , in1_imag;
 reg    [7:0]                in2_real , in2_imag;
 reg                         end_f;
 wire                        right_data_f;
 wire                        acu_load1 , acu_load2 , acu_cin1 , acu_cin2;
 wire                        w_addr , data_in_en , data_out_en , data_out_addr;
 wire   [1:0]                data_in_addr;
 wire   [7:0]                out1_real , out1_imag;
 wire   [7:0]                out2_real , out2_imag;
 wire                        acu_enable;
 reg                         enable;


 butterfly #( .no_comp_word(2) , .in_frac_bit(5) , .in_int_bit(2) , .out_frac_bit(5) , .out_int_bit(4) , .real_w(8'b001_00000) , .imag_w (8'b000_10000) )
    UUT1
 (
  .clk(clk),
  .rst(rst),
  .in1_real(in1_real),
  .in1_imag(in1_imag),
  .in2_real(in2_real),
  .in2_imag(in2_imag),
  .acu_load1(acu_load1),
  .acu_load2(acu_load2),
  .acu_cin1(acu_cin1),
  .acu_cin2(acu_cin2),
  .w_addr(w_addr),
  .data_in_en(data_in_en),
  .data_out_en(data_out_en),
  .data_out_addr(data_out_addr),
  .data_in_addr(data_in_addr),
  .out1_real(out1_real),
  .out1_imag(out1_imag),
  .out2_real(out2_real),
  .out2_imag(out2_imag),
  .acu_enable(acu_enable)
 );

 FSM_butterfly     UUT2(
  .enable(enable),
  .end_f(end_f),
  .right_data_f(right_data_f),
  .clk(clk),
  .rst(rst),
  .acu_load1(acu_load1),
  .acu_load2(acu_load2),
  .acu_cin1(acu_cin1),
  .acu_cin2(acu_cin2),
  .w_addr(w_addr),
  .data_in_en(data_in_en),
  .data_out_en(data_out_en),
  .data_out_addr(data_out_addr),
  .data_in_addr(data_in_addr),
  .acu_enable(acu_enable)
);

 always #10 clk = ~clk ; 

 initial
    begin
		  clk = 1'b1;
        rst = 1'b0;
        enable = 1'b0;
        end_f = 1'b0;
        #130;
        rst = 1'b1;

        #30
        enable = 1'b1;
        in1_real = 8'b001_10011;         //1.59375
        in1_imag = 8'b110_10011;         //-1.40625
        in2_real = 8'b001_00101;         //1.15625
        in2_imag = 8'b110_01000;         //-1.75
        

        #50
        enable = 1'b0;
        in1_real = 8'b011_10001;         //3.53125
        in1_imag = 8'b010_10101;         //2.65625
        in2_real = 8'b000_10110;         //0.6875
        in2_imag = 8'b111_01010;         //-0.6875
        #50 end_f = 1;
		
    end



endmodule