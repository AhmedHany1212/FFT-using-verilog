module FFT_top
  #(parameter no_point = 32,
              in_frac_bit = 10,
              in_int_bit = 5,
              out_frac_bit = 10,
              out_int_bit = 7,
              data_width = in_frac_bit + in_int_bit + 1,
              data_in_acu = out_frac_bit + out_int_bit +1
  )
  (
      input     wire                                    clk, rst,
      input     wire                                    start_data,
      input     wire                                    address,
      output    wire                                    right_data
  );

      reg    [no_point * data_width-1 : 0]   data_in_real, data_in_imag;
      wire    [no_point * data_width-1 : 0]   data_out_real, data_out_imag;

      wire    [16 - 1 : 0]  real_data_out [0 : 32-1];
      wire    [16 - 1 : 0]  imag_data_out [0 : 32-1];

assign {real_data_out[31] , real_data_out[30] , real_data_out[29] , real_data_out[28] , real_data_out[27] , real_data_out[26] , real_data_out[25] , real_data_out[24] , real_data_out[23] , real_data_out[22] , real_data_out[21] , real_data_out[20] , real_data_out[19] , real_data_out[18] , real_data_out[17] , real_data_out[16] , real_data_out[15] , real_data_out[14] , real_data_out[13] , real_data_out[12] , real_data_out[11] , real_data_out[10] , real_data_out[9] , real_data_out[8] , real_data_out[7] , real_data_out[6] , real_data_out[5] , real_data_out[4] , real_data_out[3] , real_data_out[2] , real_data_out[1] , real_data_out[0]} = data_out_real;
assign {imag_data_out[31] , imag_data_out[30] , imag_data_out[29] , imag_data_out[28] , imag_data_out[27] , imag_data_out[26] , imag_data_out[25] , imag_data_out[24] , imag_data_out[23] , imag_data_out[22] , imag_data_out[21] , imag_data_out[20] , imag_data_out[19] , imag_data_out[18] , imag_data_out[17] , imag_data_out[16] , imag_data_out[15] , imag_data_out[14] , imag_data_out[13] , imag_data_out[12] , imag_data_out[11] , imag_data_out[10] , imag_data_out[9] , imag_data_out[8] , imag_data_out[7] , imag_data_out[6] , imag_data_out[5] , imag_data_out[4] , imag_data_out[3] , imag_data_out[2] , imag_data_out[1] , imag_data_out[0]} = data_out_imag;


//-------------------wires and regs-------------------//
 wire   [no_point * data_width-1 : 0]   s0_in_real,  s0_in_imag,
                                        s0_out_real, s0_out_imag,
                                        s1_in_real,  s1_in_imag,
                                        s1_out_real, s1_out_imag,
                                        s2_in_real,  s2_in_imag,
                                        s2_out_real, s2_out_imag,
                                        s3_in_real,  s3_in_imag,
                                        s3_out_real, s3_out_imag,
                                        s4_in_real,  s4_in_imag,
                                        s4_out_real, s4_out_imag;

 wire            					            	acu_load1, acu_load2, acu_cin1, acu_cin2;
 wire            						            w_addr, data_in_en, data_out_en, data_out_addr;
 wire	  [1:0]   						            data_in_addr;
 wire                                   acu_enable;

//--------------------instantiaion--------------------//

//##################### Mappers ######################//

 Mapper_in_s0 #(.data_width(data_width), .no_in_out(no_point)) 
   M_in_s0(
        .input_data_real(data_in_real),
        .output_data_real(s0_in_real),
        .input_data_imag(data_in_imag),
        .output_data_imag(s0_in_imag)
		);
		
 Mapper_s0_s1 #(.data_width(data_width), .no_in_out(no_point)) 
   M_s0_s1(
        .input_data_real(s0_out_real),
        .output_data_real(s1_in_real),
        .input_data_imag(s0_out_imag),
        .output_data_imag(s1_in_imag)
		);

 Mapper_s1_s2 #(.data_width(data_width), .no_in_out(no_point)) 
   M_s1_s2(
        .input_data_real(s1_out_real),
        .output_data_real(s2_in_real),
        .input_data_imag(s1_out_imag),
        .output_data_imag(s2_in_imag)
		);

 Mapper_s2_s3 #(.data_width(data_width), .no_in_out(no_point)) 
   M_s2_s3(
        .input_data_real(s2_out_real),
        .output_data_real(s3_in_real),
        .input_data_imag(s2_out_imag),
        .output_data_imag(s3_in_imag)
		);
		
 Mapper_s3_s4 #(.data_width(data_width), .no_in_out(no_point)) 
   M_s3_s4(
        .input_data_real(s3_out_real),
        .output_data_real(s4_in_real),
        .input_data_imag(s3_out_imag),
        .output_data_imag(s4_in_imag)
		);

 Mapper_s4_out #(.data_width(data_width), .no_in_out(no_point)) 
   M_s4_out(
        .input_data_real(s4_out_real),
        .output_data_real(data_out_real),
        .input_data_imag(s4_out_imag),
        .output_data_imag(data_out_imag)
		);
		
//################### butterflies ####################//

	//############ stage0 ############//
FFT_stage_unit 
  #(.no_point(no_point),
    .in_frac_bit(in_frac_bit),
    .in_int_bit(in_int_bit),
    .out_frac_bit(out_frac_bit),
    .out_int_bit(out_int_bit),
    .real_w_bf1 (16'b0000010000000000),.imag_w_bf1 (16'b0000000000000000),
    .real_w_bf2 (16'b0000010000000000),.imag_w_bf2 (16'b0000000000000000),
    .real_w_bf3 (16'b0000010000000000),.imag_w_bf3 (16'b0000000000000000),
    .real_w_bf4 (16'b0000010000000000),.imag_w_bf4 (16'b0000000000000000),
    .real_w_bf5 (16'b0000010000000000),.imag_w_bf5 (16'b0000000000000000),
    .real_w_bf6 (16'b0000010000000000),.imag_w_bf6 (16'b0000000000000000),
    .real_w_bf7 (16'b0000010000000000),.imag_w_bf7 (16'b0000000000000000),
    .real_w_bf8 (16'b0000010000000000),.imag_w_bf8 (16'b0000000000000000),
    .real_w_bf9 (16'b0000010000000000),.imag_w_bf9 (16'b0000000000000000),
    .real_w_bf10(16'b0000010000000000),.imag_w_bf10(16'b0000000000000000),
    .real_w_bf11(16'b0000010000000000),.imag_w_bf11(16'b0000000000000000),
    .real_w_bf12(16'b0000010000000000),.imag_w_bf12(16'b0000000000000000),
    .real_w_bf13(16'b0000010000000000),.imag_w_bf13(16'b0000000000000000),
    .real_w_bf14(16'b0000010000000000),.imag_w_bf14(16'b0000000000000000),
    .real_w_bf15(16'b0000010000000000),.imag_w_bf15(16'b0000000000000000),
    .real_w_bf16(16'b0000010000000000),.imag_w_bf16(16'b0000000000000000)
	)
	fft_s0(
		.clk(clk),
		.rst(rst),
		.in_real(s0_in_real),
		.in_imag(s0_in_imag),
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
		.out_real(s0_out_real),
		.out_imag(s0_out_imag)
	);
	
	//############ stage1 ############//
 FFT_stage_unit 
  #(.no_point(no_point),
    .in_frac_bit(in_frac_bit),
    .in_int_bit(in_int_bit),
    .out_frac_bit(out_frac_bit),
    .out_int_bit(out_int_bit),
    .real_w_bf1 (16'b0000010000000000),.imag_w_bf1 (16'b0000000000000000),
    .real_w_bf2 (16'b0000000000000000),.imag_w_bf2 (16'b1111110000000000),
    .real_w_bf3 (16'b0000010000000000),.imag_w_bf3 (16'b0000000000000000),
    .real_w_bf4 (16'b0000000000000000),.imag_w_bf4 (16'b1111110000000000),
    .real_w_bf5 (16'b0000010000000000),.imag_w_bf5 (16'b0000000000000000),
    .real_w_bf6 (16'b0000000000000000),.imag_w_bf6 (16'b1111110000000000),
    .real_w_bf7 (16'b0000010000000000),.imag_w_bf7 (16'b0000000000000000),
    .real_w_bf8 (16'b0000000000000000),.imag_w_bf8 (16'b1111110000000000),
    .real_w_bf9 (16'b0000010000000000),.imag_w_bf9 (16'b0000000000000000),
    .real_w_bf10(16'b0000000000000000),.imag_w_bf10(16'b1111110000000000),
    .real_w_bf11(16'b0000010000000000),.imag_w_bf11(16'b0000000000000000),
    .real_w_bf12(16'b0000000000000000),.imag_w_bf12(16'b1111110000000000),
    .real_w_bf13(16'b0000010000000000),.imag_w_bf13(16'b0000000000000000),
    .real_w_bf14(16'b0000000000000000),.imag_w_bf14(16'b1111110000000000),
    .real_w_bf15(16'b0000010000000000),.imag_w_bf15(16'b0000000000000000),
    .real_w_bf16(16'b0000000000000000),.imag_w_bf16(16'b1111110000000000)
  )
	fft_s1(
		.clk(clk),
		.rst(rst),
		.in_real(s1_in_real),
		.in_imag(s1_in_imag),
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
		.out_real(s1_out_real),
		.out_imag(s1_out_imag)
	);
	
	//############ stage2 ############//
 FFT_stage_unit 
  #(.no_point(no_point),
    .in_frac_bit(in_frac_bit),
    .in_int_bit(in_int_bit),
    .out_frac_bit(out_frac_bit),
    .out_int_bit(out_int_bit),
	.real_w_bf1 (16'b0000010000000000),.imag_w_bf1 (16'b0000000000000000),
    .real_w_bf2 (16'b0000001011010100),.imag_w_bf2 (16'b1111110100101100),
    .real_w_bf3 (16'b0000000000000000),.imag_w_bf3 (16'b1111110000000000),
    .real_w_bf4 (16'b1111110100101100),.imag_w_bf4 (16'b1111110100101100),
    .real_w_bf5 (16'b0000010000000000),.imag_w_bf5 (16'b0000000000000000),
    .real_w_bf6 (16'b0000001011010100),.imag_w_bf6 (16'b1111110100101100),
    .real_w_bf7 (16'b0000000000000000),.imag_w_bf7 (16'b1111110000000000),
    .real_w_bf8 (16'b1111110100101100),.imag_w_bf8 (16'b1111110100101100),
    .real_w_bf9 (16'b0000010000000000),.imag_w_bf9 (16'b0000000000000000),
    .real_w_bf10(16'b0000001011010100),.imag_w_bf10(16'b1111110100101100),
    .real_w_bf11(16'b0000000000000000),.imag_w_bf11(16'b1111110000000000),
    .real_w_bf12(16'b1111110100101100),.imag_w_bf12(16'b1111110100101100),
    .real_w_bf13(16'b0000010000000000),.imag_w_bf13(16'b0000000000000000),
    .real_w_bf14(16'b0000001011010100),.imag_w_bf14(16'b1111110100101100),
    .real_w_bf15(16'b0000000000000000),.imag_w_bf15(16'b1111110000000000),
    .real_w_bf16(16'b1111110100101100),.imag_w_bf16(16'b1111110100101100)
  )
	fft_s2(
		.clk(clk),
		.rst(rst),
		.in_real(s2_in_real),
		.in_imag(s2_in_imag),
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
		.out_real(s2_out_real),
		.out_imag(s2_out_imag)
	);
	
	//############ stage3 ############//
FFT_stage_unit 
  #(.no_point(no_point),
    .in_frac_bit(in_frac_bit),
    .in_int_bit(in_int_bit),
    .out_frac_bit(out_frac_bit),
    .out_int_bit(out_int_bit),
	  .real_w_bf1 (16'b0000010000000000),.imag_w_bf1 (16'b0000000000000000),
    .real_w_bf2 (16'b0000001110110010),.imag_w_bf2 (16'b1111111001111001),
    .real_w_bf3 (16'b0000001011010100),.imag_w_bf3 (16'b1111110100101100),
    .real_w_bf4 (16'b0000000110000111),.imag_w_bf4 (16'b1111110001001110),
    .real_w_bf5 (16'b0000000000000000),.imag_w_bf5 (16'b1111110000000000),
    .real_w_bf6 (16'b1111111001111001),.imag_w_bf6 (16'b1111110001001110),
    .real_w_bf7 (16'b1111110100101100),.imag_w_bf7 (16'b1111110100101100),
    .real_w_bf8 (16'b1111110001001110),.imag_w_bf8 (16'b1111111001111001),
    .real_w_bf9 (16'b0000010000000000),.imag_w_bf9 (16'b0000000000000000),
    .real_w_bf10(16'b0000001110110010),.imag_w_bf10(16'b1111111001111001),
    .real_w_bf11(16'b0000001011010100),.imag_w_bf11(16'b1111110100101100),
    .real_w_bf12(16'b0000000110000111),.imag_w_bf12(16'b1111110001001110),
    .real_w_bf13(16'b0000000000000000),.imag_w_bf13(16'b1111110000000000),
    .real_w_bf14(16'b1111111001111001),.imag_w_bf14(16'b1111110001001110),
    .real_w_bf15(16'b1111110100101100),.imag_w_bf15(16'b1111110100101100),
    .real_w_bf16(16'b1111110001001110),.imag_w_bf16(16'b1111111001111001)
  )
	fft_s3(
		.clk(clk),
		.rst(rst),
		.in_real(s3_in_real),
		.in_imag(s3_in_imag),
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
		.out_real(s3_out_real),
		.out_imag(s3_out_imag)
	);
	
	//############ stage4 ############//
 FFT_stage_unit 
  #(.no_point(no_point),
    .in_frac_bit(in_frac_bit),
    .in_int_bit(in_int_bit),
    .out_frac_bit(out_frac_bit),
    .out_int_bit(out_int_bit),
	.real_w_bf1 (16'b0000010000000000),.imag_w_bf1 (16'b0000000000000000),
    .real_w_bf2 (16'b0000001111101100),.imag_w_bf2 (16'b1111111100111001),
    .real_w_bf3 (16'b0000001110110010),.imag_w_bf3 (16'b1111111001111001),
    .real_w_bf4 (16'b0000001101010011),.imag_w_bf4 (16'b1111110111001000),
    .real_w_bf5 (16'b0000001011010100),.imag_w_bf5 (16'b1111110100101100),
    .real_w_bf6 (16'b0000001000111000),.imag_w_bf6 (16'b1111110010101101),
    .real_w_bf7 (16'b0000000110000111),.imag_w_bf7 (16'b1111110001001110),
    .real_w_bf8 (16'b0000000011000111),.imag_w_bf8 (16'b1111110000010100),
    .real_w_bf9 (16'b0000000000000000),.imag_w_bf9 (16'b1111110000000000),
    .real_w_bf10(16'b1111111100111001),.imag_w_bf10(16'b1111110000010100),
    .real_w_bf11(16'b1111111001111001),.imag_w_bf11(16'b1111110001001110),
    .real_w_bf12(16'b1111110111001000),.imag_w_bf12(16'b1111110010101101),
    .real_w_bf13(16'b1111110100101100),.imag_w_bf13(16'b1111110100101100),
    .real_w_bf14(16'b1111110010101101),.imag_w_bf14(16'b1111110111001000),
    .real_w_bf15(16'b1111110001001110),.imag_w_bf15(16'b1111111001111001),
    .real_w_bf16(16'b1111110000010100),.imag_w_bf16(16'b1111111100111001)
  )
	fft_s4(
		.clk(clk),
		.rst(rst),
		.in_real(s4_in_real),
		.in_imag(s4_in_imag),
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
		.out_real(s4_out_real),
		.out_imag(s4_out_imag)
	);
	
//################## FSM_butterfly ###################//
 FSM_butterfly FSM(
  .enable(start_data),
	.right_data_f(right_data),
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

 reg    [data_width - 1 : 0]  real_data_in  [0 : 2 *no_point-1];
 reg    [data_width - 1 : 0]  imag_data_in  [0 : 2 *no_point-1];
 

 initial
  begin
    $readmemb("testvector_fft/Real_in_fixed.txt",real_data_in);
    $readmemb("testvector_fft/Imag_in_fixed.txt",imag_data_in);
  end

 always @(posedge clk)
  begin
    data_in_real <= {real_data_in[31+address*32] , real_data_in[30+address*32] , real_data_in[29+address*32] , real_data_in[28+address*32] , real_data_in[27+address*32] , real_data_in[26+address*32] , real_data_in[25+address*32] , real_data_in[24+address*32] , real_data_in[23+address*32] , real_data_in[22+address*32] , real_data_in[21+address*32] , real_data_in[20+address*32] , real_data_in[19+address*32] , real_data_in[18+address*32] , real_data_in[17+address*32] , real_data_in[16+address*32] , real_data_in[15+address*32] , real_data_in[14+address*32] , real_data_in[13+address*32] , real_data_in[12+address*32] , real_data_in[11+address*32] , real_data_in[10+address*32] , real_data_in[9+address*32] , real_data_in[8+address*32] , real_data_in[7+address*32] , real_data_in[6+address*32] , real_data_in[5+address*32] , real_data_in[4+address*32] , real_data_in[3+address*32] , real_data_in[2+address*32] , real_data_in[1+address*32] , real_data_in[0+address*32]};
    data_in_imag <= {imag_data_in[31+address*32] , imag_data_in[30+address*32] , imag_data_in[29+address*32] , imag_data_in[28+address*32] , imag_data_in[27+address*32] , imag_data_in[26+address*32] , imag_data_in[25+address*32] , imag_data_in[24+address*32] , imag_data_in[23+address*32] , imag_data_in[22+address*32] , imag_data_in[21+address*32] , imag_data_in[20+address*32] , imag_data_in[19+address*32] , imag_data_in[18+address*32] , imag_data_in[17+address*32] , imag_data_in[16+address*32] , imag_data_in[15+address*32] , imag_data_in[14+address*32] , imag_data_in[13+address*32] , imag_data_in[12+address*32] , imag_data_in[11+address*32] , imag_data_in[10+address*32] , imag_data_in[9+address*32] , imag_data_in[8+address*32] , imag_data_in[7+address*32] , imag_data_in[6+address*32] , imag_data_in[5+address*32] , imag_data_in[4+address*32] , imag_data_in[3+address*32] , imag_data_in[2+address*32] , imag_data_in[1+address*32] , imag_data_in[0+address*32]};
  end
 
endmodule  