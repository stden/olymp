var kk,k,t,om,cr,a,b,i,n,m,j,la:longint;
    parent:array[1..500,0..10]of longint;
    isanc:array[1..500,1..500]of boolean;
    mfirst,mnext,rfirst,rnext,mee,ree:array[1..1000]of longint;
    rlca,mlca:array[1..500,1..500]of longint;
    rn,ancs:array[1..500]of longint;
    isreal,was:array[1..500]of boolean;
    ok:boolean;
label 1,2;

function getlca(a,b:longint):longint;
var j:longint;
label 1;
begin
1:
  j:=0;
  while not isanc[a,parent[b,j]] do
    j:=j+1;
  if j=0 then
    getlca:=parent[b,j]
  else
  begin
    b:=parent[b,j-1];
    goto 1;
  end;
end;

procedure dfsm(x,d:longint);
var j:longint;
begin
  was[x]:=true;
  j:=0;
  while 1 shl j+1<=d do
  begin
    parent[x,j]:=ancs[d-1 shl j];
    j:=j+1;
  end;
  if 1 shl j+1>d then
    parent[x,j]:=ancs[1];
  for j:=1 to d-1 do
    isanc[x,ancs[j]]:=true;
  j:=mfirst[x];
  ancs[d]:=x;
  while j<>0 do
  begin
    if not was[mee[j]] then
      dfsm(mee[j],d+1);
    j:=mnext[j];
  end;
end;

procedure dfsr(x,d:longint);
var j:longint;
begin
  was[x]:=true;
  j:=0;
  while 1 shl j+1<=d do
  begin
    parent[x,j]:=ancs[d-1 shl j];
    j:=j+1;
  end;
  if 1 shl j+1>d then
    parent[x,j]:=ancs[1];
  for j:=1 to d-1 do
    isanc[x,ancs[j]]:=true;
  j:=rfirst[x];
  ancs[d]:=x;
  while j<>0 do
  begin
    if not was[ree[j]] then
      dfsr(ree[j],d+1);
    j:=rnext[j];
  end;
end;

procedure addedgem(a,b:longint);
begin
  om:=om+1;
  mee[om]:=b;
  mnext[om]:=mfirst[a];
  mfirst[a]:=om;
end;

procedure addedger(a,b:longint);
begin
  cr:=cr+1;
  ree[cr]:=b;
  rnext[cr]:=rfirst[a];
  rfirst[a]:=cr;
end;

begin
  assign(input,'map.in');
  reset(input);
  assign(output,'map.out');
  rewrite(output);
  om:=0;
  cr:=0;
  read(m);
  for i:=1 to m-1 do
  begin
    read(a,b);
    addedgem(a,b);
    addedgem(b,a);
  end;
  read(n);
  for i:=1 to n-1 do
  begin
    read(a,b);
    addedger(a,b);
    addedger(b,a);
  end;
  fillchar(was,sizeof(was),0);
  fillchar(parent,sizeof(parent),0);
  fillchar(isanc,sizeof(isanc),false);
  dfsm(1,1);
  for i:=1 to m do
    for j:=i+1 to m do
    begin
      if isanc[i,j] then
        mlca[i,j]:=j
      else
      if isanc[j,i] then
        mlca[i,j]:=i
      else
        mlca[i,j]:=getlca(i,j);
      mlca[j,i]:=mlca[i,j];
    end;
  for i:=1 to m do
  begin
    fillchar(was,sizeof(was),0);
    fillchar(parent,sizeof(parent),0);
    fillchar(isanc,sizeof(isanc),false);
    dfsr(i,1);
    for j:=1 to n do
      for k:=j+1 to n do
      begin
        if isanc[j,k] then
          rlca[j,k]:=k
        else
        if isanc[k,j] then
          rlca[j,k]:=j
        else
          rlca[j,k]:=getlca(j,k);
        rlca[k,j]:=rlca[j,k];
      end;
    for i:=1 to n do
    begin
      rn[i]:=i;
      isreal[i]:=false;
    end;
    ok:=true;
    kk:=0;
2:
    for j:=1 to m do
      for k:=j+1 to m do
      begin
        if mlca[j,k]<>rn[rlca[j,k]] then
        begin
          la:=mlca[j,k];
          if (isreal[la])or(isreal[rlca[j,k]]) then
          begin
            ok:=false;
            break;
          end;
          isreal[rlca[j,k]]:=true;
          isreal[mlca[j,k]]:=true;
          t:=rlca[j,k];
          rn[rlca[j,k]]:=la;
          rn[la]:=t;
        end;
        if not ok then
          break;
      end;
    if ok then
    begin
      kk:=kk+1;
      if kk=1 then
        goto 2;
      writeln('YES');
      for j:=1 to m do
        write(rn[j],' ');
      goto 1;
    end;
  end;
  writeln('NO');
1:
  close(input);
  close(output);
end.
