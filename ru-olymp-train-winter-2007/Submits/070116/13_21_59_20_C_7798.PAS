uses math;
var np,ff,ll,cnt,nodes,first,next,ee:array[1..50000]of longint;
    was:array[1..50000]of boolean;
    mi,mx,oo,r,o,i,n,a,b,no:longint;
    flag:boolean;

procedure addedge(a,b:longint);
begin
  inc(o);
  ee[o]:=b;
  next[o]:=first[a];
  first[a]:=o;
end;

procedure dfs(x,p:longint);
var j:longint;
    flag:boolean;
begin
  was[x]:=true;
  j:=first[x];
  flag:=false;
  while j<>0 do
  begin
    if not was[ee[j]] then
    begin
      dfs(ee[j],byte(x<>r)*p+byte(x=r)*ee[j]);
      flag:=true;
    end;
    j:=next[j];
  end;
  if not flag then
  begin
    no:=no+1;
    nodes[no]:=x;
    np[no]:=p;
  end;
end;

begin
  assign(input,'biconn.in');
  reset(input);
  assign(output,'biconn.out');
  rewrite(output);
  read(n);
  o:=0;
  fillchar(cnt,sizeof(cnt),0);
  for i:=1 to n-1 do
  begin
    read(a,b);
    addedge(a,b);
    addedge(b,a);
    inc(cnt[a]);
    inc(cnt[b]);
  end;
  for i:=1 to n do
    if cnt[i]>1 then
    begin
      r:=i;
      break;
    end;
  fillchar(was,sizeof(was),0);
  no:=0;
  dfs(r,0);
  oo:=0;
  for i:=1 to no do
  begin
    if (i=1)or(np[i-1]<>np[i]) then
    begin
      inc(oo);
      ff[oo]:=i;
      ll[oo]:=i;
    end
    else
      if oo>0 then
        ll[oo]:=i;
  end;
  writeln(no div 2+no mod 2);
  while no>1 do
  begin
    mx:=-1;
    mi:=0;
    for i:=1 to oo do
      if ll[i]-ff[i]>mx then
      begin
        mx:=ll[i]-ff[i];
        mi:=i;
      end;
    flag:=false;
    for i:=1 to oo do
      if (ff[i]<=ll[i])and(i<>mi) then
      begin
        if ll[mi]<ff[mi] then
        begin
          flag:=true;
          break;
        end;
        writeln(nodes[ff[mi]],' ',nodes[ff[i]]);
        ff[i]:=ff[i]+1;
        ff[mi]:=ff[mi]+1;
        no:=no-2;
        flag:=true;
      end;
    if not flag then
    begin
      while ff[mi]+1<=ll[mi] do
      begin
        writeln(nodes[ff[mi]],' ',nodes[ff[mi]+1]);
        ff[mi]:=ff[mi]+2;
      end;
      if ff[mi]=ll[mi] then
        writeln(nodes[ff[mi]],' ',r);
      break;
    end;
  end;
  if no=1 then
   for i:=1 to oo do
     if ff[i]<=ll[i] then
     begin
       writeln(nodes[ff[i]],' ',r);
       break;
     end;
  close(input);
  close(output);
end.

