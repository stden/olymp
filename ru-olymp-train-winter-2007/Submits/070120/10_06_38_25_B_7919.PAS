program sh;
const tn='maxsum';
var a,b,c:array[1..20,1..20]of int64;
    t,n,m,i,f1,f2,j,l:longint;
    res,k,dvi:int64;
    d:array[1..20]of longint;
    was:boolean;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n,m,k);
 for i:=1 to n do read(d[i]);
 for i:=1 to m do
 begin
  read(f1,f2);
  a[f1,f2]:=d[f2];
 end;
 dvi:=1;
 for t:=1 to 60 do dvi:=dvi*2;
 for t:=60 downto 0 do
 begin
  if was then
  begin
   fillchar(c,sizeof(c),0);
   for i:=1 to n do
    for j:=1 to n do
     for l:=1 to n do
      if ((i=l)or(b[i,l]<>0))and((l=j)or(b[l,j]<>0)) then
      if c[i,j]<b[i,l]+b[l,j] then c[i,j]:=b[i,l]+b[l,j];
   b:=c;
  end;

  if k and dvi<>0 then
  begin
   was:=true;
   fillchar(c,sizeof(c),0);
   for i:=1 to n do
    for j:=1 to n do
     for l:=1 to n do
      if ((i=l)or(b[i,l]<>0))and((l=j)or(a[l,j]<>0)) then
      if c[i,j]<b[i,l]+a[l,j] then c[i,j]:=b[i,l]+a[l,j];
   b:=c;
  end;
  dvi:=dvi div 2;
 end;
 res:=0;
 for i:=1 to n do
 begin
  if b[1,i]>res then res:=b[1,i];
 end;
 res:=res+d[1];
 writeln(res);
 close(input);close(output);
end.
