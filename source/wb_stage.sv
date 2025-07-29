module wb_stage(mem_out,alu_out,memtoreg,wb_data,return_addr,imm_out,pc_signed_offset,opcode_out_d);
input logic [31:0]mem_out,alu_out,return_addr,imm_out,pc_signed_offset;
output logic [31:0]wb_data;
input logic [1:0]memtoreg;
input logic [6:0]opcode_out_d;
wire [1:0]U_control;
wire [31:0] out;
mux31 mux_wb (.a(alu_out),.b(mem_out),.c(out),.cntrl(memtoreg),.out(wb_data));
control_gen U_cntrl (.opcode_out_d(opcode_out_d),.U_control(U_control));
mux31 U_mux (.a(return_addr),.b(imm_out),.c(pc_signed_offset),.cntrl(U_control),.out(out));
endmodule



