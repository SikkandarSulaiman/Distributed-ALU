program tb_alu4(if_alu4.DUT dut,if_alu4.TB tb);
  class random;
    rand logic [0:3][3:0]a,b;
    constraint c1{a>=0;a<=15;}
    constraint c2{b>=0;b<=3;}
    rand bit [0:3][5:0]s;
    constraint c3{s>=0;s<=63;}
    rand bit [1:0]S;
    constraint c4{S>=0;S<=3;}
  endclass
  covergroup cg @(posedge top_alu4.clk);
  coverpoint tb.a[0]{bins b2={[0:15]};} coverpoint tb.a[1]{bins b21={[0:15]};} coverpoint tb.a[2]{bins b22={[0:15]};} coverpoint tb.a[3]{bins b23={[0:15]};}
  coverpoint tb.b[0]{bins b3={0,1,2,3};} coverpoint tb.b[1]{bins b31={0,1,2,3};} coverpoint tb.b[2]{bins b32={0,1,2,3};} coverpoint tb.b[3]{bins b33={0,1,2,3};}
  coverpoint tb.s[0]{bins b4={[0:63]};} coverpoint tb.s[0]{bins b41={[0:63]};} coverpoint tb.s[2]{bins b42={[0:63]};} coverpoint tb.s[3]{bins b43={[0:63]};}
  coverpoint tb.S{bins b1=(1[*3]=>3=>1=>0=>2=>1=>0);}
  endgroup
  sequence sq;
    @(posedge top_alu4.clk) !(tb.a&&tb.b);
  endsequence
  property p1;
    @(posedge top_alu4.clk) sq;
  endproperty
  assert property(p1)
  $info($time," PASS");
else
  $error($time," FAIL");
  sequence sq1;
    @(top_alu4.clk) (tb.a&&tb.b);
  endsequence
  property p11;
    @(top_alu4.clk) sq1;
  endproperty
  assert property(p11)
  $info($time," PASS");
else
  $error($time," FAIL");
  cg CG=new();
  initial
  begin
  random obj1=new(); random obj2=new();
  random obj3=new(); random obj4=new();
  repeat(10)
  begin
    tb.reset=1;
    void' (obj1.randomize());    void' (obj2.randomize()); 
    void' (obj3.randomize());    void' (obj4.randomize());
    #10
    tb.a[0]=obj1.a; tb.b[0]=obj1.b; tb.s[0]=obj1.s; tb.S=obj1.S;
    tb.a[1]=obj2.a; tb.b[1]=obj2.b; tb.s[1]=obj2.s; tb.S=obj2.S;
    tb.a[2]=obj3.a; tb.b[2]=obj3.b; tb.s[2]=obj3.s; tb.S=obj3.S;
    tb.a[3]=obj4.a; tb.b[3]=obj4.b; tb.s[3]=obj4.s; tb.S=obj4.S;
   /* $display("RANDOM  a=%d, b=%d, AU=%d, LU=%d, OPREATION=%d, ALU=%d",tb.a[0],tb.b[0],{tb.s[0][0],tb.s[0][1]},{tb.s[0][2],tb.s[0][3],tb.s[0][4]},tb.s[0][5],obj1.S);
    $display("RANDOM  a=%d, b=%d, AU=%d, LU=%d, OPERATION=%d, ALU=%d",tb.a[1],tb.b[1],{tb.s[1][0],tb.s[1][1]},{tb.s[1][2],tb.s[1][3],tb.s[1][4]},tb.s[1][5],obj2.S);
    $display("RANDOM  a=%d, b=%d, AU=%d, LU=%d, OPERATION=%d, ALU=%d",tb.a[2],tb.b[2],{tb.s[2][0],tb.s[2][1]},{tb.s[2][2],tb.s[2][3],tb.s[2][4]},tb.s[2][5],obj3.S);
    $display("RANDOM  a=%d, b=%d, AU=%d, LU=%d, OPERATION=%d, ALU=%d",tb.a[3],tb.b[3],{tb.s[3][0],tb.s[3][1]},{tb.s[3][2],tb.s[3][3],tb.s[3][4]},tb.s[3][5],obj4.S);
   */ CG.sample();
  end
  $stop;
  end
endprogram