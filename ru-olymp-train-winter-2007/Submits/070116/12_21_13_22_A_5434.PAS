{$Mode Delphi}
{$M 16000000 R+ Q+}

type IntVec=array of integer;
     IntMatrix=array of array of boolean;
     IntRes=array[0..500] of  record
                        T,P:integer;
                      end;

     PIntRes=^IntRes;
var n,m,u,v,i,j:integer;
    a,b:array[1..500] of integer;
    ca,cb:array[1..500] of integer;
    nx:array[1..2000] of integer;
    go:array[1..2000] of integer;
    ans:array[1..500] of integer;
    res:PIntRes;
    count:integer;
    T,P:IntVec;


procedure adda(u,v:integer);
begin
  inc(count);
  nx[count]:=a[u];
  go[count]:=v;
  inc(ca[u]);
  a[u]:=count;
end;

function merge(a,b:PIntRes;var l1,l2:integer);
begin
  for i:=l1 to l1+l2-1 do
  a[i]:=b[i-l1];
  l1:=l1+l2;
end;

procedure addb(u,v:integer);
begin
  inc(count);
  nx[count]:=b[u];
  go[count]:=v;
  inc(cb[u]);
  b[u]:=count;
end;

function kun(M:IntMatrix;var res:PIntRes;var l:integer):boolean;

var mark:array[1..500] of boolean;
    p:array[0..500] of integer;
    i:integer;

function dfs(v:integer):boolean;
var i:integer;
begin
  mark[v]:=true;
  for i:=0 to high(M[v]) do
    if M[v][i] then
    if (p[i]=-1) or (not mark[p[i]] and dfs(p[i])) then begin
      dfs:=true;
      p[i]:=v;
      exit;
    end;
  dfs:=false;
end;

begin
   kun:=false;
   fillchar(p,sizeof(p),255);
   for i:=0 to high(M) do begin
      fillchar(mark,sizeof(mark),0);
      dfs(i);
   end;
   for i:=0 to high(M[0]) do
   if p[i]=-1 then exit;
   kun:=true;
   l:=length(M[0]);
   for i:=0 to high(M[0]) do begin
     res[i].P:=i;
     res[i].T:=P[i];
   end;
end;
var bg:integer;

function dfs(T,P:IntVec;ParT,ParP:integer;var answ:PIntRes; var l:integer):boolean;
var i,j,temp,wr,len:integer;
    newT,newP:IntVec;
    M:IntMatrix;
    res:PIntRes;
    FM:array of array of PIntRes;
    LM:array of array of integer;
//    TT,PP:array[0..500] of integer; {for debug}
begin
  newT:=nil;
  newP:=nil;
  new(answ);
  l:=0;
  inc(bg);
{  for i:=0 to high(T) do
  TT[i]:=T[i];
  for i:=0 to high(P) do
  PP[i]:=P[i];           }
  setlength(M,length(T));
  setlength(FM,length(T));
  setlength(LM,length(T));
  for i:=0 to high(T) do begin
    setlength(M[i],length(P));
    setlength(FM[i],length(P));
    setlength(LM[i],length(P));
  end;
  for i:=0 to high(T) do
  for j:=0 to high(P) do begin
    M[i,j]:=false;
    FM[i,j]:=nil;
    LM[i,j]:=0;
  end;
  if P=nil then begin
    dfs:=true;
    exit;
  end;
  if T=nil then begin
    dfs:=false;
    exit;
  end;
  if length(T)<length(P) then begin
    dfs:=false;
    exit;
  end;
  for i:=0 to high(T) do
    for j:=0 to high(P) do begin
      temp:=a[T[i]];
      wr:=-1;
      if (ParT=T[i]) or (cb[P[j]]=0) then
      setlength(newT,ca[T[i]])
      else setlength(newT,ca[T[i]]-1);
      while temp<>0 do begin
         if ParT<>go[temp] then begin
           inc(wr);
           newT[wr]:=go[temp];
         end;
         temp:=nx[temp];
      end;
      temp:=b[P[j]];
      wr:=-1;
      if (ParP=P[i]) or (cb[P[j]]=0) then
      setlength(newP,cb[P[j]])
      else setlength(newP,cb[P[j]]-1);
      while temp<>0 do begin
        if ParP<>go[temp] then begin
          inc(wr);
          newP[wr]:=go[temp];
        end;
        temp:=nx[temp];
      end;
      M[i,j]:=dfs(newT,newP,T[i],P[j],FM[i,j],LM[i,j]);
    end;
  new(Res);
  dfs:=kun(M,res,Len);
  if result then begin
    for i:=0 to Len-1 do begin
      merge(answ,FM[res[i].t,res[i].p],l,LM[res[i].t,res[i].p]);
    end;
    for i:=0 to len-1 do begin
      res[i].t:=T[res[i].T];
      res[i].p:=P[res[i].P];
    end;
    merge(answ,res,l,len);
  end;
  dispose(res);
  for i:=0 to high(T) do
  for j:=0 to high(P) do
  if FM[i,j]<>nil then
  dispose(FM[i,j]);
  FM:=nil;
  newT:=nil;
  newP:=nil;
end;

var len:integer;

begin
  assign(input,'map.in');
  assign(output,'map.out');
  reset(input);
  rewrite(output);
  readln(m);
  for i:=1 to m-1 do begin
    read(u,v);
    addb(u,v);
    addb(v,u);
  end;
  readln(n);
  for i:=1 to n-1 do begin
    read(u,v);
    adda(u,v);
    adda(v,u);
  end;
  setlength(T,1);
  setlength(P,1);
  bg:=0;
  P[0]:=1;
  for i:=1 to n do begin
    T[0]:=i;
    if dfs(T,P,i,1,res,len) then begin
      writeln('YES');
      for j:=0 to len-1 do
        ans[res[j].P]:=res[J].T;
      for i:=1 to m do
      write(ans[i],' ');
      close(input);
      close(output);
      halt(0);
    end;
  end;
  writeln('NO');
  close(input);
  close(output);
end.
