class probe_packet;
//insruction decoder
/*    bit [3:0] opcode;
    bit [3:0] operand_1;
    bit [7:0] operand_2;
    bit [15:0] data_out;
    bit rw;
    bit cs;
    bit [3:0] address;
    bit [3:0] alu_operation;
    bit [15:0] alu_opr1;
    bit [7:0] alu_opr2;
    bit wb; */

//alu
/*    bit [15:0] alu_operand_1;
    bit [15:0] alu_operand_2;
    bit [3:0] alu_operation;
    bit cin;
    bit [15:0] alu_op;
    bit cb;
*/
//ram16x16
    bit rw;
    bit cs;
    bit [3:0] address;
    bit [15:0] data_in;
    bit [15:0] data_out;

endclass 