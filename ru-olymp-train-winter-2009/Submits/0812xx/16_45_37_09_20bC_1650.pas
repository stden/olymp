program divis;
{$MODE DELPHI}
{$APPTYPE CONSOLE}
{$R+,Q+}
uses
  SysUtils,Math;
type integer=longint;
     arr=array[0..10000]of integer;
var s1,s2:string;
    a,b,nw,ans,aa,xx:arr;
    z:array[0..9]of arr;
    i,k,j,line,mx:integer;
    c:array[0..1000,0..1000]of char;
function menshe(a,b:arr):boolean;
var i:integer;
begin
  result:=a[0]<b[0];
  if a[0]>b[0] then exit;
  for i:=a[0] downto 1 do begin
    if a[i]<b[i] then begin
      result:=true;
      exit;
    end;
    if a[i]>b[i] then exit;
  end;
end;
function mensheravn(a,b:arr):boolean;
begin
  result:=not menshe(b, a);
end;
function plus(a,b:arr):arr;
var c:arr;
    i,ost:integer;
begin
  fillchar(c,sizeof(c),0);
  c[0]:=max(a[0],b[0]);
  ost:=0;
  for i:=1 to c[0] do begin
    c[i]:=a[i]+b[i]+ost;
    ost:=c[i] div 10;
    c[i]:=c[i] mod 10;
  end;
  while ost>0 do begin
    inc(c[0]);
    c[c[0]]:=ost mod 10;
    ost:=ost div 10;
  end;
  result:=c;
end;
function minus(a,b:arr):arr;
var c:arr;
    i:integer;
begin
  fillchar(c,sizeof(c),0);
  c[0]:=a[0];
  for i:=1 to c[0] do begin
    c[i]:=a[i]-b[i];
    if c[i]<0 then begin
      dec(a[i+1]);
      inc(c[i],10);
    end;
  end;
  while (c[0]>0)and(c[c[0]]=0) do begin
    dec(c[0]);
  end;
  result:=c;
end;
function shift(a:arr;sh:integer):arr;
var i:integer;
begin
  for i:=a[0] downto 1 do a[i+sh]:=a[i];
  for i:=1 to sh do a[i]:=0;
  a[0]:=a[0]+sh;
  result:=a;
end;
begin
  assign(input,'division.in');
  reset(input);
  assign(output,'division.out');
  rewrite(output);
  readln(s1);
  readln(s2);
  a[0]:=length(s1);
  b[0]:=length(s2);
  for i:=1 to a[0] do a[i]:=ord(s1[a[0]-i+1])-ord('0');
  for i:=1 to b[0] do b[i]:=ord(s2[b[0]-i+1])-ord('0');
  if menshe(a,b) then begin
    writeln(s1,' |',s2);
    for i:=1 to a[0]+1 do write(' ');
    write('+');
    for i:=1 to b[0] do write('-');
    writeln;
    for i:=1 to a[0]+1 do write(' ');
    writeln('|0');
    halt;
  end;
  z[0][0]:=0;
  for i:=1 to 9 do z[i]:=plus(z[i-1],b);
  k:=a[0]-b[0]+1;
  nw:=a;
  ans[0]:=k;
  for i:=1 to 1000 do
    for j:=1 to 1000 do c[i,j]:=' ';
  line:=1;
  for j:=k downto 1 do begin
    aa:=nw;
    if (ans[j+1]<>0)or(j=k) then
    for i:=aa[0] downto 1 do c[line,a[0]-i+1]:=chr(ord('0')+aa[i]);
    for i:=aa[0] downto 1 do c[line+2,a[0]-i+1]:='-';
    for i:=j to aa[0] do
      aa[i-j+1]:=aa[i];
    for i:=max(aa[0]-j+2,1) to aa[0] do aa[i]:=0;
    aa[0]:=aa[0]-j+1;
    ans[j]:=0;
    while (ans[j]<9)and(mensheravn(z[ans[j]+1],aa)) do
      inc(ans[j]);
    xx:=shift(z[ans[j]],j-1);
    nw:=minus(nw,xx);
    if (ans[j]<>0) then begin
      for i:=xx[0] downto 1 do c[line+1,a[0]-i+1]:=chr(ord('0')+xx[i]);
      for i:=j-1 downto 1 do c[line-1,a[0]-i+1]:=' ';
      for i:=1 to j-1 do begin
        if line<>1 then c[line,a[0]-i+1]:=' ';
      end;
    end;
    for i:=1 to j-1 do begin
      c[line+1,a[0]-i+1]:=' ';
    end;
    if ans[j]<>0 then inc(line,3);
  end;
  if ans[ans[0]]=0 then begin
    dec(ans[0]);
  end;
  if nw[0]=0 then inc(nw[0]);
  for i:=1 to nw[0] do c[line,a[0]-i+1]:=chr(ord('0')+nw[i]);
  c[1,a[0]+2]:='|';
  c[2,a[0]+2]:='+';
  c[3,a[0]+2]:='|';
  for i:=1 to b[0] do c[1,a[0]+2+b[0]-i+1]:=chr(ord('0')+b[i]);
  for i:=1 to ans[0] do c[3,a[0]+2+ans[0]-i+1]:=chr(ord('0')+ans[i]);
  for i:=1 to max(ans[0],b[0]) do c[2,a[0]+2+max(ans[0],b[0])-i+1]:='-';
  for i:=1 to line do begin
    mx:=1000;
    for j:=1000 downto 1 do if c[i,j]=' ' then mx:=j else break;
    for j:=1 to mx-1 do write(c[i,j]);
    if mx<>1 then 
    writeln;
  end;
end.
