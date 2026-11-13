var
 s:string;
 n:longint;

function MyIntToStr(n : longint):string;
var
 s:string;
begin
 s:='';
 while n<>0 do
  begin
  s:=chr(n mod 10+ord('0'))+s;
  n:=n div 10;
  end;
 MyIntToStr:=s;
end;

function MyStrToInt(s:string):longint;
var
 i,n:longint;
begin
 n:=0;
 for i:=1 to length(s) do
  begin
  n:=n*10+ord(s[i])-ord('0');
  end;
 MyStrToInt:=n;
end;

function solve(l,r:longint):boolean;
var
 i:longint;
begin
 if r-l<0 then
  begin
  solve:=true;
  exit;
  end;
 if r-l=0 then
  begin
  if s[l] in ['2','4','6','8','0'] then
   solve:=true
  else
   solve:=false;
  exit;
  end;
 if ((r-l)=1) then
  begin
  if (s[l]>'1') then
   begin
   if (s[r]<>s[l]) then
    solve:=false
   else
    solve:=true;
   end
  else
   if s[r] in ['2','4','6','8','0','1'] then
    solve:=true
   else
    solve:=false;
  exit;
  end;
 if s[l]<>'1' then
  begin
  if s[r]>s[l] then
   begin
   solve := false;
   exit;
   end;
  s[l]:=chr(ord(s[l])-ord(s[r])+ord('0'));
  solve:=solve(l,r-1);
  end
 else
  begin
  if (s[r]>s[l+1]) then
   begin
   solve:=false;
   exit;
   end;
  s[l+1]:=chr(ord(s[l+1])-ord(s[r])+ord('0'));
  if s[r-1]<>'0' then
   s[r-1]:=chr(ord(s[r-1])-ord(s[l])+ord('0'))
  else
   begin
   i:=r-1;
   while s[i]='0' do
    begin
    s[i]:='9';
    i:=i-1;
    end;
   s[i]:=chr(ord(s[i])-1);
   end;
  if s[l+1]='0' then
   solve:=solve(l+2,r-1)
  else
   solve:=solve(l+1,r-1);
  end;
end;

begin
 assign(input,'reverse.in');
 assign(output,'reverse.out');
 reset(input);
 rewrite(output);
 while true do
  begin
  readln(s);
  if s='0' then
   begin
   close(input);
   close(output);
   halt;
   end;
  n:=length(s);
  if solve(1,n) then
   writeln('YES')
  else
   writeln('NO');
  end;
end.
