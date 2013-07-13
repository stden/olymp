//{$H+}
var
 mas,mas1:array[0..10010]of boolean;
 p,s:string;
 i,j:longint;
begin
 assign(input,'patterns.in');
 assign(output,'patterns.out');
 reset(input);
 rewrite(output);
 readln(p);
 readln(s);
 for i:=2 to 10010 do
  mas[i]:=false;
 i:=0;
 while (i<length(p))and(p[i+1]='*')do
  i:=i+1;
 for j:=0 to i do
  mas[j]:=true;
 for i:=1 to length(s) do
  begin
  for j:=0 to length(p) do
   mas1[j]:=false;
  for j:=0 to length(p) do
   if mas[j] then
    begin
    if (j>0) and (p[j]='*') then
     mas1[j]:=true;
    if (j<length(p))and(p[j+1]='?')or(p[j+1]='*') then
     mas1[j+1]:=true;
    if (j<length(p))and(p[j+1]=s[i]) then
     mas1[j+1]:=true;
    end;
  mas:=mas1;
  end;
 i:=length(p);
 while (not(mas[i]))and(i>0)and(p[i]='*') do
  i:=i-1;
 if mas[i] then
  writeln('YES')
 else
  writeln('NO');
 close(input);
 close(output);
end.
