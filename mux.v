
module mux(
    input [15:0] alu_op,
    input [15:0] data_out,
    input we,
    output reg [15:0] data_in
    );
    always @(alu_op,data_out,we)
    begin
        if(we)
        begin
            data_in = alu_op;
        end
        else
        begin
            data_in = data_out;
        end
    end
endmodule
