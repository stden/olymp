type
 PList=^TList;
 Tlist= record
  v:integer;
  next:PList;
 end;
 integer=longint;


var
 st,En,st2,en2,st3,en3:array[1..200000] of PList;
 n,i,j,k,u,pp,cnt:integer;
 gg,X,list:array[1..200000] of integer;


procedure Add(v,u:integer);
var
 p:PList;
begin
 if St[v]=nil then begin
  new(St[v]);
  St[v]^.v:=u;
  St[v]^.next:=nil;
  En[v]:=St[v];
 end else begin
  new(p);
  p^.v:=u;
  p^.next:=nil;
  En[v]^.next:=p;
  En[v]:=p;
 end;
end;

procedure Add2(v,u:integer);
var
 p:PList;
begin
 if St2[v]=nil then begin
  new(St2[v]);
  St2[v]^.v:=u;
  St2[v]^.next:=nil;
  En2[v]:=St2[v];
 end else begin
  new(p);
  p^.v:=u;
  p^.next:=nil;
  En2[v]^.next:=p;
  En2[v]:=p;
 end;
end;

procedure Add3(v,u:integer);
var
 p:PList;
begin
 if St3[v]=nil then begin
  new(St3[v]);
  St3[v]^.v:=u;
  St3[v]^.next:=nil;
  En3[v]:=St3[v];
 end else begin
  new(p);
  p^.v:=u;
  p^.next:=nil;
  En3[v]^.next:=p;
  En3[v]:=p;
 end;
end;

function DFS(v:integer):boolean;
var
 p:PLIST;
begin
 if gg[v]=1 then begin
  DFS:=false;
  exit;
 end;
 gg[v]:=1;
 p:=St[v];
 while p<>nil do begin
  if (X[p^.v]=0) or DFS(X[p^.v]) then begin
   X[p^.v]:=v;
   DFS:=true;
   exit;
  end;
  p:=p^.next;
 end;
 dfs:=false;
end;


procedure Answer(ans:boolean);
var
 i:integer;
 P:array[1..100000] of integer;
begin
 if ans then begin
  writeln('YES');
  for i:=1 to n do
   P[X[i]]:=i;
  for i:=1 to n do
   write(P[i], ' ');
 end
 else writeln('NO');
 close(output);
 halt;
end;

procedure DFS1(v:integer);
var
 p:PLIST;
begin
 p:=St2[v];
 gg[v]:=1;
 while p<>nil do begin
  if gg[p^.v]=0 then DFS1(p^.v);
  p:=p^.next;
 end;
 dec(cnt);
 list[cnt]:=v;
end;

procedure DFS2(v,c:integer);
var
 p:PList;
begin
 p:=St3[v];
 gg[v]:=c;
 while p<>nil do begin
  if gg[p^.v]=0 then DFS2(p^.v,c);
  p:=p^.next;
 end;
end;


procedure Copy;
var
 p,p1:Plist;
 i:integer;
begin
 for i:=1 to n do begin
  p:=St[i];
  while p<>nil do begin
   if X[p^.v]=i then
    Add2(p^.v+N,i)
   else
    Add2(i,p^.v+N);
   p:=p^.next;
  end;
 end;
end;


procedure Tran;
var
 p,p1:Plist;
 i:integer;
begin
 for i:=1 to n*2 do begin
  p:=St2[i];
  while p<>nil do begin
   Add3(p^.v,i);
   p:=p^.next;
  end;
 end;
end;

begin
 assign(input,'omax.in'); reset(input);
 assign(output,'omax.out'); rewrite(output);
 readln(n);

 for i:=1 to n do begin
  read(k);
  for j:=1 to k do begin
   read(u);
   Add(i,u);
  end;
 end;
 pp:=0;
 for i:=1 to n do begin
  fillchar(gg,sizeof(gg),0);
  if DFS(i) then inc(pp);
 end;

 if pp<n then answer(false);

 Copy;
 fillchar(gg,sizeof(gg),0);
 cnt:=N*2+1;
 for i:=1 to n*2 do
  if gg[i]=0 then
   DFS1(i);
 fillchar(gg,sizeof(gg),0);

 Tran;
 cnt:=0;
 for i:=1 to n*2 do
  if gg[list[i]]=0 then begin
   inc(cnt);
   DFS2(list[i],cnt);
  end;

 for i:=1 to n do
  if gg[X[i]]=gg[i+N] then
   Answer(false);

 Answer(true);
end.
