


module ram_16x16(
    input clk,
    input rst,
    input rw,
    input cs,
    input [3:0] address,
    input [15:0] data_in,
    output  reg [15:0] data_out
    );
    reg [15:0] mem [15:0];
    always @(posedge clk)
    begin
    if(rst)
    begin
       mem[4'b0000] =16'h01;
    mem[4'b0001 ]=16'h02;
    mem[4'b0010] =16'h03;
    mem[4'b0011] =16'h04;
    mem[4'b0100] =16'h05;
    mem[4'b0101] =16'h06;
    mem[4'b0110] =16'h32;
    mem[4'b0111] =16'h50;
    mem[4'b1000] =16'h30;
    mem[4'b1001] =16'h25;
    mem[4'b1010] =16'h40;
    mem[4'b1011] =16'h61;
    mem[4'b1100] =16'h72;
    mem[4'b1101] =16'h83;
    mem[4'b1110] =16'h94;
    mem[4'b1111]=16'h105;
    end
    else
    begin
        if(cs)
        begin
            if(~rw)
               mem[address] <= data_in; 
            else
                data_out <= mem[address];
        end 
    end
    end
endmodule
