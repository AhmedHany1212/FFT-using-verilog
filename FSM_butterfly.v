module FSM_butterfly (
    input   wire            enable,
    output  wire            right_data_f,
    input   wire            clk , rst,
    output  reg             acu_load1 , acu_load2 , acu_cin1 , acu_cin2,
    output  reg             w_addr , data_in_en , data_out_en , data_out_addr,
    output  reg     [1:0]   data_in_addr,
    output  reg             acu_enable
);

    parameter   [2:0]       IDLE    = 3'b000,
                            DATA_IN = 3'b001,
                            Zr_half = 3'b010,
                            Zr_full = 3'b011,
                            Zi_half = 3'b100,
                            Zi_full = 3'b101;

            reg     [2:0]   current_state,
                            next_state;
                        

            reg     [4:0]   count;
            reg             count_e;


// implement counter from 0 to 25-1
 always @ (posedge clk or negedge rst)
    begin
        if(!rst)
            count <= 5'b0;
        else
            if(count_e && !right_data_f)
                count <= count + 1'b1;
            else if(!count_e)
                count <= 5'b0;
    end

 assign right_data_f = (count == 5'd24);
			
 //state transiton 
 always @ (posedge clk or negedge rst)
    begin
        if(!rst)
            begin
                current_state <= IDLE ;
            end
        else
            begin
                current_state <= next_state ;
            end
    end

 always @(*)
    begin
        case (current_state )
            IDLE:       begin
                            count_e = 1'b0;
                            acu_load1 = 1'b0;
                            acu_cin1 = 1'b0;
                            acu_load2 = 1'b0;
                            acu_cin2 = 1'b0;
                            w_addr = 1'b0;
                            data_in_en = 1'b0;
                            data_in_addr = 2'b00;
                            data_out_en = 1'b0;
                            data_out_addr = 1'b0;
                            acu_enable = 1'b0;
                        end
            DATA_IN:    begin
                            count_e = 1'b1;
                            acu_load1 = 1'b0;
                            acu_cin1 = 1'b0;
                            acu_load2 = 1'b0;
                            acu_cin2 = 1'b1;
                            w_addr = 1'b0;
                            data_in_en = 1'b1;
                            data_in_addr = 2'b00;
                            data_out_en = 1'b1;
                            data_out_addr = 1'b1;
                            acu_enable = 1'b1;
                        end
            Zr_half:    begin
                            count_e = 1'b1;
                            acu_load1 = 1'b1;
                            acu_cin1 = 1'b0;
                            acu_load2 = 1'b1;
                            acu_cin2 = 1'b1;
                            w_addr = 1'b0;
                            data_in_en = 1'b1;
                            data_in_addr = 2'b00;
                            data_out_en = 1'b0;
                            data_out_addr = 1'b0;
                            acu_enable = 1'b1;
                        end
            Zr_full:    begin
                            count_e = 1'b1;
                            acu_load1 = 1'b0;
                            acu_cin1 = 1'b1;
                            acu_load2 = 1'b0;
                            acu_cin2 = 1'b0;
                            w_addr = 1'b1;
                            data_in_en = 1'b0;
                            data_in_addr = 2'b01;
                            data_out_en = 1'b0;
                            data_out_addr = 1'b0;
                            acu_enable = 1'b1;
                        end
            Zi_half:    begin
                            count_e = 1'b1;
                            acu_load1 = 1'b1;
                            acu_cin1 = 1'b0;
                            acu_load2 = 1'b1;
                            acu_cin2 = 1'b1;
                            w_addr = 1'b1;
                            data_in_en = 1'b0;
                            data_in_addr = 2'b10;
                            data_out_en = 1'b1;
                            data_out_addr = 1'b0;
                            acu_enable = 1'b1;
                        end
            Zi_full:    begin
                            count_e = 1'b1;
                            acu_load1 = 1'b0;
                            acu_cin1 = 1'b0;
                            acu_load2 = 1'b0;
                            acu_cin2 = 1'b1;
                            w_addr = 1'b0;
                            data_in_en = 1'b0;
                            data_in_addr = 2'b11;
                            data_out_en = 1'b0;
                            data_out_addr = 1'b0;
                            acu_enable = 1'b1;
                        end
                        
            default :   begin
                            count_e = 1'b0;
                            acu_load1 = 1'b0;
                            acu_cin1 = 1'b0;
                            acu_load2 = 1'b0;
                            acu_cin2 = 1'b0;
                            w_addr = 1'b0;
                            data_in_en = 1'b0;
                            data_in_addr = 2'b00;
                            data_out_en = 1'b0;
                            data_out_addr = 1'b0;
                            acu_enable = 1'b0;
                        end
        endcase
    end
 always @(*)
    begin
        case (current_state )
            IDLE:       begin
                            if (enable == 1'b1)
                                next_state = DATA_IN;
                            else
                                next_state = IDLE;
                        end
            DATA_IN:    next_state = Zr_half;            
            Zr_half:    next_state = Zr_full;
            Zr_full:    next_state = Zi_half;
            Zi_half:    next_state = Zi_full;
            Zi_full:    next_state = DATA_IN;
            default:    next_state = IDLE;
        endcase
    end
endmodule