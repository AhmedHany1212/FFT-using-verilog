module FFT_stage_unit 
  #(parameter no_point = 32,
              in_frac_bit = 5,
              in_int_bit = 4,
              out_frac_bit = 5,
              out_int_bit = 6,
              data_width = in_frac_bit + in_int_bit + 1,
              data_in_acu = out_frac_bit + out_int_bit +1,
              real_w_bf1 = 0 ,imag_w_bf1 = 0,
              real_w_bf2 = 0 ,imag_w_bf2 = 0,
              real_w_bf3 = 0 ,imag_w_bf3 = 0,
              real_w_bf4 = 0 ,imag_w_bf4 = 0,
              real_w_bf5 = 0 ,imag_w_bf5 = 0,
              real_w_bf6 = 0 ,imag_w_bf6 = 0,
              real_w_bf7 = 0 ,imag_w_bf7 = 0,
              real_w_bf8 = 0 ,imag_w_bf8 = 0,
              real_w_bf9 = 0 ,imag_w_bf9 = 0,
              real_w_bf10 = 0,imag_w_bf10 = 0,
              real_w_bf11 = 0,imag_w_bf11 = 0,
              real_w_bf12 = 0,imag_w_bf12 = 0,
              real_w_bf13 = 0,imag_w_bf13 = 0,
              real_w_bf14 = 0,imag_w_bf14 = 0,
              real_w_bf15 = 0,imag_w_bf15 = 0,
              real_w_bf16 = 0,imag_w_bf16 = 0
			  )
 (
    input   wire                                    clk , rst,

    input   wire    [no_point * data_width-1:0]     in_real , in_imag,

    input   wire                                    acu_load1 , acu_load2 , acu_cin1 , acu_cin2,
    input   wire                                    w_addr , data_in_en , data_out_en , data_out_addr,
    input   wire    [2-1:0]                         data_in_addr,
    input   wire                                    acu_enable,

    output  wire    [no_point * data_width-1:0]     out_real , out_imag
 );

 localparam [(no_point/2) * data_width-1:0] real_w = { real_w_bf16 , real_w_bf15 , real_w_bf14 , real_w_bf13 , real_w_bf12 , real_w_bf11 , real_w_bf10 , real_w_bf9 , real_w_bf8 , real_w_bf7 , real_w_bf6 , real_w_bf5 , real_w_bf4 , real_w_bf3 , real_w_bf2 , real_w_bf1};
 localparam [(no_point/2) * data_width-1:0] imag_w = { imag_w_bf16 , imag_w_bf15 , imag_w_bf14 , imag_w_bf13 , imag_w_bf12 , imag_w_bf11 , imag_w_bf10 , imag_w_bf9 , imag_w_bf8 , imag_w_bf7 , imag_w_bf6 , imag_w_bf5 , imag_w_bf4 , imag_w_bf3 , imag_w_bf2 , imag_w_bf1};
 
 
 genvar i;
 generate
   for ( i=0 ; i< no_point ; i = i + 2 )
  begin
       butterfly #(.no_comp_word(2), .in_frac_bit(in_frac_bit) , .in_int_bit(in_int_bit) , .out_frac_bit(out_frac_bit) , .out_int_bit(out_int_bit) , .real_w(real_w[(i/2+1) * data_width-1 : i/2 * data_width]) , .imag_w(imag_w[(i/2+1) * data_width-1 : i/2 * data_width]) ) 
         BF
        (
         .clk(clk),
  	     .rst(rst),
         .in1_real(in_real[(i+1) * data_width-1 : i * data_width]),
  	     .in1_imag(in_imag[(i+1) * data_width-1 : i * data_width]),
         .in2_real(in_real[(i+2) * data_width-1 : (i+1) * data_width]),
  	     .in2_imag(in_imag[(i+2) * data_width-1 : (i+1) * data_width]),
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
         .out1_real(out_real[(i+1) * data_width-1 : i * data_width]),
  	     .out1_imag(out_imag[(i+1) * data_width-1 : i * data_width]),
         .out2_real(out_real[(i+2) * data_width-1 : (i+1) * data_width]),
  	     .out2_imag(out_imag[(i+2) * data_width-1 : (i+1) * data_width])
        );
  end
 endgenerate


endmodule