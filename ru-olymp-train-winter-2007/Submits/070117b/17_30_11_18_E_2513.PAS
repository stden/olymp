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
 for i:=2 to 10000 do
  mas[i]:=true;
 mas[1]:=true;
 for i:=1 to length(s) do
  begin
  for j:=1 to length(p) do
   mas1[j]:=false;
  for j:=1 to length(p) do
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
  mas:=mas1;
  end;
 if mas[length(p)+1] then
  writeln('YES')
 else
  writeln('NO');
 close(input);
 close(output);
end.
