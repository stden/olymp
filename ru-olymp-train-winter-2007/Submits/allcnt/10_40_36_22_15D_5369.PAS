{$Mode Delphi}
{$M 16000000}

var q:array[0..200,0..200] of boolean;
    can:array[0..200,0..200] of boolean;
    zerocan:array[0..200] of boolean;
    mark:array[0..200] of boolean;
    bmark:array[0..200,0..200] of boolean;
    p:array[1..5,0..200] of integer;
    inzero:array[0..200] of boolean;
    n,k:integer;

function dfs(v:integer):boolean;
var i:integer;
begin
  mark[v]:=true;
  if v=0 then begin
    dfs:=true;
    exit;
  end;
  for i:=1 to k do
    if zerocan[p[i,v]] then begin
       dfs:=true;
       zerocan[v]:=true;
       exit;
    end
    else if (not mark[p[i,v]]) and (dfs(p[i,v])) then begin
      dfs:=true;
      zerocan[v]:=true;
      exit;
    end;
  dfs:=false;
end;

function dfs2(a,b:integer):boolean;
var i:integer;
begin
  bmark[a,b]:=true;
  if a=b then begin
    dfs2:=true;
    exit;
  end;
  for i:=1 to k do
    if can[p[i,a],p[i,b]] then begin
      dfs2:=true;
      can[a,b]:=true;
      exit;
    end
    else begin
      if not bmark[p[i,a],p[i,b]] and dfs2(p[i,a],p[i,b]) then begin
          dfs2:=true;
          can[a,b]:=true;
          exit;
      end;
    end;
    dfs2:=false;
end;

procedure solve;
var i,j:integer;
begin
  readln(n,k);
  fillchar(q,sizeof(q),0);
  fillchar(p,sizeof(p),0);
  fillchar(inzero,sizeof(inzero),0);
  fillchar(can,sizeof(can),0);
  fillchar(zerocan,sizeof(zerocan),0);
  inzero[0]:=true;
  zerocan[0]:=true;
  for i:=0 to n-1 do begin
    can[i,i]:=true;
    q[i,i]:=true;
  end;
  for i:=1 to k do
  for j:=0 to n-1 do
  read(p[i,j]);
  for i:=1 to n-1 do
  if not zerocan[i] then begin
     fillchar(mark,sizeof(mark),0);
     if not dfs(i) then begin
       writeln('NO');
       exit;
     end;
  end;
  for i:=0 to n-1 do
  for j:=0 to n-1 do
  if not can[i,j] then begin
    fillchar(bmark,sizeof(bmark),0);
    if not dfs2(i,j) then begin
        writeln('NO');
        exit;
     end;
  end;
  writeln('YES');
end;

var t,_:integer;
begin
  assign(input,'bit2.in');
  assign(output,'bit2.out');
  reset(input);
  rewrite(output);
  read(t);
  for _:=1 to t do begin

    solve;
  end;
  close(input);
  close(output);
end.
