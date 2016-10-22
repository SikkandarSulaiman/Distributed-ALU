module au(a,b,s,x);
  input [3:0]a,b;
  input [1:0]s;
  output reg [7:0]x;
  always@(a,b,s)
  case (s)
    0:x=a*b;
    1:x=a/b;
    2:x=a+b;
    3:x=a-b;
  endcase
endmodule



module lu(a,b,s,y);
  input [3:0]a,b;
  input [2:0]s;
  output reg [7:0]y;
  always@(a,b,s)
  case (s)
    0:y=a&b;
    1:y=a|b;
    2:y=a^b;
    3:y=a~^b;
    4:y=~a;
    5:y=~b;
    6:y=~(a&b);
    7:y=~(a|b);
  endcase
endmodule



module m2to1(a,b,s,o);
  input [7:0]a,b;
  input s;
  output reg [7:0]o;
  always@(a,b,s)
  o=(s==0)?a:b;
endmodule



module pipo(i,o,clk,r);
  input clk,r;
  input [7:0]i;
  output reg [7:0]o;
  always@(posedge clk,posedge r)
  o=(r==1)?i:0;
endmodule



module alu(a,b,s,clk,reset,d);
  input [3:0]a,b;
  input [5:0]s;
  input clk,reset;
  output [7:0]d;
  wire [7:0]d1,d2,d3;
  au au1(a,b,{s[0],s[1]},d1);
  lu lu1(a,b,{s[2],s[3],s[4]},d2);
  m2to1 m(d1,d2,s[5],d3);
  pipo p4(d3,d,clk,reset);
endmodule



module alu4(a,b,clk,reset,s,S,d);
  input [0:3][3:0]a;
  input [0:3][3:0]b;
  input clk,reset;
  input [0:3][5:0]s;
  input [1:0]S;
  output [7:0]d;
  wire [7:0]d1,d2,d3,d4,o1,o2;
  alu alu1(a[0],b[0],s[0],clk,reset,d1);
  alu alu2(a[1],b[1],s[1],clk,reset,d2);
  alu alu3(a[2],b[2],s[2],clk,reset,d3);
  alu alu4(a[3],b[3],s[3],clk,reset,d4);
  m2to1 m1(d1,d2,S[1],o1);
  m2to1 m2(d3,d4,S[1],o2);
  m2to1 m3(o1,o2,S[0],d);
endmodule



module memory(in1,in2,op,d,clk,clr,out);
  input [3:0]in1,in2;
  input [5:0]op;
  input [7:0]d;
  input clk,clr;
  reg [9:0][3:0][7:0]mem;
  output reg [9:0][3:0][7:0]out;
  int p,i,j,k; 
  initial p=0;
  always@(posedge clk)
  begin
    mem[p][0]=in1;
    mem[p][1]=in2;
    mem[p][2]=op;
    mem[p][3]=d;
    p=p+1;
    if(clr)
      for(i=0;i<=3;i=i+1)
      for(j=0;j<=7;j=j+1)
      for(k=0;k<=9;k=k+1)
      mem[k][i][j]=0;
    else
      out=mem;
    end
endmodule