uses math;

type
 integer=longint;
 Matrix=array[1..20,1..20] of integer;

var
 n,m,k,u,v:integer;
 d,d1,c:array[1..20] of integer;
 r,a,p:Matrix;
 i,j,l:integer;
 res:integer;
 b,b2:boolean;


function MatrixMulty(a,b:Matrix):Matrix;
var
 c:matrix;
 i,j,k:integer;
begin
 fillchar(c,sizeof(c),0);
 for i:=1 to n do
  for j:=1 to n do
   for k:=1 to n do
    if (a[i,k]<>0) and (b[k,j]<>0) then
     c[i,j]:=max(c[i,j],a[i,k]+b[k,j]);
 MatrixMulty:=c;
end;


begin
 assign(input,'maxsum.in'); reset(input);
 assign(output,'maxsum.out'); rewrite(output);
 readln(n,m,k);
 for i:=1 to n do
  read(c[i]);

{
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
  if d[i]>res then res:=d[i];}


 for i:=1 to m do begin
  readln(u,v);
  a[u,v]:=c[v];
 end;

 b:=true;
 b2:=true;
 while k<>0 do begin
  if b then begin
   p:=a;
   b:=false
  end else p:=MatrixMulty(p,p);
  if k mod 2 = 1 then
   if b2 then begin
    b2:=false;
    r:=p;
   end else
    r:=MatrixMulty(r,p);
  k:=k div 2;
 end;


 for i:=1 to n do
  if res<r[1,i] then res:=r[1,i];
 writeln(output,c[1]+res);

 close(input); close(output);
end.
