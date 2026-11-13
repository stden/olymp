Program prg;

const
  taskname = 'segments';

type
  integer = longint;

var
  i, j, k: integer;
  n, t: integer;
  lc, rc, lc2, rc2: array[0..50010] of integer;
  depth, max, maxx: integer;
  r: integer;

procedure swap(a, b: integer);
  var
    t: integer;

  begin
    t:=lc[a];
    lc[a]:=lc[b];
    lc[b]:=t;
    t:=rc[a];
    rc[a]:=rc[b];
    rc[b]:=t;
  end;

procedure qsort(l, r: integer);
  var
    lh, rh: integer;

  begin
    lh:=l;
    rh:=r;
    while (lh<rh) do begin
      while (lh<rh) and (lc[lh] <= lc[rh]) do inc(lh);
      swap(lh, rh);
      while (lh<rh) and (lc[lh] <= lc[rh]) do dec(rh);
      swap(lh, rh);
    end;
    if (lh-l)>1 then qsort(l, lh-1);
    if (r-rh)>1 then qsort(rh+1, r);
  end;

procedure swap2(a, b: integer);
  var
    t: integer;

  begin
    t:=lc2[a];
    lc2[a]:=lc2[b];
    lc2[b]:=t;
    t:=rc2[a];
    rc2[a]:=rc2[b];
    rc2[b]:=t;
  end;

procedure qsort2(l, r: integer);
  var
    lh, rh: integer;

  begin
    lh:=l;
    rh:=r;
    while (lh<rh) do begin
      while (lh<rh) and (rc2[lh] <= rc2[rh]) do inc(lh);
      swap2(lh, rh);
      while (lh<rh) and (rc2[lh] <= rc2[rh]) do dec(rh);
      swap2(lh, rh);
    end;
    if (lh-l)>1 then qsort2(l, lh-1);
    if (r-rh)>1 then qsort2(rh+1, r);
  end;


{procedure add(i, de: integer);
  begin
    while (i < n) do begin
      inc(d[i], de);
      i:=i or (i+1);
    end;
  end;

function get(i: integer): integer;
  var
    res: integer;
  begin
    while (i >= 0) do begin
      inc(res, d[i]);
      i:=(i and (i+1)) - 1;
    end;
  end;
}
begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n);
  for i:=1 to n do begin
    READ(j, k);
    if (j > k) then begin
      t:=j;
      j:=k;
      k:=t;
    end;
    lc[i]:=j;
    rc[i]:=k;
    lc2[i]:=j;
    rc2[i]:=k;
  end;
  qsort(1, n);
  qsort2(1, n);
  max:=0;
  maxx:=0;
  depth:=0;
  r:=1;
  for i:=1 to n do begin
    inc(depth);
    while (r <= n) and (rc2[r] < lc[i]) do begin
      dec(depth);
      inc(r);
    end;
    if (depth > max) then begin
      max:=depth;
      maxx:=lc[i];
    end;
  end;

  writeln(max, ' ', maxx);

  close(input);
  close(output);
end.
