interface if_alu4(input bit clk);
bit [0:3][5:0]s; bit[1:0]S;
logic [0:3][3:0]a,b;
logic [7:0]d;
logic reset;
modport DUT(input a,b,S,s,clk,reset, output d);
modport TB(input d,output a,b,s,S,clk,reset);
endinterface