program Project1;

var
 inp,oup:text;
 o,o2:array[1..1000]of int64;
 i,j,k,n,x,y,c,sch:longint;
 fl,fl2:boolean;

begin
 assign(inp,'marked.in');
 assign(oup,'marked.out');
 reset(inp);
 rewrite(oup);
 read(inp,n,x,y);
 fillchar(o,sizeof(o),0);
 for i:=1 to x do
  begin
   read(inp,k);
   for j:=1 to k do
    begin
     read(inp,c);
     o[i]:=o[i] or (1 shl (c-1));
    end;
  end;
 fillchar(o2,sizeof(o2),0);
 for i:=1 to y do
  begin
   read(inp,k);
   for j:=1 to k do
    begin
     read(inp,c);
     o2[i]:=o2[i] or (1 shl (c-1));
    end;
  end;
 sch:=0;
 for i:=0 to (1 shl(n))-1 do
  begin
   fl:=false;
   for j:=1 to x do
    if (o[j] or i )=o[j] then fl:=true;
   fl2:=false;
   for j:=1 to y do
    if (o2[j] or i) =o2[j] then fl2:=true;
   if (fl) and (not fl2) then inc(sch);
  end;
 writeln(oup,sch);
 close(inp);
 close(oup);

end.

