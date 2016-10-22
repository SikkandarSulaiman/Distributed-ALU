`include "if_alu.sv"
`include "alu.v"
`include "tb_alu.sv"
module top_alu4;
  bit clk;
  always #5clk=~clk;
  if_alu4 i(clk);
  alu4 dut(.a(i.a),.b(i.b),.S(i.S),.s(i.s),.d(i.d),.reset(i.reset),.clk(i.clk));
  tb_alu4 tb(i,i);
endmodule