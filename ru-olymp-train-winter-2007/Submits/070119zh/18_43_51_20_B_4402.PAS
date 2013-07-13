uses math;
const hmod=10000;
var cur,ans,m,n,kk,ll,a,b,k,i,j,c:longint;
    pC:array[0..100,0..100]of longint;
    x:array[0..10,0..10,0..100]of longint;

begin
  assign(input,'rooks.in');
  reset(input);
  read(m,n,kk,ll);
  close(input);
  fillchar(x,sizeof(x),0);
  fillchar(pC,sizeof(pC),0);
  pC[0,0]:=1;
  for i:=1 to 100 do
  begin
    pC[i,0]:=1;
    for j:=1 to i do
      pC[i,j]:=(pC[i-1,j]+pC[i-1,j-1]) mod hmod;
  end;
  x[0,0,0]:=1;
  for a:=1 to m do
    for b:=1 to n do
      for k:=1 to kk do
        for i:=1 to k do
          for c:=0 to min(i,a) do
            x[a,b,k]:=(x[a,b,k]+(x[a-c,b-1,k-i]*pC[a,c]*pC[a-c,i-c]) mod hmod) mod hmod;
  ans:=0;
  for i:=1 to m do
    for j:=1 to n do
    begin
      cur:=x[i,j,kk]*pc[(n-j)*(m-i),ll] mod hmod;
      cur:=cur*pc[n,j] mod hmod;
      cur:=cur*pc[m,i] mod hmod;
      ans:=(ans+cur) mod hmod;
    end;
  assign(output,'rooks.out');
  rewrite(output);
  writeln(ans);
  close(output);
end.
