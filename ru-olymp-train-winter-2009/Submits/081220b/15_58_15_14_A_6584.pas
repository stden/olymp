program Template;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes;
type
  Tlong=array[0..10005]of longint;
var
  a,b,c:Tlong;
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
Function Tdec(const a,b:Tlong):Tlong;
var
  i:longint;
Begin
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
  assign(input,'aplusminusb.in');
  reset(input);
  assign(output,'aplusminusb.out');
  rewrite(output);
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
  Tread(a);
  Tread(b);
  if EQ(a,b)<0 then begin
    write('-');
    c:=a;
    a:=b;
    b:=c;
   end;
  Twrite(Tdec(a,b));
  close(input);
  close(output);
end.

