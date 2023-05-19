module Reg_out #(parameter NO_comp_word = 2 , data_width = 8) (
    input   wire    [NO_comp_word * data_width-1 : 0]     in_data,        
    input   wire                                          clk , rst,
    input   wire                                          enable,
    output  reg    [2 * NO_comp_word * data_width-1 : 0] out,        // zr1[7:0] zi1[8:15] zr2[16:23] zi2[24:31]
    input   wire                                          sel
 );
    
    
    always @(posedge clk or negedge rst)
        begin
            if ( !rst )
                out <= 0;
            else if ( enable )
                case(sel)
                    0 :     begin
                                 out[ 1 * data_width - 1 : data_width * 0 ] <= in_data[data_width-1:0];    //store Z1r
                                 out[ 3 * data_width - 1 : data_width * 2 ] <= in_data[2*data_width-1:1*data_width];    //store Z2r
                            end
                    1 :     begin
                                 out[ 2 * data_width - 1 : data_width * 1 ] <= in_data[data_width-1:0];    //store Z1i
                                 out[ 4 * data_width - 1 : data_width * 3 ] <= in_data[2*data_width-1:1*data_width];    //store Z2i
                            end
                endcase
        end


endmodule