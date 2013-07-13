{$O-,Q+,R+}
uses sysutils, math;

var
  i, j, n, m, ii, jj, kk: integer;
  d, hd: array[1..30000] of integer;
  z: array[1..30000] of boolean;
  nx, ds, c: array[1..800000] of integer;
  h, ph: array[1..30000] of integer;
  min: integer;
  l, nh: integer;


procedure add(i, j, k: integer);
begin
  inc(l);
  nx[l] := hd[i];
  ds[l] := j;
  c[l] := k;
  hd[i] := l; 
end;

procedure swap(i, j: integer);
var
  t: integer;
begin
  t := h[i];
  h[i] := h[j];
  h[j] := t;
  ph[h[i]] := i;
  ph[h[j]] := j;
end;

procedure siftup(i: integer);
var
  ii: integer;
begin
  while i > 1 do begin
    ii := i shr 1;
    if d[h[ii]] <= d[h[i]] then exit;
    swap(ii, i);
    i := ii;
  end;
end;

procedure siftdown(i: integer);
var
  ii: integer;
begin
  while i shl 1 <= nh do begin
    ii := i;
    if d[h[i shl 1]] < d[h[ii]] then ii := i shl 1;
    if (i shl 1 + 1 <= nh) and (d[h[i shl 1 + 1]] < d[h[ii]]) then ii := i shl 1 + 1;
    if ii = i then exit;
    swap(i, ii);
    i := ii;
  end;
end;

procedure insert(i: integer);
begin
  inc(nh);
  h[nh] := i;
  ph[i] := nh;
  siftup(nh);
end;

procedure delmin;
begin
  swap(1, nh);
  dec(nh);
  siftdown(1);
end;

var
  dd: integer;

begin
  assign(input, 'path.in');
  reset(input);
  assign(output, 'path.out');
  rewrite(output);

  read(n, m);
  for i := 1 to m do begin
    read(ii, jj, kk);
    add(ii, jj, kk);
    add(jj, ii, kk);
  end;

  d[1] := 0;
  for i := 2 to n do d[i] := 1000000000;
  nh := 0;
  for i := 1 to n do insert(i);

  while nh > 0 do begin
    i := h[1];
    if d[i] = 1000000000 then break;
    delmin;
    j := hd[i];
    while j <> 0 do begin
      dd := d[i] + c[j];
      if d[ds[j]] > dd then begin
        d[ds[j]] := dd;
        siftup(ph[ds[j]]);
      end;
      j := nx[j];
    end;
  end;

  for i := 1 to n do assert(d[i] < 1000000000);
  for i := 1 to n do write(d[i],' ');
end.