{$Mode Delphi}

var most:array[1..200] of boolean;
    q:array[1..200,1..200] of boolean;
    w:array[1..10000] of record
                           a,b:integer;
                         end;
    mark:array[1..50] of boolean;
    n,m,p:integer;
    i,ans:integer;

procedure dfs(v:integer);
var i:integer;
begin
  mark[v]:=true;
  for i:=1 to n do
    if q[v,i] and not mark[i] then
      dfs(i);
end;


function check:boolean;
var i:integer;
begin
  check:=false;
  fillchar(mark,sizeof(mark),0);
  dfs(1);
  for i:=1 to n do
  if not mark[i] then exit;
  check:=true;
end;

procedure gendel(pos,delc:integer);
begin
  if pos>m then begin
    if m-delc<>n-1 then exit;
    if check then
    inc(ans);
    exit;
  end;

  q[w[pos].a,w[pos].b]:=true;
  q[w[pos].b,w[pos].a]:=true;
  gendel(pos+1,delc);
  if not most[pos] then begin
    q[w[pos].a,w[pos].b]:=false;
    q[w[pos].b,w[pos].a]:=false;
    gendel(pos+1,delc+1);
  end;
end;


begin
  assign(input,'optimum.in');
  assign(output,'optimum.out');
  reset(input);
  rewrite(output);
  read(n,m,p);
  ans:=0;
  for i:=1 to m do begin
    read(w[i].a,w[i].b);
    q[w[i].a,w[i].b]:=true;
    q[w[i].b,w[i].a]:=true;
  end;
  for i:=1 to m do begin
    q[w[i].a,w[i].b]:=false;
    q[w[i].b,w[i].a]:=false;
    if not check then most[i]:=true;
    q[w[i].a,w[i].b]:=true;
    q[w[i].b,w[i].a]:=true;
  end;
  fillchar(q,sizeof(q),0);
  gendel(1,0);
  writeln(ans mod p);
  close(input);
  close(output);
end.
