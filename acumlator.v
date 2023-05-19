module acumlator #(parameter data_in_width = 10 , data_out_width = 8)
 (
    input   wire    [data_in_width-1:0]    data_in,
    input   wire    [data_in_width-1:0]    data_load,
    input   wire                           clk , rst,
    input   wire                           load , cin,
    input   wire                           enable,
    output  wire    [data_out_width-1:0]   out
 );

            reg     [data_in_width-1:0]    out_reg;

    always @ (posedge clk or negedge rst)
        begin
          if (!rst)
                out_reg <= 0;
          else if (enable)
            begin
                if (load )
                    if (cin)
                        out_reg <= data_load - data_in;
                    else
                        out_reg <= data_load + data_in;
                else
                    if(cin)
                        out_reg <= out_reg - data_in;
                    else 
                        out_reg <= out_reg + data_in;
            end
        end

    assign out = { out_reg[data_in_width-1] , out_reg[data_out_width-2:0] };

 endmodule