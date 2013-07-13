type
 plist=^tlist;
 tlist=record
       n,v:longint;
       next:plist;
       end;
var
 tab:array[1..30000]of plist;
 d:array[1..30000]of longint;
 q:array[1..30000]of boolean;
 inf,imin,x,y,v,i,n,m,j:longint;
 p:plist;

procedure add(x,y,v:longint);
var
 p:plist;
begin
 p:=new(plist);
 p^.next:=tab[x];
 p^.n:=y;
 p^.v:=v;
 tab[x]:=p;
end;

begin
 inf:=2000000000;
 assign(input,'path.in');
 assign(output,'path.out');
 reset(input);
 rewrite(output);
 read(n,m);
 for i:=1 to m do
  begin
  read(x,y,v);
  add(x,y,v);
  add(y,x,v);
  end;
 for i:=1 to n do
  begin
  q[i]:=false;
  d[i]:=Inf;
  end;
 d[1]:=0;
 for i:=1 to n do
  begin
  imin:=1;
  while q[imin] do
   imin:=imin+1;
  for j:=imin to n do
   if (not(q[j]))and(d[j]<d[imin]) then
    imin:=j;
  q[imin]:=true;
  p:=tab[imin];
  while p<>nil do
   begin
   if (d[p^.n]>d[imin]+p^.v) then
    d[p^.n]:=d[imin]+p^.v;
   p:=p^.next;
   end;
  end;
 for i:=1 to n do
  write(d[i],' ');
 close(input);
 close(output);
end.