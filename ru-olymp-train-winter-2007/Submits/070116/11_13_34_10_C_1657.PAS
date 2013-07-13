type
 Plist = ^TList;
 Tlist = record
  v:integer;
  next: PList;
 end;


var
 St,En:array[1..50000] of PList;
 n,i:integer;
 v,u:integer;
 Res1,Res2,C,nn,Num,F:array[1..50000] of integer;
 gg,m:integer;


procedure AddList(v,u:integer);
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

procedure DFS(v:integer);
var
 p:PList;
 ct:integer;
begin
 p:=St[v];
 C[v]:=1;
 ct:=0;
 if (v<>1) and (nn[v]-1=0)  then begin
  inc(gg);
  ct:=gg;
 end;
 while p<>nil do begin
  if C[p^.v]=0 then DFS(p^.v);
  p:=p^.next;
 end;
 if ct<>0 then begin
 F[ct]:=gg+1;
 Num[ct]:=v;
 end;
end;

function Find(v:integer):integer;
begin
 if C[F[v]]=0 then
  Find:=F[v]
 else begin
  F[v]:=Find(F[v]);
  Find := F[v];
 end;
end;

begin
 assign(input,'biconn.in'); reset(input);
 assign(output,'biconn.out'); rewrite(output);

 readln(n);
 for i:=1 to N do begin
  readln(v,u);
  AddList(v,u);
  AddList(u,v);
  inc(nn[v]);
  inc(nn[u]);
 end;

 DFS(1);

 m:=0;
 fillchar(C,sizeof(C),0);
 for i:=1 to gg-1 do begin
  if C[i]=0 then begin
   v:=Find(i);
   C[i]:=1; C[v]:=1;
   if v=gg+1 then C[v]:=0 else F[v]:=v+1;
   inc(m);
   Res1[m]:=Num[i]; Res2[m]:=Num[v];
  end;
 end;

 writeln(m);
 for i:=1 to m do writeln(Res1[i],' ',Res2[i]);
 close(input);
 close(output);
end.

