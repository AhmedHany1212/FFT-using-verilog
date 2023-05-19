`timescale 1ns / 1ps
module mult_fp_tb;

 reg    signed  [7:0]         A;
 reg    signed	[7:0]         B;
 wire   signed	[9:0]        out;

 mult_fp #(
    .in_frac_bit(5),
    .in_int_bit(2),
    .out_frac_bit(5),
    .out_int_bit(4)
    )
    mult_uut
 (
 .A(A),
 .B(B),
 .out(out)
 );

 reg [7:0]  mem_in1 [100-1:0];
 reg [7:0]  mem_in2 [100-1:0];
 reg [9:0]  mem_out [100-1:0];


 initial
    begin
        $readmemb("mult_data_in_1.txt",mem_in1);
        $readmemb("mult_data_in_2.txt",mem_in2);
        $readmemb("mult_data_out.txt",mem_out);
        read_data();
        $stop;
    end

    task read_data();
        integer i ;
        integer err;
        begin
            err = 0;
            for(i = 0 ; i < 100 ; i = i + 1)
                begin
                    A = mem_in1[i];
                    B = mem_in2[i];
                    #100;
                    if(out != mem_out[i]) 
                        begin
                            $display("error at index %0d , incorrect out = %0b expected %0b\n", i , out , mem_out[i]);
                            err = err + 1;
                        end
                end
            if (err == 0) 
                $display ("PASSED , the mult_fp:body works correctly\n");
        end
    endtask


endmodule