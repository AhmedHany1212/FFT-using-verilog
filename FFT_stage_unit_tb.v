`timescale 1ns / 1ps


module FFT_stage_unit_tb;

	// Inputs
	reg clk;
	reg rst;
    reg enable;
    reg end_f;
	reg [319:0] in_real;
	reg [319:0] in_imag;

	wire acu_load1;
	wire acu_load2;
	wire acu_cin1;
	wire acu_cin2;
	wire w_addr;
	wire data_in_en;
	wire data_out_en;
	wire data_out_addr;
	wire [1:0] data_in_addr;
	wire acu_enable;


	// Outputs
	wire [319:0] out_real;
	wire [319:0] out_imag;
    wire right_data_f;

	// Instantiate the Unit Under Test (UUT)
	FFT_stage_unit 
    #(
        .real_w_bf1 (10'b0000100000),.imag_w_bf1 (10'b0000000000),
        .real_w_bf2 (10'b0000100000),.imag_w_bf2 (10'b0000000000),
        .real_w_bf3 (10'b0000100000),.imag_w_bf3 (10'b0000000000),
        .real_w_bf4 (10'b0000100000),.imag_w_bf4 (10'b0000000000),
        .real_w_bf5 (10'b0000100000),.imag_w_bf5 (10'b0000000000),
        .real_w_bf6 (10'b0000100000),.imag_w_bf6 (10'b0000000000),
        .real_w_bf7 (10'b0000100000),.imag_w_bf7 (10'b0000000000),
        .real_w_bf8 (10'b0000100000),.imag_w_bf8 (10'b0000000000),
        .real_w_bf9 (10'b0000100000),.imag_w_bf9 (10'b0000000000),
        .real_w_bf10(10'b0000100000),.imag_w_bf10(10'b0000000000),
        .real_w_bf11(10'b0000100000),.imag_w_bf11(10'b0000000000),
        .real_w_bf12(10'b0000100000),.imag_w_bf12(10'b0000000000),
        .real_w_bf13(10'b0000100000),.imag_w_bf13(10'b0000000000),
        .real_w_bf14(10'b0000100000),.imag_w_bf14(10'b0000000000),
        .real_w_bf15(10'b0000100000),.imag_w_bf15(10'b0000000000),
        .real_w_bf16(10'b0000100000),.imag_w_bf16(10'b0000000000)
    )
    uut (
		.clk(clk), 
		.rst(rst), 
		.in_real(in_real), 
		.in_imag(in_imag), 
		.acu_load1(acu_load1), 
		.acu_load2(acu_load2), 
		.acu_cin1(acu_cin1), 
		.acu_cin2(acu_cin2), 
		.w_addr(w_addr), 
		.data_in_en(data_in_en), 
		.data_out_en(data_out_en), 
		.data_out_addr(data_out_addr), 
		.data_in_addr(data_in_addr), 
		.acu_enable(acu_enable), 
		.out_real(out_real), 
		.out_imag(out_imag)
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

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		in_real = 0;
		in_imag = 0;

		// Wait 100 ns for global reset to finish
		#100;
        rst = 1'b1;
        
		// Add stimulus here
        #50
        enable = 1'b1;
        in_real = { 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 ,  10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 ,  10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 ,  10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001};
        in_imag = { 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 ,  10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 ,  10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 ,  10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001 , 10'b00000_00001};
        #50
        enable = 1'b0;
        end_f = 1'b1;
        #50
        end_f = 1'b0;
        

	end
      
      always #10 clk = ~clk;
endmodule