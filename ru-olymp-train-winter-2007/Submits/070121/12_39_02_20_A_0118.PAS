{$I-,Q-,R-,S-}
uses math;
var tt,n,i,k,o:longint;
    t:array[1..100000]of char;
    x,p,l,r,px:array[1..500000]of longint;
    tree:array[1..1000000]of int64;
    c:char;

procedure qsort(l,r:longint);
var i,j,m,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    m:=px[random(r-l+1)+l];
    while i<j do
    begin
      while px[i]<m do
        inc(i);
      while px[j]>m do
        dec(j);
      if i<=j then
      begin
        t:=px[i];
        px[i]:=px[j];
        px[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsort(l,j);
    qsort(i,r);
  end;
end;

function query(x,l,r,lc,rc:longint):int64;
var s:longint;
begin
  query:=0;
  if lc>=px[r] then
    exit;
  if rc<=px[l] then
    exit;
  if (lc<=px[l])and(rc>=px[r]) then
  begin
    query:=tree[x];
    exit;
  end;
  s:=(l+r) div 2;
  query:=query(x*2,l,s,lc,rc)+query(x*2+1,s,r,lc,rc);
end;

procedure add(x,l,r,lc,rc,a,b:longint);
var s:longint;
begin
  if (r=l+1)and(px[l]>=lc)and(px[r]<=rc) then
  begin
    tree[x]:=tree[x]+abs(a*a-b*b);
    exit;
  end;
  s:=(l+r) div 2;
  if px[s]>=rc then
    add(x*2,l,s,lc,rc,a,b)
  else
  if px[s]<=lc then
    add(x*2+1,s,r,lc,rc,a,b)
  else
  begin
    add(x*2,l,s,lc,px[s],a,a+(b-a) div (rc-lc)*(px[s]-lc));
    add(x*2+1,s,r,px[s],rc,a+(b-a) div (rc-lc)*(px[s]-lc),b);
  end;
  tree[x]:=tree[x*2]+tree[x*2+1];
end;

begin
  randomize;
  assign(input,'geology.in');
  reset(input);
  assign(output,'geology.out');
  rewrite(output);
  o:=0;
  readln(n);
  for i:=1 to n do
  begin
    read(t[i]);
    case t[i] of
    'A': begin
           read(c,c,x[i],p[i]);
           inc(o);
           px[o]:=max(x[i]-p[i],1);
           inc(o);
           px[o]:=x[i];
           inc(o);
           px[o]:=min(x[i]+p[i],100000);
         end;
    'Q': begin
           read(c,c,c,c,l[i],r[i]);
           if l[i]>r[i] then
           begin
             tt:=l[i];
             l[i]:=r[i];
             r[i]:=tt;
           end;
           inc(o);
           px[o]:=l[i];
           inc(o);
           px[o]:=r[i];
         end;
    end;
    readln;
  end;
  fillchar(tree,sizeof(tree),0);
  qsort(1,o);
  k:=1;
  for i:=2 to o do
    if px[i]<>px[k] then
    begin
      inc(k);
      px[k]:=px[i];
    end;
  o:=k;
  for i:=1 to n do
  begin
    case t[i] of
    'A': begin
           if x[i]>1 then
             add(1,1,o,max(1,x[i]-p[i]),x[i],max(p[i]-(x[i]-1),0),p[i]);
           if x[i]<100000 then
             add(1,1,o,x[i],min(x[i]+p[i],100000),p[i],max(p[i]-(100000-x[i]),0));
         end;
    'Q': if l[i]=r[i] then
           writeln('0.000')
         else
           writeln(query(1,1,o,l[i],r[i])/2:0:3);
    end;
  end;
  close(input);
  close(output);
end.
