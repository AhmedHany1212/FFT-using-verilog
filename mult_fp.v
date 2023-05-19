module mult_fp #( parameter
    in_frac_bit = 5,
    in_int_bit = 2,
    data_in_width = in_frac_bit + in_int_bit + 1,
    out_frac_bit = 5,
    out_int_bit = 2,
    data_out_width = out_frac_bit + out_int_bit + 1
    )
 (
 input      wire    signed  [data_in_width-1:0]         A,
 input      wire    signed	[data_in_width-1:0]         B,
 output     wire    signed	[data_out_width-1:0]        out
 );



            wire                                       sign, zero_flag;
            wire        [2*data_in_width-1:0]          mult_temp;

 
 assign mult_temp = A * B;

 assign sign = !zero_flag && ( A[data_in_width-1] ^ B[data_in_width-1]);

 assign zero_flag = ( A == 0 ) || ( B == 0);   //zero_flag = 1 when A = 0 or B = 0

 assign out = zero_flag ? 0 : {sign , mult_temp [ ( in_frac_bit * 2 - 1 ) + out_int_bit : ( in_frac_bit * 2 - 1 ) + out_int_bit - ( data_out_width - 2 ) ] };

endmodule