type
  tfl = array [1..50] of longint;
  tip = record
          res :int64;
          fl : tfl; 
        end;
var
  i,j,n,m,k,v1,v2,c1 : longint;
  r : array [1..500,1..3] of longint;
  fl : tfl;
  kb : longint;
  b : array [1..100000] of tip;  

procedure rec(k : longint);
var
  i : longint;
  t : int64;
begin
  if k=n then
  begin
    t:=0;
    for i:=1 to m do
      if (fl[r[i,1]]=0) and (fl[r[i,2]]=1) then t:=t+r[i,3]; 
    inc(kb);
    b[kb].res:=t;
    b[kb].fl:=fl;
  end
           else
  begin
    fl[k]:=0;
    rec(k+1);
    fl[k]:=1;
    rec(k+1);
  end;      
end;

procedure swap(var a,b : tip);
var
  c : tip;
begin
  c:=a;
  a:=b; 
  b:=c;
end;

procedure qsort(l,r : longint);
var
  i,j : longint;
  x : int64;
begin
  i:=l; j:=r;
  x:=b[l+random(r-l+1)].res;
  while i<=j do
  begin
    while b[i].res<x do
      inc(i);
    while b[j].res>x do
      dec(j);
    if i<=j then begin swap(b[i],b[j]); inc(i); dec(j); end;
  end;
  if j>l then qsort(l,j);
  if r>i then qsort(i,r);
end;

begin
  assign(input,'cuts.in');
  reset(input);
  assign(output,'cuts.out');
  rewrite(output);
  read(n,m);
  for i:=1 to m do
  begin
    read(v1,v2,c1);
    r[i,1]:=v1; r[i,2]:=v2; r[i,3]:=c1; 
  end;
  read(k);
  fl[1]:=0; fl[n]:=1;
  kb:=0;
  rec(2);
  qsort(1,kb);
  for i:=1 to k do
  begin
    for j:=1 to n do
      write(b[i].fl[j]);
    writeln();
  end;
  close(output);
end.