{$M 16000000}
uses SysUtils;
const
 MaxN = 262144;
 faq = 262143;
 eps = 2e-5;
type
 pnode = ^node;
 node = record
         j,c,f:longint;
         n,p,r:pnode;
        end;

 pnode2 = ^node2;
 node2 = record
         j:longint;
         n,p:pnode2;
         s:pnode;
        end;

var
 tm1,tm2:double;
 G:array[0..MaxN] of pnode;
 k:array[0..MaxN] of longint;
 TG:array[0..MaxN] of pnode2;
 pair:array[0..MaxN] of longint;
 Q,D:array[0..MaxN] of longint;
 del,u:array[0..MaxN] of boolean;
 i,j,n,a:longint;
 tp:pnode;
 fb:boolean;

procedure NO;
 begin
  writeln('NO');
  close(input);
  close(output);
  halt(0);
 end;

procedure addv(i,j:longint);
 var
  tp1,tp2:pnode;
 begin
  new(tp1);
  tp1^.j:=j;
  tp1^.c:=1;
  tp1^.f:=0;
  tp1^.n:=G[i];
  if tp1^.n <>nil then
   tp1^.n^.p:=tp1;
  tp1^.p:=nil;
  new(tp2);
  tp2^.j:=i;
  tp2^.c:=0;
  tp2^.f:=0;
  tp2^.n:=G[j];
  if tp2^.n <>nil then
   tp2^.n^.p:=tp2;
  tp2^.p:=nil;
  tp1^.r:=tp2;
  tp2^.r:=tp1;
  G[i]:=tp1;
  G[j]:=tp2;
 end;

procedure addv2(i,j:longint; f:pnode);
 var
  tp:pnode2;
 begin
  new(tp);
  tp^.j:=j;
  tp^.n:=TG[i];
  if tp^.n <>nil then
   tp^.n^.p:=tp;
  tp^.p:=nil;
  tp^.s:=f;
  TG[i]:=tp;
 end;


procedure CO(i,j:longint);
 var
  tp:pnode;
 begin
  D[i]:=j;
  tp:=G[i];
  while tp<>nil do begin
   if (tp^.j > 0)and(tp^.j <= 2*n)and(tp^.c=1) then begin
    if (D[tp^.j]=-1) then begin
     CO(tp^.j,j);
    end else
     if D[tp^.j]=j then
      NO;
   end;
   tp:=tp^.n;
  end;
 end;


procedure BFS;
 var
  h,t:longint;
  tp:pnode;
 begin
  Q[0]:=0;
  D[0]:=0;
  u[0]:=true;
  h:=0;
  t:=1;
  while h<>t do begin
   i:=Q[h];
   tp:=G[i];
   h:=(h+1)and(faq);
   while tp<>nil do begin
    if (tp^.c > 0) then begin
     if not(u[tp^.j]) then begin
      u[tp^.j]:=true;
      Q[t]:=tp^.j;
      D[tp^.j]:=D[i]+1;
      t:=(t+1)and(faq);
      addv2(i,tp^.j,tp);
     end else begin
      if D[i]<D[tp^.j] then begin
       addv2(i,tp^.j,tp);
      end;
     end;
    end;
    tp:=tp^.n;
   end;
  end;
 end;

function DFS(i:longint):boolean;
 var
  tp:pnode2;
  f:boolean;
 begin
  if i=(2*n+1) then begin
   DFS:=True;
   exit;
  end;
  tp:=TG[i];
  if tp = nil then begin
   DFS:=false;
   del[i]:=true;
   exit;
  end;

  f:=false;

  while (not(f))and(tp<>nil) do begin
   if not(del[tp^.j]) then 
    f:=f or DFS(tp^.j);

   if f then begin
    dec(tp^.s^.c);
    inc(tp^.s^.f);
    dec(tp^.s^.r^.f);
    inc(tp^.s^.r^.c);
   end;

   if tp^.p = nil then begin
    TG[i]:=tp^.n;
    if tp^.n<>nil then
     tp^.n^.p:=nil;
   end else begin
    tp^.p^.n:=tp^.n;
    if tp^.n<>nil then
     tp^.n^.p:=tp^.p;
   end;

   if f then begin
    dfs:=true;
    exit;
   end;
   tp:=tp^.n;
  end;

  del[i]:=true;
  dfs:=false;
 end;

begin
 tm1:=time;
 assign(input,'omax.in');
 reset(input);
 assign(output,'omax.out');
 rewrite(output);
 fillchar(D,sizeof(D),-1);
 read(n);
 for i:=0 to 2*n+1 do begin
  G[i]:=nil;
 end;

 for i:=1 to n do begin
  addv(0,i);
  addv(n + i, 2*n + 1);
  read(k[i]);
  if K[i]=0 then NO;
  for j:=1 to k[i] do begin
   read(a);
{   if D[a]<>i then begin
    D[a]:=i;}
    a:=a+n;
    addv(i, a);
{   end;}
  end;
 end;

 //<DINIZ>
 while true do begin
  tm2:=time;
  if ((tm2-tm1)>eps) then begin
   NO;
  end;
  for i:=0 to 2*n+1 do begin
   TG[i]:=nil;
   u[i]:=false;
   del[i]:=false;
  end;

  BFS;

  if not(u[2*n+1]) then break;

  while (true) do begin
   fb:=DFS(0);
   if not(fb) then
    break;
  end;
 end;
 //</DINIZ>

 fillchar(pair,sizeof(pair),255);

 for i:=n+1 to 2*n do begin
  tp:=G[i];
  while tp<>nil do begin
   if (tp^.j < (n+1)) and (tp^.f = -1) then begin
    pair[tp^.j]:=i;
   end;
   tp:=tp^.n;
  end;
 end;

 for i:=1 to n do begin
  if pair[i]<0 then
   NO;
 end;

 fillchar(D,sizeof(D),255);

 for i:=1 to n do begin
  if (D[i]=-1) then
   CO(i,i);
 end;

 writeln('YES');
 for i:=1 to n do
  write(pair[i]-n,' ');

 close(input);
 close(output);
end.
