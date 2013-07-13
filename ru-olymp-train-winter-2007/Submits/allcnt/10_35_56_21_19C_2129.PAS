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
  nxt, lst: array[0..4000100] of integer;
  free: integer;
  col: array[0..100100] of integer;

  p: array[0..100100] of integer;
  l: array[0..100100] of integer;

  res: integer;
  r1, r2: array[0..1000100] of integer;
  gg: array[0..100100] of integer;
  gb: boolean;
  a, b: integer;
  was, cannot: array[0..100100] of boolean;

  enter, leave: array[0..100100] of integer;
  stok, istok, fr: array[0..100100] of integer;
  par: array[0..100100] of integer;
  rrr: array[0..100100] of integer;

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

    dfs:=res;
    col[get(v)]:=0;
  end;

procedure dfs2(v, q: integer);
  var
    u: integer;

  begin
    u:=get(v);
    while (hasnext(u)) do begin
      u:=next(u);
      if (get(reb[u]) <> get(v)) then
      dfs2(get(reb[u]), q);
    end;
    if (not hasNext(get(v))) then begin
      par[v]:=q;
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
    fillchar(was, sizeof(was), 0);
    rrr[0]:=0;
    while (hasNext(u)) do begin
      u:=next(u);
      if (not was[get(reb[u])]) and (get(reb[u]) <> i) then begin
        inc(rrr[0]);
        rrr[rrr[0]]:=get(reb[u]);
        was[get(reb[u])]:=true;
      end;
    end;
    nxt[i]:=-1;
    lst[i]:=-1;
    for j:=1 to rrr[0] do begin
      add(i, rrr[j]);
    end;
  end;

  for i:=1 to n do begin
    if (get(i) = i) then begin
      u:=i;
      while (hasNext(u)) do begin
        u:=next(u);
        inc(enter[reb[u]]);
        inc(leave[i]);
      end;
    end;
  end;
  for i:=1 to n do if (get(i) = i) then begin
    if (enter[i] = 0) and (leave[i] = 0) then begin
      inc(fr[0]);
      fr[fr[0]]:=i;
    end else
    if (enter[i] = 0) then begin
      inc(stok[0]);
      stok[stok[0]]:=i;
    end else
    if (leave[i] = 0) then begin
      inc(leave[0]);
      leave[leave[0]]:=i;
    end;
  end;


  for i:=1 to n do begin
    if (get(i) = i) and (enter[i] = 0) then begin
      dfs2(i, i);
    end;
  end;

  res:=0;
  fillchar(was, sizeof(was), false);
  for i:=1 to stok[0] do if (not was[par[stok[i]]]) then begin
    was[par[stok[i]]]:=true;
    for j:=1 to istok[0] do if (not was[istok[j]]) then begin
      cannot[stok[i]]:=true;
      was[istok[j]]:=true;
      inc(res);
      r1[res]:=stok[i];
      r2[res]:=istok[j];
      break;
    end;
  end;
  for i:=1 to stok[0] do begin
    if not cannot[stok[i]] then begin
      inc(fr[0]);
      fr[fr[0]]:=stok[i];
    end;
  end;

  for i:=1 to istok[0] do begin
    if not was[istok[i]] then begin
      inc(fr[0]);
      fr[fr[0]]:=istok[i];
    end;
  end;

  for i:=1 to fr[0]-1 do begin
    inc(res);
    r1[res]:=fr[i];
    r2[res]:=fr[i+1];
  end;
  if (fr[0]>0) and (stok[0] > 0)then begin
    inc(res);
    r1[res]:=fr[fr[0]];
    r2[res]:=par[stok[1]];
  end else
  begin
    inc(res);
    r1[res]:=fr[fr[0]];
    r2[res]:=fr[1];
  end;

  writeln(res);
  for i:=1 to res do begin
    writeln(r1[i], ' ', r2[i]);
  end;
  close(input);
  close(output);
end.
