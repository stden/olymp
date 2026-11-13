program solve;

var
 inp,oup:text;
 a:array[1..10]of longint;
 fact:array[0..18]of int64;
 i,n,c:longint;
 sum:int64;

function
 ccc(n,k:longint):int64;
begin

 ccc:=fact[n]div fact[k] div fact[n-k];
end;

procedure
 go(k,aa,b,m:int64);
var
 i,j:longint;
begin
 if k>10 then
  begin
   if b<>0 then inc(sum,(aa mod b)*m);
   exit;
  end;
 for i:=0 to a[k] do
  for j:=0 to a[k]-i do
   begin
    go(k+1,aa+k*i,b+k*j,m*ccc(a[k],i)*ccc(a[k]-i,j));
   end;
end;

begin
 assign(inp,'modsum3.in');
 assign(oup,'modsum3.out');
 reset(inp);
 rewrite(oup);
 read(inp,n);
 fillchar(a,sizeof(a),0);
 fact[0]:=1;
 fact[1]:=1;
 for i:=2 to 18 do
  fact[i]:=fact[i-1]*i;
 sum:=0;
 for i:=1 to n do
  begin
   read(inp,c);
   inc(a[c]);
  end;
 go(1,0,0,1);
 writeln(oup,sum);
 close(inp);
 close(oup);
end.

