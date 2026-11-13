Program prg;

const
  taskname = 'republic';

type
  integer = longint;

var
  i, j, k, u: integer;
  n, m: integer;
  arr: array[0..100001] of integer;
  reb: array[0..1000100] of integer;
  nxt, lst: array[0..1000100] of integer;
  free: integer;
  col: array[0..100100] of integer;

  p: array[0..100100] of integer;
  l: array[0..100100] of integer;

  res: integer;
  r1, r2: array[0..1000100] of integer;
  gg: array[0..100100] of integer;
  gb: boolean;
  a, b: integer;
  was: array[0..100100] of boolean;

procedure union(a, b: integer);
  begin
   { if (l[a] > l[b]) then begin
      p[b]:=a;
      l[a]:=l[a]+l[b];
    end else begin
      p[a]:=b;
      l[b]:=l[b]+l[a];
    end;}
    p[a]:=b;
    l[b]:=l[b]+l[a];

  end;

function get(a: integer): integer;
  begin
    if (p[a] <> a) then p[a]:=get(p[a]);
    get:=p[a];
  end;


function hasNext(e: integer): boolean;
  begin
    hasNext:=(nxt[e] <> -1);
  end;

function next(e: integer): integer;
  begin
    next:=nxt[e];
  end;

procedure add(v, w: integer);
  begin
    if (lst[v] = -1) then begin
      nxt[v]:=free;
      lst[v]:=free;
      reb[free]:=w;
      inc(free);
    end else begin
      nxt[lst[v]]:=free;
      lst[v]:=free;
      reb[free]:=w;
      inc(free);
    end;
  end;


function dfs(v, c, prev: integer): integer;
  var
    u, u2, t, res: integer;
  begin
    col[get(v)]:=c;
    res:=2000000;
    u:=get(v);
    while (hasnext(u)) do begin
      u:=next(u);
      if (get(reb[u])=get(v)) then continue;
      u2:=get(reb[u]);

      if (col[u2] = 0) then begin
        t:=dfs(u2, c+1, get(v));
        if (t < c)and(t < res) then begin
          res:=t;
        end;
      end else
      if (col[u2] < c)and(res > col[u2]) then begin
        res:=col[u2];
      end;
    end;

    if (res < c)and(prev<>-1) then begin
      u:=get(v);
      u2:=get(prev);
      if (hasNext(u)) then begin
        nxt[lst[u2]]:=next(u);
        lst[u2]:=lst[get(v)];
        union(get(v), get(u2));
      end;
    end;

    col[get(v)]:=0;
  end;

procedure dfs2(v, q, prev: integer);
  var
    u: integer;

  begin
    u:=get(v);
    while (hasnext(u)) do begin
      u:=next(u);
      if (get(reb[u]) <> get(v)) then
      dfs2(get(reb[u]), q, get(v));
    end;
    u:=get(v);
    if (prev<>-1) then begin
      inc(res);
      r1[res]:=get(v);
      r2[res]:=q;

      u:=get(prev);
      nxt[lst[u]]:=next(get(v));
      lst[u]:=lst[get(v)];
      union(get(v), get(u));
    end;

  end;



begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);



  read(n, m);
  free:=n+1;
  for i:=1 to n do begin
    p[i]:=i;
    l[i]:=1;
  end;
  for i:=1 to 400000 do begin
    lst[i]:=-1;
    nxt[i]:=-1;
  end;
  for i:=1 to m do begin
    read(a, b);
    add(a, b);
  end;

  for i:=1 to n do begin
    dfs(i, 1, -1);
  end;

  for i:=1 to n do if (get(i)=i) then begin
    u:=i;
    while (hasNext(u)) do begin
      u:=next(u);
      while (hasNext(u)) and (get(reb[next(u)]) = get(reb[u])) do begin
        nxt[u]:=next(next(u));
      end;
    end;

    fillchar(was, sizeof(was), 0);
    u:=i;
    while (hasNext(u)) do begin
      u:=next(u);
      was[get(reb[u])]:=true;
    end;
    was[i]:=false;
    lst[i]:=-1;
    nxt[i]:=-1;
    for j:=1 to n do if was[j] then begin
      add(i, j);
    end;
  end;

  fillchar(col, sizeof(col), 0);
  for i:=1 to n do begin
    if (get(i)<>i) then continue;
    u:=i;
    while (hasNext(u)) do begin
      u:=next(u);
      inc(col[get(reb[u])]);
    end;
  end;

  for i:=1 to n do begin
    if (col[i] = 0)and(get(i)=i) then begin
      dfs2(i, i, -1);
    end;
  end;

  for i:=1 to n do begin
    gb:=false;
    for j:=1 to gg[0] do begin
      if (get(i) = gg[j]) then begin
        gb:=true;
        break;
      end;
    end;
    if (not gb) then begin
      inc(gg[0]);
      gg[gg[0]]:=get(i);
    end;
  end;
  for i:=1 to gg[0]-1 do begin
    inc(res);
    r1[res]:=gg[i];
    r2[res]:=gg[i+1];
    inc(res);
    r1[res]:=gg[i+1];
    r2[res]:=gg[i];
  end;

  writeln(res);
  for i:=1 to res do begin
    writeln(r1[i], ' ', r2[i]);
  end;

  close(input);
  close(output);

  end.
