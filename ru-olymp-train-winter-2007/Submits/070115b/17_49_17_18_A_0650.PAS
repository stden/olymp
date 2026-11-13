type
 plist=^tlist;
 tlist=record
       n,m:longint;
       next:plist;
       end;
var
 tab:array[1..30000]of plist;
 ans:array[1..200000]of boolean;
 d:array[1..20000]of longint;
 k,nans,x,y,n,m,i,j:longint;

function dfs(i,par:longint):longint;
var
 min,t:longint;
 p:plist;
begin
// writeln(i);
 k:=k+1;
 d[i]:=k;
 p:=tab[i];
 min:=k;
 while p<>nil do
  begin
  if (d[p^.n]=-1) then
   begin
   t:=dfs(p^.n,i);
   if (t>d[i]) then
    begin
    ans[p^.m]:=true;
    end;
   if t<min then
    min:=t;
   end
  else
   if (d[p^.n]<min)and(p^.m<>par) then
    min:=d[p^.n];
  p:=p^.next;
  end;
 dfs:=min;
end;

procedure add(x,y,t:longint);
var
 p:plist;
begin
 p:=new(plist);
 p^.n:=y;
 p^.next:=tab[x];
 p^.m:=t;
 tab[x]:=p;
end;

begin
 assign(input,'bridges.in');
 assign(output,'bridges.out');
 reset(input);
 rewrite(output);
 read(n,m);
 for i:=1 to n do
  begin
  tab[i]:=nil;
  d[i]:=-1;
  end;
 k:=0;
 for i:=1 to m do
  begin
  read(x,y);
  add(x,y,i);
  add(y,x,i);
  ans[i]:=false;
  end;
 dfs(1,0);
 nans:=0;
 for i:=1 to m do
  if ans[i] then
   nans:=nans+1;
 writeln(nans);
 for i:=1 to m do
  if ans[i] then
   write(i,' ');
 close(input);
 close(output);
end.