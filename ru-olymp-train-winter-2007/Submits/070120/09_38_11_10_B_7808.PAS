uses math;
type
 integer=longint;

var
 n,m,k,u,v:integer;
 d,d1,c:array[1..20] of integer;
 a:array[1..20,1..20] of integer;
 i,j,l:integer;
 res:integer;

begin
 assign(input,'maxsum.in'); reset(input);
 assign(output,'maxsum.out'); rewrite(output);
 readln(n,m,k);
 for i:=1 to n do
  read(c[i]);


 for i:=1 to m do begin
  readln(u,v);
  a[u,v]:=1;
 end;


 d[1]:=c[1];
 for l:=1 to k do begin
  fillchar(d1,sizeof(d1),0);
  for i:=1 to n do
   for j:=1 to n do
    if a[i,j]=1 then
     d1[j]:=max(d1[j],d[i]+c[j]);
  d:=d1;
 end;

 res:=0;
 for i:=1 to n do
  if d[i]>res then res:=d[i];

 writeln(output,res);

 close(input); close(output);
end.