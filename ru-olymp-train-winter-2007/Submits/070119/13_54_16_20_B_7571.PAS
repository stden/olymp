var o,n,m,i,a,b,p,ans:longint;
    g:array[1..200,1..200]of longint;
    color,dp:array[1..200]of longint;

procedure dfs(x:longint);
var i:longint;
begin
  inc(o);
  dp[x]:=o;
  color[x]:=1;
  for i:=1 to n do
    if g[x,i]>0 then
    begin
      if color[i]=1 then
        ans:=((ans*(dp[x]-dp[i]+1) mod p)*g[x,i]) mod p;
      if color[i]=0 then
      begin
        g[x,i]:=g[x,i]-1;
        g[i,x]:=g[i,x]-1;
        dfs(i);
        g[x,i]:=g[x,i]+1;
        g[i,x]:=g[i,x]+1;
      end;
    end;
  color[x]:=2;
  dec(o);
end;

begin
  assign(input,'optimum.in');
  reset(input);
  assign(output,'optimum.out');
  rewrite(output);
  fillchar(g,sizeof(g),false);
  read(n,m,p);
  for i:=1 to m do
  begin
    read(a,b);
    g[a,b]:=g[a,b]+1;
    g[b,a]:=g[b,a]+1;
  end;
  fillchar(color,sizeof(color),0);
  ans:=1;
  o:=0;
  dfs(1);
  writeln(ans mod p);
  close(output);
  close(input);
end.
