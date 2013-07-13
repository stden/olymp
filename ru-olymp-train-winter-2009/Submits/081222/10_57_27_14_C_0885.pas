program Z_C;

{$mode objfpc}{$O-,D+,R+,S+,I+,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math;
type
  Tlong=array[0..601]of longint;
var
  n,k,h:Tlong;
  i,j:longint;
  res:Tlong;
  L1,L2,L3,L0:Tlong;
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
Function Tdiv(const a,b:Tlong):Tlong;
var
  l,r,ans,med:Tlong;
Begin
  fillchar(ans,sizeof(ans),0);
  fillchar(l,sizeof(l),0);
  fillchar(r,sizeof(r),0);
  r[0]:=255;
  r[r[0]]:=1;
  while EQ(l,r)<=0 do begin
    med:=Tdiv(Tsum(l,r));
    if EQ(Tmul(med,b),a)>0 then r:=Tdec(med,L1) else begin
      ans:=med;
      l:=Tsum(med,L1);
    end;
  end;
  result:=ans;
End;
Procedure Twrite(const a:Tlong);
var
  i:longint;
Begin
  write(a[a[0]]);
  for i:=a[0]-1 downto 1 do write(a[i]);
End;
begin
  assign(input,'room.in');
  reset(input);
  assign(output,'room.out');
  rewrite(output);
  L0[1]:=0;
  L0[0]:=0;
  L1[1]:=1;
  L1[0]:=1;
  L2[1]:=2;
  L2[0]:=1;
  L3[1]:=3;
  L3[0]:=1;
  fillchar(h,sizeof(h),0);
  Tread(n);
  if(EQ(n,L1)=0) then begin
    write(1);
    close(output);
    exit;
  end;
  if (EQ(n,L2)=0) then begin
    write(2);
    close(output);
    exit;
  end;
  k:=TDec(Tdiv(n,L3),L1);
  h:=Tmul(Tsum(Tdec(n,TMul(Tdiv(n,L3),L3)),L1),Tdiv(n,L3));
  if (EQ(k,L0)>0) then begin
    k:=Tdiv(TMul(k,TSum(k,L1)),L2);
    k:=TMul(k,L3);
  end else k:=L0;
  res:=Tdec(TMul(L2,TSum(k,h)),Tdiv(n,L3));
  res:=Tsum(res,Tmul(Tdiv(n,L3),L3));
  h:=Tdec(n,TMul(Tdiv(n,L3),L3));
  res:=Tsum(res,h);
  Twrite(res);
  close(input);
  close(output);
end.

