Program prg;

const
  taskname = 'tourism';

type
  integer = longint;

label nextiter;

function max(a, b: word): word;
  begin
    if (a >= b) then max:=a else max:=b;
  end;

var
  i, j, k, a, b, c, d :integer;
  n: integer;
  s, s2: string;
  mat: array[0..4010, 0..4010] of boolean;
//  arr: array[0..4010, 0..4010] of word;
  qq: integer;

  st, fi: integer;
  queue: array[0..4010] of word;
  maxl, maxa, maxb: word;
  path: array[0..4010] of word;
  allenter: integer;
  was: array[0..4010] of boolean;

  ress: array[0..2001, 0..4010] of word;
  resl: array[2001..4010, 0..4010]  of word;
  enter: array[0..4010] of integer;

  good, only: integer;


{procedure swap(var a, b: integer);
  var
    t: integer;

  begin
    t:=a;
    a:=b;
    b:=t;
  end;

procedure qsort(l, r: integer);
  var
    lh, rh: integer;

  begin
    lh:=l;
    rh:=r;
    while (lh<rh) do begin
      while (lh<rh) and (queries[lh] <= queries[rh]) do inc(lh);
      swap(queries[lh], queries[rh]);
      while (lh<rh) and (queries[lh] <= queries[rh]) do dec(rh);
      swap(queries[lh], queries[rh]);
    end;
    if (lh-l)>1 then qsort(l, lh-1);
    if (r-rh)>1 then qsott(rh+1, r);
  end;
 }

procedure add(v, u: integer);
  begin
    mat[v][u]:=true;
  end;

function dfs(v: integer): boolean;
  var
    i: integer;

  begin
    was[v]:=true;
    if (mat[v][1]) then begin
      path[0]:=2;
      path[1]:=1;
      path[2]:=v;
      dfs:=true;
      exit;
    end;
    for i:=1 to n do begin
      if mat[v][i] then begin
        if (dfs(i)) then begin
          inc(path[0]);
          path[path[0]]:=v;
          dfs:=true;
          exit;
        end;
      end;
    end;
    dfs:=false;
  end;

procedure insert(v, where: integer);
  var
    i: integer;
  begin
    inc(path[0]);
    for i:=where+1 to path[0]-1 do begin
      path[i+1]:=path[i];
    end;
    path[where+1]:=v;

    for i:=1 to n do begin
      if (not was[i]) and (mat[v][i]) then inc(enter[i]);
    end;
  end;

procedure insert_free(v, where: integer);
  var
    i: integer;

  begin
    for i:=1 to n do begin
      if (not was[i]) and (mat[v][i]) then inc(enter[i]);
    end;
    path[where]:=v;
  end;

procedure delete(v: integer);
  var
    i: integer;

  begin
    for i:=1 to n do if (not was[i]) and (mat[v][i]) then begin
      dec(enter[i]);
    end;
    for i:=1 to path[0] do if mat[path[i]][v] then inc(enter[v]);
  end;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

//  for i:=1 to 4010 do a[i]:=-1;
//  for i:=0 to 8010 do nxt[i]:=-1;

  readln(n);
  readln(s);
  s2:='';

  k:=0;
  for i:=1 to length(s) do begin
    if (s[i] >= '0') and (s[i] <= '9') then begin
      qq:=ord(s[i])-ord('0');
    end else
    if (s[i] >= 'A') and (s[i] <= 'Z') then begin
      qq:=ord(s[i]) - ord('A') + 10;
    end else
    if (s[i] >= 'a') and (s[i] <= 'z') then begin
      qq:=ord(s[i]) - ord('a') + 36;
    end else
    if (s[i] = '!') then
      qq:=62
    else
      qq:=63;

      for j:=0 to 5 do begin
        if (qq and (1 shl j)) > 0  then begin
          s2:=s2+'1';
        end else begin
          s2:=s2+'0';
        end;
      end;

    while (k < n-1) and (length(s2) >= n-k-1) do begin
      for j:=1 to n-k-1 do begin
        if (s2[j] = '1') then begin
          add(k+1, j+k+1);
        end else
          add(j+k+1, k+1);
      end;
      s2:=copy(s2, n-k, length(s2) - n + k + 1);
      inc(k);
    end;
  end;


{  for i:=1 to n do begin
    for j:=1 to n do if (i<>j) then d[j]:=10000 else d[j]:=0;
    st:=1;
    fi:=1;
    queue[1]:=i;
    while (st <= fi) do begin
      k:=queue[st];
      inc(st);
      j:=a[k];
      while (j <> -1) do begin
        if (d[reb[j]] <> 10000) then begin
          j:=nxt[j];
          continue;
        end else begin
          d[reb[j]]:=d[k]+1;
          inc(fi);
          queue[fi]:=reb[j];
          j:=nxt[j];
        end;
      end;
    end;
  end;
 }


{  maxl:=0;
  for i:=1 to n do begin
    for j:=1 to n do if (j<>i) then begin
      d[j]:=-1;
    end;
    dfs(i);
    u:=a[i];
    while (u<>-1) do begin
      if (d[reb[u]]+1 > maxl) then begin
        maxl:=d[reb[u]]+1;
        maxa:=i;
        maxb:=reb[u];
      end;
    end;
  end;
 }
  /// la la la

  dfs(1);
  a:=path[2];
  b:=path[3];
  path[0]:=3;
  path[1]:=1;
  path[2]:=b;
  path[3]:=a;
  ress[3]:=path;
  fillchar(was, sizeof(was), 0);
  was[1]:=true;
  was[a]:=true;
  was[b]:=true;

  fillchar(enter, sizeof(enter), 0);
  for i:=1 to path[0] do begin
    for j:=1 to n do if ((not was[j]) and mat[path[i]][j]) then begin
      inc(enter[j]);
    end;
  end;

  for i:=4 to n do begin
    good:=-1;

    for j:=1 to n do begin
      if (not was[j]) and (enter[j] <> path[0]) then begin
        only:=j;
        if (enter[j] <> 0) then begin
          good:=j;
          break;
        end;
      end else begin
        allenter:=j;
      end;
    end;

    if (good = -1) then begin
      good:=only;
    end;

    if (enter[good] = 0) then begin

      was[path[2]]:=false;
      delete(2);

      was[allenter]:=true;
      was[good]:=true;

      insert_free(allenter, 2);
      path[2]:=allenter;
      insert(good, 2);

      if (mat[allenter][2]) then inc(enter[2]);
      if (mat[good][2]) then inc(enter[2]);

      goto nextiter;

    end else begin
      for j:=1 to path[0] do begin
        if (mat[j][good]) and (mat[good][(j mod path[0]) + 1]) then begin
          insert(good, j);
          was[good]:=true;
          goto nextiter;
        end;
      end;
    end;

    nextiter:
    if (i <= 2000) then ress[i]:=path else resl[i]:=path;

  end;


  read(k);
  for i:=1 to k do begin
    read(j);
    if (j <= 2000) then begin
      if (ress[j][0] = 0) then writeln('-1') else
      begin
        for i:=1 to ress[j][0] do begin
          write(ress[j][i]-1, ' ');
        end;
        writeln;
      end;

    end else begin
      if (resl[j][0] = 0) then writeln('-1') else
      begin
        for i:=1 to resl[j][0] do begin
          write(resl[j][i]-1, ' ');
        end;
        writeln;
      end;
    end;
  end;



  close(input);
  close(output);
end.
