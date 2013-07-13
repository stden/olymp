program Z_C;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math;
type
  Tlong=array[0..300]of longint;
var
  a,b:Tlong;
  l,r,ans:Tlong;
  med,one,help:Tlong;
  i,j,kol:longint;
  start,rk,ostart:longint;
Procedure Tread(var a:Tlong);
var
  s:string;
  i:longint;
Begin
  readln(s);
  a[0]:=length(s);
  for i:=1 to a[0] do a[i]:=ord(s[a[0]-i+1])-ord('0');
  while(a[0]>0)and(a[a[0]]=0) do dec(a[0]);
End;
Function EQ(const a,b:Tlong):longint;
var
  i:longint;
Begin
  result:=0;
  if a[0]>b[0] then result:=1 else
  if a[0]<b[0] then result:=-1 else
  for i:=a[0] downto 1 do
    if a[i]<>b[i] then begin
      if a[i]>b[i] then result:=1;
      if a[i]<b[i] then result:=-1;
      exit;
    end;
End;
Function Tdiv(a:Tlong):Tlong;
var
  i:longint;
Begin
  fillchar(result,sizeof(result),0);
  for i:=a[0] downto 1 do begin
    result[i]:=a[i] div 2;
    if (i>1)and(a[i] mod 2=1) then
      inc(a[i-1],10);
  end;
  result[0]:=a[0];
  while (result[0]>0)and(result[result[0]]=0) do dec(result[0]);
End;
Function Tsum(const a,b:Tlong):Tlong;
var
  i:longint;
Begin
  fillchar(result,sizeof(result),0);
  for i:=1 to max(a[0],b[0]) do result[i]:=a[i]+b[i];
  for i:=1 to max(a[0],b[0]) do if result[i]>9 then begin
    dec(result[i],10);
    inc(result[i+1]);
   end;
   result[0]:=max(a[0],b[0]);
   while (result[result[0]+1]<>0) do inc(result[0]);
End;
Function TMul(const a,b:Tlong):Tlong;
var
  i,j:longint;
Begin
  fillchar(result,sizeof(result),0);
  result[0]:=a[0]+b[0]+1;
  for i:=1 to a[0] do
    for j:=1 to b[0] do
      inc(result[i+j-1],a[i]*b[j]);
  for i:=1 to result[0] do begin
    inc(result[i+1],result[i] div 10);
    result[i]:=result[i] mod 10;
  end;
  while (result[0]>0)and(result[result[0]]=0) do dec(result[0]);
end;
Function Tdec(const a,b:Tlong):Tlong;
var
  i:longint;
Begin
  fillchar(result,sizeof(result),0);
  for i:=1 to a[0] do result[i]:=a[i]-b[i];
  for i:=1 to a[0] do if result[i]<0 then begin
    inc(result[i],10);
    dec(result[i+1]);
   end;
   result[0]:=a[0];
   while (result[0]>0)and(result[result[0]]=0) do dec(result[0]);
End;
Procedure Twrite(const a:Tlong);
var
  i:longint;
Begin
  write(a[a[0]]);
  for i:=a[0]-1 downto 1 do write(a[i]);
End;
begin
  assign(input,'division.in');
  reset(input);
  assign(output,'division.out');
  rewrite(output);
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
  Tread(a);
  Tread(b);
  l[0]:=0;
  r[0]:=101;
  r[r[0]]:=1;
  one[1]:=1;
  one[0]:=1;
  while EQ(l,r)<=0 do begin
    med:=Tdiv(Tsum(l,r));
    if EQ(Tmul(med,b),a)>0 then r:=Tdec(med,one) else begin
      ans:=med;
      l:=Tsum(med,one);
    end;
  end;
  Twrite(a);
  write(' |');
  Twrite(b);
  writeln('');
  if a[0]=0 then a[0]:=1;
  kol:=0;
  start:=0;
  if ans[0]>0 then begin
  for i:=ans[0] downto 1 do if ans[i]>0 then begin
    inc(kol);
    one[1]:=ans[i];
    med:=Tmul(b,one);
    if (kol=1)and(a[a[0]]<med[med[0]]) then inc(start);
    for j:=1 to start do write(' ');
    Twrite(med);
    for j:=start+med[0]+1 to a[0]+1 do write(' ');
    if kol=1 then begin
      write('+');
      for j:=1 to max(b[0],ans[0]) do write('-');
    end;
    writeln('');
    if (kol=1)and(a[a[0]]<med[med[0]]) then dec(start);
    med:=ans;
    rk:=-1;
    for j:=i-1 downto 1 do if ans[j]>0 then begin
      one[1]:=ans[j];
      rk:=TMul(b,one)[0];
      break;
    end;
    ostart:=start;
    if rk<>-1 then begin
      for j:=i-1 downto 1 do med[j]:=0;
      med:=Tdec(a,Tmul(med,b));
      start:=a[0]-med[0];
    end;

    if rk<>-1 then begin
    for j:=1 to ostart do write(' ');
    for j:=ostart+1 to start+rk do write('-');
    for j:=start+rk+1 to a[0]+1 do write(' ');
    end else begin
      for j:=1 to ostart do write(' ');
      for j:=ostart+1 to a[0] do write('-');
      write(' ');
    end;
    if kol=1 then begin
      write('|');
      Twrite(ans);
    end;
    writeln('');
    if (rk<>-1) then begin
      for j:=1 to start do write(' ');
      write(med[med[0]]);
      for j:=med[0]-1 downto med[0]-rk+1 do write(med[j]);
      writeln('');
    end;
  end;
  med:=Tdec(a,Tmul(ans,b));
  if med[0]=0 then med[0]:=1;
  for i:=1 to a[0]-med[0] do write(' ');
  Twrite(med);
  write(' ');
  end else begin
    for i:=1 to a[0]+1 do write(' ');
    write('+');
    for i:=1 to b[0] do write('-');
    writeln('');
    for i:=1 to a[0]+1 do write(' ');
    write('|');
    write('0');
    for i:=2 to b[0] do write(' ');
  end;
  close(input);
  close(output);
end.

