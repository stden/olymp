{$MODE DELPHI}
{$H-}
uses SysUtils;

type
 TLong=array[0..50000] of integer;

var
 a,b,c:TLong;

function ReadLong:TLong;
var
 a:TLong;
 s:string;
 i:integer;
begin
 fillchar(a, sizeof(a), 0);
 readln(s);
 a[0]:=length(s);
 s:=Trim(s);
 for i:=1 to a[0] do
  a[i]:=ord(s[a[0]-i+1])-ord('0');

 result:=a;
end;

function sr(const a,b:TLong):integer;
var
 i:integer;
begin
 result:=0;
 if a[0]>b[0] then
  result:=1
 else if a[0]<b[0] then
  result:=2
 else begin
  for i:=1 to a[0] do
   if a[i]>b[i] then
    result:=1
   else if a[i]<b[i] then result:=2;
 end;
end;

function sub(const a,b:TLong):TLong;
var
 c:TLong;
 i:integer;
begin
 fillchar(c, sizeof(c), 0);
 c[0]:=1;
 for i:=1 to a[0] do begin
  inc(c[i],a[i]-b[i]);
  if c[i]<0 then begin
   c[i+1]:=-1;
   inc(c[i],10);
  end;
 end;

 for i:=a[0] downto 1 do
  if c[i]<>0 then begin
   c[0]:=i;
   break;
  end;

 result:=c;
end;

procedure WriteLong(const a:TLong);
var
 i:integer;
begin
 for i:=a[0] downto 1 do write(a[i]);
end;

begin
 assign(input, 'aplusminusb.in'); reset(input);
 assign(output, 'aplusminusb.out'); rewrite(output);
 a:=ReadLong;
 b:=ReadLong;

 if sr(a,b)=2 then begin
  write('-');
  c:=sub(b,a);
 end else begin
  c:=sub(a,b);
 end;

 WriteLong(c);
end.
