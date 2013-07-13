type
 theap=record
       x,n:longint;
       end;
 plist=^tlist;
 tlist=record
       n:longint;
       next:plist;
       end;
var
 p:plist;
 nh,i,n,j,x:longint;
 pos,k,next:array[1..200000]of longint;
 tab:array[1..200000]of plist;
 h:array[1..200000]of theap;

procedure siftdown(i:longint);
var
 j:longint;
 t:theap;
begin
 while 2*i<=nh do
  begin
  j:=i;
  if h[i].x>h[2*i].x then
   j:=2*i;
  if (2*i+1<=nh)and(h[i].x>h[2*i+1].x) then
   j:=2*i+1;
  if i=j then
   break;
  pos[h[i].n]:=j;
  pos[h[j].n]:=i;
  t:=h[i];h[i]:=h[j];h[j]:=t;
  i:=j;
  end;
end;

procedure siftup(i:longint);
var
 t:theap;
begin
 while i>1 do
  begin
  if h[i].x<h[i div 2].x then
   begin
   pos[h[i].n]:=i div 2;
   pos[h[i div 2].n]:=i;
   t:=h[i];h[i]:=h[i div 2];h[i div 2]:=t;
   i:=i div 2;
   end
  else
   break;
  end;
end;

procedure addh(i,x:longint);
begin
 nh:=nh+1;
 h[nh].x:=x;
 h[nh].n:=i;
 pos[i]:=nh;
 siftup(nh);
end;

function extractmin(var x:longint):longint;
begin
 pos[h[nh].n]:=1;
 x:=h[1].x;
 extractmin:=h[1].n;
 h[1]:=h[nh];
 nh:=nh-1;
 siftdown(1);
end;

procedure add(i,j:longint);
var
 p:plist;
begin
 p:=new(plist);
 p^.next:=tab[i];
 tab[i]:=p;
 p^.n:=j;
end;

procedure err;
begin
 writeln('NO');
 close(input);
 close(output);
 halt;
end;

begin
 assign(input,'omax.in');
 assign(output,'omax.out');
 reset(input);
 rewrite(output);
 read(n);
 for i:=1 to 2*n do
  begin
  k[i]:=0;
  tab[i]:=nil;
  next[i]:=-1;
  end;
 for i:=1 to n do
  begin
  read(k[i]);
  for j:=1 to k[i] do
   begin
   read(x);
   add(i,n+x);
   add(n+x,i);
   k[n+x]:=k[n+x]+1;
   end;
  end;
 for i:=1 to 2*n do
  begin
  addh(i,k[i]);
  end;
 for i:=1 to 2*n do
  begin
  j:=extractmin(x);
  if (x<>1) then
   if next[j]=-1 then
    err;
  if next[j]<>-1 then
   begin
   p:=tab[j];
   while p<>nil do
    begin
    if next[p^.n]=-1 then
     begin
     h[pos[p^.n]].x:=h[pos[p^.n]].x-1;
     siftup(pos[p^.n]);
     end;
    p:=p^.next;
    end;
   end
  else
   begin
   p:=tab[j];
   while p<>nil do
    begin
    if next[p^.n]=-1 then
     begin
     next[j]:=p^.n;
     next[p^.n]:=j;
     h[pos[p^.n]].x:=h[pos[p^.n]].x-1;
     siftup(pos[p^.n]);
     end;
    p:=p^.next;
    end;
   if next[j]=-1 then
    err;
   end;
  end;
 writeln('YES');
 for i:=1 to n do
  write(next[i]-n,' ');
 close(input);
 close(output);
end.
