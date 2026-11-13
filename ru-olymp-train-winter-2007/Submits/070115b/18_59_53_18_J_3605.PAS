{$M 16000000}
{$r+,s+,q+}
type
 plist=^tlist;
 tlist=record
       n,v:longint;
       next:plist;
       end;
 theap=record
       x,n:longint;
       end;
var
 tab:array[1..30000]of plist;
 ans,d:array[1..30000]of longint;
 h,hh:array[1..30000]of longint;
 q:array[1..30000]of boolean;
 minn,nn,inf,imin,x,y,v,i,n,m,j:longint;
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

procedure siftdown(i:longint);
var
 t:longint;
begin
 while 2*i<=nn do
  begin
  j:=i;
  if h[2*i]<h[i] then
   j:=2*i;
  if ((2*i+1)<=nn) and (h[2*i+1]<h[i]) then
   j:=2*i+1;
  if i=j then
   exit;
  d[hh[i]]:=j; d[hh[j]]:=i;
  t:=h[i]; h[i]:=h[j]; h[j]:=t;
  t:=hh[i]; hh[i]:=hh[j]; hh[j]:=t;
  i:=j;
  end;
end;

procedure siftup(i:longint);
var
 t:longint;
begin
 while (i>1)and(h[i div 2]>h[i]) do
  begin
  d[hh[i]]:=i div 2; d[hh[i div 2]]:=i;
  t:=h[i]; h[i]:=h[i div 2]; h[i div 2]:=t;
  t:=hh[i]; hh[i]:=hh[i div 2]; hh[i div 2]:=t;
  i:=i div 2;
  end;
end;

procedure hadd(x,a:longint);
begin
 nn:=nn+1;
 d[a]:=nn;
 h[nn]:=x;
 hh[nn]:=a;
 siftup(nn);
end;

function extractmin(var a:longint):longint;
begin
 extractmin:=h[1];
 a:=hh[1];
 h[1]:=h[nn];
 hh[1]:=hh[nn];
 nn:=nn-1;
 siftdown(1);
end;

begin
 inf:=500000000;
 assign(input,'path.in');
 assign(output,'path.out');
 reset(input);
 rewrite(output);
 read(n,m);
 nn:=0;
 for i:=1 to n do
  begin
  q[i]:=false;
  hadd(inf,i);
  tab[i]:=nil;
  end;
 h[d[1]]:=0;
 siftup(d[1]);

 for i:=1 to m do
  begin
  read(x,y,v);
  add(x,y,v);
  add(y,x,v);
  end;

 for i:=1 to n do
  begin
  minn:=extractmin(imin);
  q[imin]:=true;
  ans[imin]:=minn;
  p:=tab[imin];
  while p<>nil do
   begin
   if (not(q[p^.n])) and (h[d[p^.n]] > (minn+p^.v)) then
    begin
    h[d[p^.n]] := minn+p^.v;
    siftup(d[p^.n]);
    siftdown(d[p^.n]);
    end;
   p:=p^.next;
   end;
  end;

 for i:=1 to n do
  if ans[i]>=inf then
   write('-1 ')
  else
   write(ans[i],' ');
 close(input);
 close(output);
end.
