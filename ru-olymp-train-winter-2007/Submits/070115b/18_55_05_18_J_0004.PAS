{$r+,s+,q+}
{$M 16000000}
type
 plist=^tlist;
 tlist=record
       n,v:longint;
       next:plist;
       end;
var
 par,d,heap:array[1..30000]of longint;
 imin,nh,n,m,i,j,x,y,z:longint;
 tab:array[1..30000]of plist;
 p:plist;

procedure add(x,y,z:longint);
var
 p:plist;
begin
 p:=new(plist);
 p^.n:=y;
 p^.v:=z;
 p^.next:=tab[x];
 tab[x]:=p;
end;

function siftup(i:longint):longint;
var
 t:longint;
begin
 while i>1 do
  begin
  if d[heap[i div 2]]>d[heap[i]] then
   begin
   par[heap[i]]:=i div 2; par[heap[i div 2]]:=i;
   t:=heap[i div 2]; heap[i div 2]:=heap[i]; heap[i]:=t;
   i:=i div 2;
   end
  else
   begin
   siftup:=i;
   exit;
   end;
  end;
end;

procedure siftdown(i:longint);
var
 j,t:longint;
begin
 while 2*i<=nh do
  begin
  j:=i;
  if d[heap[2*i]]<d[heap[i]] then
   j:=2*i;
  if (2*i+1<=nh)and(d[heap[2*i+1]]<d[heap[i]]) then
   j:=2*i+1;
  if j=i then
   exit;
  par[heap[i]]:=j; par[heap[j]]:=i;
  t:=heap[i]; heap[i]:=heap[j]; heap[j]:=t;
  i:=j;
  end;
end;

function extractmin:longint;
begin
 extractmin:=heap[1];
 heap[1]:=heap[nh];
 nh:=nh-1;
end;

begin
 assign(input,'path.in');
 assign(output,'path.out');
 reset(input);
 rewrite(output);
 read(n,m);
 for i:=1 to m do
  begin
  read(x,y,z);
  add(x,y,z);
  add(y,x,z);
  end;
 nh:=n;
 for i:=1 to n do
  begin
  heap[i]:=i;
  d[i]:=1000000000;
  par[i]:=i;
  end;
 d[1]:=0;
 while (nh<>0) do
  begin
  imin:=extractmin;
  p:=tab[imin];
  while p<>nil do
   begin
   if d[p^.n] > d[imin] + p^.v then
    begin
    d[p^.n] := d[imin] + p^.v;
    siftdown(siftup(par[p^.n]));
    end;
   p:=p^.next;
   end;
  end;
 for i:=1 to n do
  write(d[i],' ');
 close(input);       
 close(output);
end.