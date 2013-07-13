{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
uses
 Math;
const
 INF  = 1000000001;
 maxN = 1000;
type
 int  = longint;
var
 c,f,num:array[1..maxN,1..maxN]of int;
 ans:array[1..maxN*maxN]of int;
 vis:array[1..maxN]of boolean;
 n,m,i,j,u,v,s,t,flow,add,bound,cnt:int;

function dfs(v,h:int):int;
var w:int;
begin
 vis[v]:=true;
 if (v=t) then begin
  dfs:=INF;
  exit;
 end;
 for w:=1 to n do
  if (c[v,w]-f[v,w]>=bound)and(not vis[w]) then begin
   h:=min(h,c[v,w]-f[v,w]);
   h:=min(h,dfs(w,h));
   if (h>0) then begin
    inc(f[v,w],h);
    dec(f[w,v],h);
    dfs:=h;
    exit;
   end;
  end;
 dfs:=0;
end;

procedure dfs(v:int);
var w:int;
begin
 vis[v]:=true;
 for w:=1 to n do
  if (c[v,w]-f[v,w]>0) then dfs(w);
end;

Begin
 assign(input, 'cut.in');
 reset(input);
 assign(output,'cut.out');
 rewrite(output);
 read(n,m);
 for i:=1 to m do begin
  read(u,v);
  read(c[u,v]); c[v,u]:=c[u,v];
  num[u,v]:=i; num[v,u]:=i;
 end;
 s:=1; t:=n;
 fillchar(f,sizeof(f),0);
 flow:=0;
 bound:=(1 shl 30);
 while (bound>0) do begin
  repeat
   fillchar(vis,sizeof(vis),false);
   add:=dfs(s,INF);
   flow:=flow+add;
  until (add=0);
  bound:=bound div 2;
 end;
 //Out
 fillchar(vis,sizeof(vis),false);
 dfs(s);
 for i:=1 to n do
  for j:=1 to n do
   if (c[i,j]>0)and(f[i,j]>0)and(vis[i] xor vis[j]) then begin
    inc(cnt);
    ans[cnt]:=num[i,j];
   end;
 for i:=1 to cnt-1 do
  for j:=1 to cnt-i do
   if (ans[j]>ans[j+1]) then begin
    v:=ans[j]; ans[j]:=ans[j+1]; ans[j+1]:=v;
   end;
 writeln(cnt,' ',flow);
 for i:=1 to cnt do
  write(ans[i],' ');
 close(output);
End.
