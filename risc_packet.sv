class risc_packet;
rand logic [3:0]opcode;
rand logic [3:0]operand_1;
rand logic [7:0]operand_2;
rand logic cin;

logic [15:0]alu_op;
logic cb;

//constraint op_code_c {opcode inside {[15:0]};}

//constraint operand_1_c {operand_1 inside {[15:0]};}

//constraint cin_c {cin inside {[1:0]};}

function void pre_randomize();
endfunction

function void post_randomize();
endfunction

endclass 