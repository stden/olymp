{$MODE DELPHI}
uses Math, SysUtils;
const base=10000;
type
 TLong = array[0..50] of integer;

var
 One,Null:TLong;

function Mul(const A,B:TLong):TLong;
var
 i,j:integer;
 c:TLong;
begin
 fillchar(C, sizeof(C), 0);
 for i:=1 to a[0] do
  for j:=1 to b[0] do begin
   inc(c[i+j-1],a[i]*b[j]);
   inc(c[i+j], c[i+j-1] div base);
   c[i+j-1]:=c[i+j-1] mod base;
  end;

 c[0]:=a[0]+b[0];
 while (c[c[0]]=0) and (c[0]>1) do dec(c[0]);
 result:=c;
end;

function Sum(const A,B:TLong):TLong;
var
 C:TLong;
 m,i:integer;
begin
 fillchar(c, sizeof(c), 0);
 m:=max(a[0], b[0]);
 for i:=1 to m do begin
  c[i]:=c[i]+a[i]+b[i];
  if c[i]>=base then begin
   dec(c[i], base);
   inc(c[i+1]);
  end;
 end;
 if c[m+1]>0 then c[0]:=m+1 else c[0]:=m;
 result:=c;
end;

procedure WriteLong(const A:TLong);
var
 i:integer;
 s:string;
begin
 write(a[a[0]]);
 for i:=a[0]-1 downto 1 do begin
  s:=inttostr(a[i]);
  while length(s)<4 do s:='0'+s;
  write(s);
 end;
end;

var
 n,t:integer;
 d:array[0..500,0..250] of TLong;
 f:array[0..500,0..500] of TLong;



procedure Init;
var
 i,j:integer;
begin
 for i:=0 to 500 do
  for j:=0 to 250 do d[i,j][0]:=-1;
 for i:=1 to 250 do
  d[0,i]:=Null;
 d[0,0]:=One;

 for i:=0 to 500 do
  for j:=0 to 500 do f[i,j][0]:=-1;
 for i:=1 to 500 do
  f[0,i]:=Null;
 f[0,0]:=One;
end;

function Calc(n,m:integer):TLong;
var
 i,p:integer;
 r:TLong;
begin
 if d[n,m][0]<>-1 then begin
  result:=d[n,m];
  exit;
 end;
 r:=Null;
 p:=min(m, 2*t);
 for i:=t to p do begin
  r:=Sum(r,Calc(n-1, m-i));
 end;
 result:=r;
 d[n,m]:=r;
end;

function Calc2(n,m:integer):TLong;
var
 i,p:integer;
 r:TLong;
begin
 if f[n,m][0]<>-1 then begin
  result:=f[n,m];
  exit;
 end;
 r:=Null;
 p:=min(m, 2*t-1);
 for i:=t-1 to p do begin
  r:=Sum(r,Calc2(n-1, m-i));
 end;
 result:=r;
 f[n,m]:=r;
end;


var
 i,j,k:integer;
 a:array[1..500] of TLong;
 g:TLong;

begin
 assign(input, 'btrees.in'); reset(input);
 assign(output, 'btrees.out'); rewrite(output);
 readln(n,t);
// n:=500; t:=2;
 One[0]:=1; One[1]:=1;
 Null[0]:=1; Null[1]:=0;

 Init;


 g:=Null;
 for i:=n downto 1 do begin
  for j:=1 to 500 do a[j]:=Null;
  a[i]:=One;

  for j:=i downto 1 do
   for k:=j div 2 downto 1 do
      a[k]:=Sum(a[k], Mul(a[j],Calc(k,j)));
  g:=Sum(g,Mul(a[1],Calc2(i,n)));
 end;
 WriteLong(g);
end.