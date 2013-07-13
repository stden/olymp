Program prg;

const
  taskname = 'omax';

type
  integer = longint;

var
  i, j, k, l, m: integer;
  reb, nxt: array[0..300100] of integer;
  a, lst: array[0..100100] of integer;
  n: integer;
  free: integer;
  was: array[0..100100] of boolean;
  px, py: array[0..100100] of integer;

procedure add(v, u: integer);
  begin
    if (a[v] = -1) then begin
      a[v]:=free;
      lst[v]:=free;
      reb[free]:=u;
      inc(free);
    end else begin
      nxt[lst[v]]:=free;
      lst[v]:=free;
      reb[free]:=u;
      inc(free);
    end;
  end;

function dfs(v: integer): boolean;
  var
    u: integer;

  begin
    was[v]:=true;
    u:=a[v];
    while (u<>-1) do begin
      if (py[reb[u]] = 0) or ((not was[py[reb[u]]]) and (dfs(py[reb[u]]))) then begin
        px[v]:=reb[u];
        py[reb[u]]:=v;
        dfs:=true;
        exit;
      end;
      u:=nxt[u];
    end;
    dfs:=false;
  end;

function dfs2(v, prev: integer): boolean;
  var
    u: integer;

  begin
    was[v]:=true;
    u:=a[v];
    while (u<>-1) do begin
      if (py[reb[u]] = 0) or  (was[py[reb[u]]] and (py[reb[u]] <> prev) and (py[reb[u]] <> v)) or ((not was[py[reb[u]]]) and (dfs2(py[reb[u]], v))) then begin
        px[v]:=reb[u];
        py[reb[u]]:=v;
        dfs2:=true;
        exit;
      end;
      u:=nxt[u];
    end;
    dfs2:=false;
  end;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  for i:=1 to 100100 do a[i]:=-1;
  for i:=0 to 300100 do nxt[i]:=-1;

  read(n);
  for i:=1 to n do begin
    read(k);
    for j:=1 to k do begin
      read(l);
      add(i, l);
    end;
  end;

  for i:=1 to n do begin
    fillchar(was, sizeof(was), 0);
    dfs(i);
  end;

  for i:=1 to n do begin
    if (i <> py[px[i]]) then begin
      writeln('NO');
      close(output);
      halt(0);
    end;
  end;

  for i:=1 to n do begin
    fillchar(was, sizeof(was), 0);
    if (dfs2(i, -1)) then begin
      writeln('NO');
      close(output);
      halt(0);
    end;
  end;

  writeln('YES');
  for i:=1 to n do write(px[i], ' ');
  writeln;

  close(input);
  close(output);
end.
