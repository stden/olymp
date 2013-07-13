var
 s:extended;
 n,p,x,y,x1,x2,i:longint;
 h:array[1..100000]of int64;
 ch:char;
begin
 assign(input,'geology.in');
 assign(output,'geology.out');
 reset(input);
 rewrite(output);
 readln(n);
 for i:=1 to 100000 do
  h[i]:=0;
 for i:=1 to n do
  begin
  read(ch);
  if ch='A' then
   begin
   readln(ch,ch,x,p);
   h[x]:=h[x]+p;
   for y:=1 to p-1 do
    begin
    if x-y>0 then
     h[x-y]:=h[x-y]+p-y;
    if x+y<=100000 then
     h[x+y]:=h[x+y]+p-y;
    end;
   end
  else
   begin
   readln(ch,ch,ch,ch,x1,x2);
   if x2<x1 then
    begin
    x:=x1;x1:=x2;x2:=x;
    end;
   s:=0;
   for x:=x1 to x2-1 do
    s:=s+(h[x]+h[x+1])/2;
   writeln(s:0:3);
   end;
  end;
 close(input);
 close(output);
end.
