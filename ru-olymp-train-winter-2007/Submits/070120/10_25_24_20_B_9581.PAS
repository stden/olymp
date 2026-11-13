uses math;
const inf=-1000000000000000000;
var k,a,b,n,m,i,j:longint;
    g,p,gg,pp:array[1..20,1..20]of int64;
    c:array[1..20]of longint;
    ans,kk:int64;

begin
  assign(input,'maxsum.in');
  reset(input);
  assign(output,'maxsum.out');
  rewrite(output);
  read(n,m,kk);
  for i:=1 to n do
    read(c[i]);
  for i:=1 to n do
    for j:=1 to n do
    begin
      g[i,j]:=inf;
      p[i,j]:=inf;
    end;
  for i:=1 to n do
    p[i,i]:=0;
  for i:=1 to m do
  begin
    read(a,b);
    g[a,b]:=c[b];
  end;
  while kk<>0 do
  begin
    if kk mod 2=1 then
    begin
      for i:=1 to n do
        for j:=1 to n do
        begin
          pp[i,j]:=inf;
          for k:=1 to n do
            if (p[i,k]<>inf)and(g[k,j]<>inf) then
              pp[i,j]:=max(pp[i,j],p[i,k]+g[k,j]);
        end;
      p:=pp;
    end;
    for i:=1 to n do
      for j:=1 to n do
      begin
        gg[i,j]:=inf;
        for k:=1 to n do
          if (g[i,k]<>inf)and(g[k,j]<>inf) then
            gg[i,j]:=max(gg[i,j],g[i,k]+g[k,j]);
      end;
    g:=gg;
    kk:=kk div 2;
  end;
  ans:=inf;
  for i:=1 to n do
    if p[1,i]>ans then
      ans:=p[1,i];
  writeln(ans+c[1]);
  close(output);
  close(input);
end.
