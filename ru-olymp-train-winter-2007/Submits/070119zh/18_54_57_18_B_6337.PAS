uses
 math;
var
 x:array[0..10,0..10,0..100]of longint;
 cc:array[0..100,0..100]of longint;
 ans,kk,d,m,n,k,l,ii,jj,i,j,c,a,b:longint;
begin
 assign(input,'rooks.in');
 assign(output,'rooks.out');
 reset(input);
 rewrite(output);
 read(m,n,k,l);
 for i:=0 to 100 do
  begin
  cc[i,i]:=1;
  cc[i,0]:=1;
  end;
 for i:=2 to 100 do
  for j:=1 to i-1 do
   cc[i,j]:=(cc[i-1,j-1]+cc[i-1,j]) mod 10000;
 fillchar(x,sizeof(x),0);
 d:=max(k,l);
 x[0,0,0]:=1;
 for a:=1 to 10 do
  begin
  for b:=1 to 10 do
   for kk:=max(a,b) to a*b do
    for i:=1 to a do
     for c:=0 to i do
      x[a,b,kk]:=(x[a,b,kk]+x[a-c,b-1,kk-i]*cc[a,c]*cc[a-c,i-c]) mod 10000;
  end;
// writeln(x[2,2,3]);
// writeln(x[2,3,3]);
// writeln(x[2,3,4]);
 ans:=0;
 for a:=1 to n do
  for b:=1 to m do
   ans:=(ans+cc[(n-a)*(m-b),l]*x[a,b,k]*cc[n,a]*cc[m,b]) mod 10000;
 writeln(ans);
 close(input);
 close(output);
end.
