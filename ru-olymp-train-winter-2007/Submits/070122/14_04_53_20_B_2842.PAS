const inf=maxlongint div 4;
var ans,n,i,o:longint;
    g:array[1..200,0..20000]of longint;
    first,ee,next,p,a,c,w:array[1..200]of longint;

function dfs(x:longint):longint;
var ij,i,j,k,cmax,cc:longint;
begin
  dfs:=0;
  for i:=0 to 20000 do
    g[x,i]:=inf;
  k:=first[x];
  cmax:=a[x];
  g[x,a[x]]:=0;
  while k<>0 do
  begin
    cc:=dfs(ee[k]);
    cmax:=cmax+cc;
    if cmax>10001 then
      cmax:=10001;
    for j:=cmax downto a[x] do
      for i:=a[ee[k]] to cc do
      begin
        ij:=j+i;
        if ij>10001 then
          ij:=10001;
        if g[x,j]<>inf then
          if g[x,ij]>g[x,j]+g[ee[k],i] then
            g[x,ij]:=g[x,j]+g[ee[k],i];
      end;
    k:=next[k];
  end;
  for i:=0 to c[x] do
    if g[x,i]<>inf then
      g[x,i]:=g[x,i]+w[x];
  dfs:=cmax;
end;

begin
  assign(input,'system.in');
  reset(input);
  assign(output,'system.out');
  rewrite(output);
  read(n);
  o:=0;
  for i:=1 to n do
  begin
    read(p[i],c[i],a[i],w[i]);
    if p[i]<>0 then
    begin
      inc(o);
      ee[o]:=i;
      next[o]:=first[p[i]];
      first[p[i]]:=o;
    end;
  end;
  dfs(1);
  ans:=inf;
  for i:=1 to 20000 do
    if g[1,i]<ans then
      ans:=g[1,i];
  writeln(ans);
  close(output);
  close(input);
end.
