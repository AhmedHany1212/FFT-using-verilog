module Mapper_s3_s4 #(parameter data_width = 8 , no_in_out = 32) 
    (
        input   wire    [no_in_out * data_width - 1 : 0]    input_data_real, input_data_imag,
        output  reg     [no_in_out * data_width - 1 : 0]    output_data_real, output_data_imag
 );


 always @ (*)
    begin
		//real_values 
        output_data_real[ (0 +1) * data_width -1 : 0  * data_width] = input_data_real [ (0 +1) * data_width -1 : 0  * data_width];
        output_data_real[ (1 +1) * data_width -1 : 1  * data_width] = input_data_real [ (16+1) * data_width -1 : 16 * data_width];
        output_data_real[ (2 +1) * data_width -1 : 2  * data_width] = input_data_real [ (2 +1) * data_width -1 : 2  * data_width];
        output_data_real[ (3 +1) * data_width -1 : 3  * data_width] = input_data_real [ (18+1) * data_width -1 : 18 * data_width];
        output_data_real[ (4 +1) * data_width -1 : 4  * data_width] = input_data_real [ (4 +1) * data_width -1 : 4  * data_width];
        output_data_real[ (5 +1) * data_width -1 : 5  * data_width] = input_data_real [ (20+1) * data_width -1 : 20 * data_width];
        output_data_real[ (6 +1) * data_width -1 : 6  * data_width] = input_data_real [ (6 +1) * data_width -1 : 6  * data_width];
        output_data_real[ (7 +1) * data_width -1 : 7  * data_width] = input_data_real [ (22+1) * data_width -1 : 22 * data_width];
        output_data_real[ (8 +1) * data_width -1 : 8  * data_width] = input_data_real [ (8 +1) * data_width -1 : 8  * data_width];
        output_data_real[ (9 +1) * data_width -1 : 9  * data_width] = input_data_real [ (24+1) * data_width -1 : 24 * data_width];
        output_data_real[ (10+1) * data_width -1 : 10 * data_width] = input_data_real [ (10+1) * data_width -1 : 10 * data_width];
        output_data_real[ (11+1) * data_width -1 : 11 * data_width] = input_data_real [ (26+1) * data_width -1 : 26 * data_width];
        output_data_real[ (12+1) * data_width -1 : 12 * data_width] = input_data_real [ (12+1) * data_width -1 : 12 * data_width];
        output_data_real[ (13+1) * data_width -1 : 13 * data_width] = input_data_real [ (28+1) * data_width -1 : 28 * data_width];
        output_data_real[ (14+1) * data_width -1 : 14 * data_width] = input_data_real [ (14+1) * data_width -1 : 14 * data_width];
        output_data_real[ (15+1) * data_width -1 : 15 * data_width] = input_data_real [ (30+1) * data_width -1 : 30 * data_width];
        output_data_real[ (16+1) * data_width -1 : 16 * data_width] = input_data_real [ (1 +1) * data_width -1 : 1  * data_width];
        output_data_real[ (17+1) * data_width -1 : 17 * data_width] = input_data_real [ (17+1) * data_width -1 : 17 * data_width];
        output_data_real[ (18+1) * data_width -1 : 18 * data_width] = input_data_real [ (3 +1) * data_width -1 : 3  * data_width];
        output_data_real[ (19+1) * data_width -1 : 19 * data_width] = input_data_real [ (19+1) * data_width -1 : 19 * data_width];
        output_data_real[ (20+1) * data_width -1 : 20 * data_width] = input_data_real [ (5 +1) * data_width -1 : 5  * data_width];
        output_data_real[ (21+1) * data_width -1 : 21 * data_width] = input_data_real [ (21+1) * data_width -1 : 21 * data_width];
        output_data_real[ (22+1) * data_width -1 : 22 * data_width] = input_data_real [ (7 +1) * data_width -1 : 7  * data_width];
        output_data_real[ (23+1) * data_width -1 : 23 * data_width] = input_data_real [ (23+1) * data_width -1 : 23 * data_width];
        output_data_real[ (24+1) * data_width -1 : 24 * data_width] = input_data_real [ (9 +1) * data_width -1 : 9  * data_width];
        output_data_real[ (25+1) * data_width -1 : 25 * data_width] = input_data_real [ (25+1) * data_width -1 : 25 * data_width];
        output_data_real[ (26+1) * data_width -1 : 26 * data_width] = input_data_real [ (11+1) * data_width -1 : 11 * data_width];
        output_data_real[ (27+1) * data_width -1 : 27 * data_width] = input_data_real [ (27+1) * data_width -1 : 27 * data_width];
        output_data_real[ (28+1) * data_width -1 : 28 * data_width] = input_data_real [ (13+1) * data_width -1 : 13 * data_width];
        output_data_real[ (29+1) * data_width -1 : 29 * data_width] = input_data_real [ (29+1) * data_width -1 : 29 * data_width];
        output_data_real[ (30+1) * data_width -1 : 30 * data_width] = input_data_real [ (15+1) * data_width -1 : 15 * data_width];
        output_data_real[ (31+1) * data_width -1 : 31 * data_width] = input_data_real [ (31+1) * data_width -1 : 31 * data_width];
		                                                                                                           
		//imag_values                                                                                              
		output_data_imag[ (0 +1) * data_width -1 : 0  * data_width] = input_data_imag [ (0 +1) * data_width -1 : 0  * data_width];
        output_data_imag[ (1 +1) * data_width -1 : 1  * data_width] = input_data_imag [ (16+1) * data_width -1 : 16 * data_width];
        output_data_imag[ (2 +1) * data_width -1 : 2  * data_width] = input_data_imag [ (2 +1) * data_width -1 : 2  * data_width];
        output_data_imag[ (3 +1) * data_width -1 : 3  * data_width] = input_data_imag [ (18+1) * data_width -1 : 18 * data_width];
        output_data_imag[ (4 +1) * data_width -1 : 4  * data_width] = input_data_imag [ (4 +1) * data_width -1 : 4  * data_width];
        output_data_imag[ (5 +1) * data_width -1 : 5  * data_width] = input_data_imag [ (20+1) * data_width -1 : 20 * data_width];
        output_data_imag[ (6 +1) * data_width -1 : 6  * data_width] = input_data_imag [ (6 +1) * data_width -1 : 6  * data_width];
        output_data_imag[ (7 +1) * data_width -1 : 7  * data_width] = input_data_imag [ (22+1) * data_width -1 : 22 * data_width];
        output_data_imag[ (8 +1) * data_width -1 : 8  * data_width] = input_data_imag [ (8 +1) * data_width -1 : 8  * data_width];
        output_data_imag[ (9 +1) * data_width -1 : 9  * data_width] = input_data_imag [ (24+1) * data_width -1 : 24 * data_width];
        output_data_imag[ (10+1) * data_width -1 : 10 * data_width] = input_data_imag [ (10+1) * data_width -1 : 10 * data_width];
        output_data_imag[ (11+1) * data_width -1 : 11 * data_width] = input_data_imag [ (26+1) * data_width -1 : 26 * data_width];
        output_data_imag[ (12+1) * data_width -1 : 12 * data_width] = input_data_imag [ (12+1) * data_width -1 : 12 * data_width];
        output_data_imag[ (13+1) * data_width -1 : 13 * data_width] = input_data_imag [ (28+1) * data_width -1 : 28 * data_width];
        output_data_imag[ (14+1) * data_width -1 : 14 * data_width] = input_data_imag [ (14+1) * data_width -1 : 14 * data_width];
        output_data_imag[ (15+1) * data_width -1 : 15 * data_width] = input_data_imag [ (30+1) * data_width -1 : 30 * data_width];
        output_data_imag[ (16+1) * data_width -1 : 16 * data_width] = input_data_imag [ (1 +1) * data_width -1 : 1  * data_width];
        output_data_imag[ (17+1) * data_width -1 : 17 * data_width] = input_data_imag [ (17+1) * data_width -1 : 17 * data_width];
        output_data_imag[ (18+1) * data_width -1 : 18 * data_width] = input_data_imag [ (3 +1) * data_width -1 : 3  * data_width];
        output_data_imag[ (19+1) * data_width -1 : 19 * data_width] = input_data_imag [ (19+1) * data_width -1 : 19 * data_width];
        output_data_imag[ (20+1) * data_width -1 : 20 * data_width] = input_data_imag [ (5 +1) * data_width -1 : 5  * data_width];
        output_data_imag[ (21+1) * data_width -1 : 21 * data_width] = input_data_imag [ (21+1) * data_width -1 : 21 * data_width];
        output_data_imag[ (22+1) * data_width -1 : 22 * data_width] = input_data_imag [ (7 +1) * data_width -1 : 7  * data_width];
        output_data_imag[ (23+1) * data_width -1 : 23 * data_width] = input_data_imag [ (23+1) * data_width -1 : 23 * data_width];
        output_data_imag[ (24+1) * data_width -1 : 24 * data_width] = input_data_imag [ (9 +1) * data_width -1 : 9  * data_width];
        output_data_imag[ (25+1) * data_width -1 : 25 * data_width] = input_data_imag [ (25+1) * data_width -1 : 25 * data_width];
        output_data_imag[ (26+1) * data_width -1 : 26 * data_width] = input_data_imag [ (11+1) * data_width -1 : 11 * data_width];
        output_data_imag[ (27+1) * data_width -1 : 27 * data_width] = input_data_imag [ (27+1) * data_width -1 : 27 * data_width];
        output_data_imag[ (28+1) * data_width -1 : 28 * data_width] = input_data_imag [ (13+1) * data_width -1 : 13 * data_width];
        output_data_imag[ (29+1) * data_width -1 : 29 * data_width] = input_data_imag [ (29+1) * data_width -1 : 29 * data_width];
        output_data_imag[ (30+1) * data_width -1 : 30 * data_width] = input_data_imag [ (15+1) * data_width -1 : 15 * data_width];
        output_data_imag[ (31+1) * data_width -1 : 31 * data_width] = input_data_imag [ (31+1) * data_width -1 : 31 * data_width];
    end
endmodule