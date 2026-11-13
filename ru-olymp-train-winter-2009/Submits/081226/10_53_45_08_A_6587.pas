{$MODE DELPHI}
var
 x,y:int64;
 a,b,a8:array[0..50000] of int64;
 f:array[0..7,0..200000] of int64;
 sum,l:array[0..50000] of int64;
 i,j,t:integer;

procedure Add(x:integer);
begin
 inc(b[0]);
 b[b[0]]:=x;
end;

procedure Adda8;
var
 i:integer;
begin
 for i:=1 to a8[0] do Add(a8[i]);
end;

function Get(x:int64):int64;
var
 l1,r1,m,r:int64;
begin
 if x=0 then begin
  result:=0;
  exit;
 end;
 l1:=1; r1:=a[0];
 while l1<r1 do begin
  m:=(l1+r1) shr 1;
  if x<=l[m] then r1:=m else l1:=m+1;
 end;
 dec(x,l[l1-1]);
 result:=sum[l1-1]+f[a[l1],x];
end;

var
 s,s2:string;
 n:integer;
begin
 assign(input, 'digitsum.in'); reset(input);
 assign(output, 'digitsum.out'); rewrite(output);
 s:='1';
 fillchar(f, sizeof(f), 0);
 f[0][0]:=2; f[0][1]:=1; f[0][2]:=3;
 for i:=1 to 7 do begin
  n:=length(s);
  s2:='';
  for j:=1 to n do
   if s[j]='1' then s2:=s2+'11212' else s2:=s2+'1121212';
  s:=s2;
  n:=length(s);
  f[i][0]:=n;
  f[i][1]:=1;
  for j:=2 to n do
   if s[j]='1' then f[i][j]:=f[i][j-1]+1 else f[i][j]:=f[i][j-1]+2;
 end;

 fillchar(b, sizeof(b),0);
 Add(1); Add(1); Add(1); Add(0); Add(1); Add(1); Add(0);
 a:=b;
 for i:=3 to 12 do begin
  fillchar(b, sizeof(b), 0);
  for j:=1 to a[0] do begin
   if a[j]=0 then begin
    Add(1); Add(1);  Add(0);
   end else if a[j]+1=8 then Adda8 else Add(a[j]+1);
  end;
  a:=b;
  if i=8 then a8:=a;
 end;
 l[0]:=0;
 sum[0]:=0;
 for i:=1 to a[0] do begin
  l[i]:=l[i-1]+f[a[i],0];
  sum[i]:=sum[i-1]+f[a[i],f[a[i],0]];
 end;
 readln(t);
 for i:=1 to t do begin
  readln(x,y);
  writeln(Get(y)-Get(x-1));
 end;
end.