const
  big = 100000000000;
type
  tdosp = record
            st,p : int64;
          end;
var
  i,j,n,m,k,v,a1,a2,i1 : longint;
  c,ot : int64;
  a,f : array [1..50,1..50] of int64;
  b : array [1..50,1..7] of tdosp;
  sk : array [1..50] of int64;

  fl,p1 : array [1..7] of longint;
  sch : longint;


procedure rec(g,k1 : longint; s : int64);
var
  i : longint;
  d : int64;
begin
  if s>ot then exit; 
  if k1=k+1 then
  begin
    s:=s+f[g,v];
    if s<ot then ot:=s; 
  end
          else
  begin
    for i:=1 to n do
    begin
      if (f[g,i]<>big) and (b[i,p1[k1]].st<>0) then 
      begin
        d:=b[i,p1[k1]].st-(b[i,p1[k1]].st div 100)*sk[i]+f[g,i];
        sk[i]:=sk[i]+b[i,p1[k1]].p;
        rec(i,k1+1,s+d);     
        sk[i]:=sk[i]-b[i,p1[k1]].p;
      end;
    end;
  end;
end;

function min(a,b : int64) : int64;
begin
  if a<b then min:=a else min:=b;
end;


procedure otvet;
begin
   if ot=big then writeln(-1) else writeln(ot);
end;

procedure rec1(k1 : longint);
var
  i,j,g,tg : longint;
  mg,tot,d : int64;
begin
  if k1=k+1 then
  begin

    for i:=1 to n do
      sk[i]:=0;
    tg:=v;
    tot:=0;
    for i:=1 to k do
    begin
      g:=-1; mg:=big;
      for j:=1 to n do
      begin
        inc(sch);
        if sch=10000000 then begin otvet; halt; end;
        if (f[tg,j]<>big) and (b[j,p1[i]].st<>0) then
        begin
          d:=b[j,p1[i]].st-(b[j,p1[i]].st div 100)*sk[j]+f[tg,j];
          if d<mg then begin mg:=d; end;
        end;
      end;
      if g=-1 then begin tot:=big; break; end;         
      sk[g]:=sk[g]+b[g,p1[i]].p;
      tot:=tot+mg;
      tg:=g;
    end;
    if tot<ot then ot:=tot;    

    for i:=1 to n do
      sk[i]:=0;
    rec(v,1,0);  
  end
            else
  begin
    for i:=1 to k do
      if fl[i]=0 then
      begin
        fl[i]:=1;
        p1[k1]:=i;
        rec1(k1+1);
        fl[i]:=0;    
      end;
  end; 
end;

begin
  assign(input,'armor.in');
  reset(input);
  assign(output,'armor.out');
  rewrite(output);
  read(n,m,k,v);
  for i:=1 to n do
  begin
    for j:=1 to k do
    begin
      read(b[i,j].st);  
      read(b[i,j].p);  
    end;
  end;
  for i:=1 to n do
    for j:=1 to n do
      a[i,j]:=big;
  for i:=1 to n do
    a[i,i]:=0;
  for i:=1 to m do
  begin
    read(a1,a2,c);  
    if c<a[a1,a2] then begin a[a1,a2]:=c; a[a2,a1]:=c; end;   
  end;
  f:=a;
  for i:=1 to n do
    for j:=1 to n do
      for i1:=1 to n do
        if f[j,i1]>f[j,i]+f[i,i1] then f[j,i1]:=f[j,i]+f[i,i1]; 
  ot:=big;
  for i:=1 to k do
    fl[i]:=0;
  rec1(1);  
  otvet; 
  close(output);
end.