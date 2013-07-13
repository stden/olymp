{$M 16000000}
{$r+,s+,q+}
type
 tlist=record
       n,v:longint;
       next:longint;
       end;
var
 tab:array[1..30000]of longint;
 h,hh,ans,d:array[1..30000]of longint;
 q:array[1..30000]of boolean;
 bas:array[1..400000]of tlist;
 minn,nn,k,p,inf,imin,x,y,v,i,n,m,j:longint;

procedure add(x,y,v:longint);
begin
 k:=k+1;
 bas[k].n:=y;
 bas[k].next:=tab[x];
 bas[k].v:=v;
 tab[x]:=k;
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
 k:=0;
 for i:=1 to n do
  begin
  q[i]:=false;
  hadd(inf,i);
  tab[i]:=-1;
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
  if minn>=inf then
   runerror(255);
  q[imin]:=true;
  ans[imin]:=minn;
  p:=tab[imin];
  while p<>-1 do
   begin
   if (not(q[bas[p].n])) and (h[d[bas[p].n]] > (minn+bas[p].v)) then
    begin
    h[d[bas[p].n]] := minn+bas[p].v;
    siftup(d[bas[p].n]);
    end;
   p:=bas[p].next;
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
