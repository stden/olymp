{$M 16000000}
const
 MaxN = 50001;
type
 pnode = ^node;
 node = record
         j:longint;
         n:pnode;
        end;
var
 num:array[0..MaxN] of longint;
{ ai,aj:array[0..MaxN] of longint;}
 n,i,j,l,a,b,tans:longint;
 G:array[0..MaxN] of pnode;
 tp:pnode;
 u:array[0..MaxN] of boolean;
 ai,aj:longint;
 m1,m2:longint;
 lists1,lists2:array[0..MaxN] of longint;

function DFS(i, p:longint):longint;
var
 tp:pnode;
 ans:longint;
begin
 if num[i]=1 then
  ans:=1
 else
  ans:=0;
 u[i]:=true;
 tp:=G[i];
 while tp<>nil do begin
  if not(u[tp^.j]) then
   ans:=ans+DFS(tp^.j,i);
  tp:=tp^.n;
 end;
 if abs(2*ans-l)<=tans then begin
  ai:=i;
  aj:=p;
  tans:=abs(2*ans-l);
 end;
 DFS:=ans;
end;

procedure DFS1(i:longint);
var
 tp:pnode;
begin
 u[i]:=true;
 if num[i]=1 then begin
  inc(m1);
  lists1[m1]:=i;
 end else begin
  tp:=G[i];
  while tp<>nil do begin
   if not(u[tp^.j]) then
    DFS1(tp^.j);
   tp:=tp^.n;
  end;
 end;
end;

procedure DFS2(i:longint);
var
 tp:pnode;
begin
 u[i]:=true;
 if num[i]=1 then begin
  inc(m2);
  lists2[m2]:=i;
 end else begin
  tp:=G[i];
  while tp<>nil do begin
   if not(u[tp^.j]) then
    DFS2(tp^.j);
   tp:=tp^.n;
  end;
 end;
end;

begin
 fillchar(num,sizeof(num),0);
 assign(input,'biconn.in');
 reset(input);
 assign(output,'biconn.out');
 rewrite(output);
 read(n);
 if n = 1 then begin
  writeln(0);
  close(input);
  close(output);
  halt(0);
 end;
 for i:=1 to n do begin
  G[i]:=nil;
  u[i]:=false;
 end;

 for i:=1 to n-1 do begin
  read(a, b);
  num[a]:=num[a]+1;
  num[b]:=num[b]+1;

  new(tp);
  tp^.j:=b;
  tp^.n:=G[a];
  G[a]:=tp;

  new(tp);
  tp^.j:=a;
  tp^.n:=G[b];
  G[b]:=tp;
 end;

 l:=0;
 for i:=1 to n do begin
  if num[i]=1 then inc(l);
 end;

 tans:=l;
 DFS(1,0);

 for i:=1 to n do
  u[i]:=false;
 u[ai]:=true;
 m1:=0;
 DFS1(aj);

 for i:=1 to n do
  u[i]:=false;
 u[aj]:=true;
 m2:=0;
 DFS2(ai);

 if (m1>m2) then begin
  j:=m2;
  writeln(m2+((m1-m2+1)div 2));
 end;
 if (m1<=m2) then begin
  j:=m1;
  writeln(m1+((m2-m1+1)div 2));
 end;

 for i:=1 to j do
  writeln(lists1[i],' ',lists2[i]);

 a:=-1;
 if m1>m2 then begin
  for i:=m2+1 to m1 do
   if a=-1 then
    a:=lists1[i]
   else begin
    writeln(lists1[i],' ',a);
    a:=-1;
   end;
   if a<>-1 then begin
    writeln(a,' ',ai);
   end;
 end;
 a:=-1;
 if m1<m2 then begin
  for i:=m1+1 to m2 do
   if a=-1 then
    a:=lists2[i]
   else begin
    writeln(lists2[i],' ',a);
    a:=-1;
   end;
   if a<>-1 then begin
    writeln(a,' ',ai);
   end;
 end;
 close(input);
 close(output);
end.
