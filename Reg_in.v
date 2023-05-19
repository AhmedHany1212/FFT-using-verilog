module Reg_in #(parameter NO_comp_word = 2 , data_width = 8) (
    input   wire    [2 * NO_comp_word * data_width-1 : 0]     in_data,        // a1[7:0] a2[8:15] b1[16:23] b2[24:31]
    input   wire                                              clk , rst,
    input   wire                                              enable,
    output  reg     [NO_comp_word * data_width-1 : 0]         out,
    input   wire    [NO_comp_word-1:0]                        address
 );
    reg    [2 * NO_comp_word * data_width-1 : 0]  mem;
    
    always @(posedge clk or negedge rst)
        begin
            if ( !rst )
                mem <= 0;
            else if ( enable )
                mem <= in_data;
        end

    always @(*)
        begin
            case ( address )
                0 :     out <= {mem[ 3 * data_width - 1 : data_width * 2 ]  , mem[ 1 * data_width - 1 : data_width * 0 ]};     // { b1 , a1 }
                1 :     out <= {mem[ 4 * data_width - 1 : data_width * 3 ]  , mem[ 1 * data_width - 1 : data_width * 0 ]};     // { b2 , a1 }
                2 :     out <= {mem[ 3 * data_width - 1 : data_width * 2 ]  , mem[ 2 * data_width - 1 : data_width * 1 ]};    // { b1 , a2 }
                3 :     out <= {mem[ 4 * data_width - 1 : data_width * 3 ]  , mem[ 2 * data_width - 1 : data_width * 1 ]};    // { b2 , a2 }
                default:    out <= 0;
            endcase
        end
endmodule