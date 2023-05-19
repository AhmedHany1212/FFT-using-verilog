module butterfly #(parameter no_comp_word = 2 , in_frac_bit = 5 , in_int_bit = 4 , out_frac_bit = 5 , out_int_bit = 6 , real_w = 'b000_00000 , imag_w = 'b000_00000 , data_width = in_frac_bit + in_int_bit + 1 , data_in_acu = out_frac_bit + out_int_bit +1)
 (
    input   wire                         clk , rst,
    input   wire    [data_width-1:0]     in1_real , in1_imag,
    input   wire    [data_width-1:0]     in2_real , in2_imag,
    input   wire                         acu_load1 , acu_load2 , acu_cin1 , acu_cin2,
    input   wire                         w_addr , data_in_en , data_out_en , data_out_addr,
    input   wire                         acu_enable,
    input   wire    [no_comp_word-1:0]   data_in_addr,
    output  wire    [data_width-1:0]     out1_real , out1_imag,
    output  wire    [data_width-1:0]     out2_real , out2_imag
 );


            wire     [data_width-1:0]   data1, data2;
            wire     [data_width-1:0]   acu_out1, acu_out2;
            wire     [data_width-1:0]   weight;
            wire     [data_in_acu-1:0]  mult_out , data_load;

 Reg_in #(.NO_comp_word(no_comp_word) , .data_width(data_width))
   data_in_reg (
    .in_data( {in2_imag , in2_real , in1_imag , in1_real } ),
    .clk ( clk ),
    .rst ( rst ),
    .enable ( data_in_en ),
    .out ( { data2 , data1} ),           //{b,a}
    .address ( data_in_addr )
 );

 Reg_out #(.NO_comp_word(no_comp_word) , .data_width(data_width))
   data_out_reg (
    .in_data ( { acu_out2 , acu_out1 } ),        
    .clk ( clk ),
    .rst ( rst ),
    .enable ( data_out_en ),
    .out ( { out2_imag , out2_real , out1_imag , out1_real } ),
    .sel ( data_out_addr)
 );

 mult_fp #(.in_frac_bit(in_frac_bit) , .in_int_bit(in_int_bit) , .out_frac_bit(out_frac_bit) , .out_int_bit(out_int_bit))
   Multplier (
     .A(data2),
     .B(weight),
     .out(mult_out)
 );

 weight_mem #(.data_width(data_width) , .real_w(real_w) , .imag_w(imag_w))
   w_mem (
     .address(w_addr),
     .out_w(weight)
 );
 assign data_load = (data1[data_width-1] == 0)? {2'b00 , data1} : {2'b11 , data1};
 acumlator #( .data_in_width(data_in_acu) , .data_out_width(data_width) )
   acu1 (
    .data_in(mult_out),
    .data_load(data_load),
    .clk(clk),
    .rst(rst),
    .load(acu_load1),
    .cin(acu_cin1),
    .enable(acu_enable),
    .out(acu_out1)
 );

 acumlator #( .data_in_width(data_in_acu) , .data_out_width(data_width) )
 acu2 (
    .data_in(mult_out),
    .data_load(data_load),
    .clk(clk),
    .rst(rst),
    .load(acu_load2),
    .cin(acu_cin2),
    .enable(acu_enable),
    .out(acu_out2)
 );

endmodule 
