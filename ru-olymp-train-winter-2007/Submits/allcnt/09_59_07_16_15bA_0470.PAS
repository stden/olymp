{$M 32000000}
type
 pnode = ^node;
 node = record
  	 j, num:longint;
         n:pnode;
      end;
var
 G:array[0..20001]of pnode;
 num:array[0..20001]of longint;
 tp:pnode;
 i,j,n,m,a,b,time:longint;
 br:array[0..200001]of boolean;
 u:array[0..20001] of boolean;

function DFS(i, p:longint):longint;
var
 tp:pnode;
 m, t:longint;
begin
 inc(time);
 num[i]:=time;
 tp:=G[i];
 u[i]:=true;
 m:=num[i];
 while tp <> nil do begin
  if tp^.j<>p then begin
   if (not(u[tp^.j])) then begin
    t:=DFS(tp^.j, i);
    if t > num[i] then
     br[tp^.num]:=true;
    if t < m then
     m:=t;
   end else begin
    if m > num[tp^.j] then
     m:=num[tp^.j];
   end;
  end;
  tp:=tp^.n;
 end;
 DFS:=m;
end;

begin
 assign(input,'bridges.in');
 reset(input);
 assign(output,'bridges.out');
 rewrite(output);
 read(n, m);

 for i:=1 to n do begin
  G[i]:=nil;
  u[i]:=false;
 end;

 for i:=1 to m do begin
  br[i]:=false;

  read(a,b);

  new(tp);
  tp^.j:=b;
  tp^.n:=G[a];
  tp^.num:=i;
  G[a]:=tp;

  new(tp);
  tp^.j:=a;
  tp^.num:=i;
  tp^.n:=G[b];
  G[b]:=tp;
 end;

 time:=0;
 DFS(1,0);


 j:=0;
 for i:=1 to m do begin
  if br[i] then inc(j);
 end;

 writeln(j);
 for i:=1 to m do begin
  if br[i] then write(i,' ');
 end;
 close(input);
 close(output);
end.
