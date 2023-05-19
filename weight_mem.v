module weight_mem # (parameter data_width = 8 , real_w = 'b000_00000 , imag_w = 'b000_00000 )
 (
    input   wire            address,
    output  wire    [data_width-1:0]   out_w
 );

    assign  out_w = (address == 0)? real_w : imag_w ;

endmodule