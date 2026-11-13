{$H+}
var
 mas,mas1:array[1..10010]of boolean;
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
 i:=1;
 while (i<length(p))and(p[i]='*') do
  i:=i+1;
 for j:=1 to i do
  mas[j]:=true;
 for i:=1 to length(s) do
  begin
  for j:=1 to length(p) do
   mas1[j]:=false;
  for j:=1 to length(p) do
   begin
   if mas[j] then
    begin
    if (p[j]='*') then
     begin
     mas1[j]:=true;
     mas1[j+1]:=true;
     continue;
     end;
    if p[j]='?' then
     begin
     mas1[j+1]:=true;
     continue;
     end;
    if p[j]=s[i] then
     mas1[j+1]:=true;
    end;
   end;
  mas:=mas1;
  end;
 i:=length(p)+1;
 while (i>1)and(not(mas[i])and(p[i-1]='*')) do
  i:=i-1;
 if mas[i] then
  writeln('YES')
 else
  writeln('NO');
 close(input);
 close(output);
end.
