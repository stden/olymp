var o,n,m,i,a,b,p,ans:longint;
    g:array[1..200,1..200]of boolean;
    color,dp:array[1..200]of longint;

procedure dfs(x:longint);
var i:longint;
begin
  inc(o);
  dp[x]:=o;
  color[x]:=1;
  for i:=1 to n do
    if g[x,i] then
    begin
      if color[i]=1 then
        ans:=ans*(dp[x]-dp[i]+1) mod p;
      if color[i]=0 then
      begin
        g[x,i]:=false;
        g[i,x]:=false;
        dfs(i);
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
    g[a,b]:=true;
    g[b,a]:=true;
  end;
  fillchar(color,sizeof(color),0);
  ans:=1;
  o:=0;
  dfs(1);
  writeln(ans mod p);
  close(output);
  close(input);
end.
