program restore;

{$MODE DELPHI}
{$Q-,R-,S-,I-}

const
  MAXN   = 30;
  INF    = $0F0F0F0F;

type
  TArr   = array [0..MAXN] of Int64;
  TArr2d = array [0..MAXN] of TArr;

var
  n, m, p, i, j, k, u, v, t, q, ai, bi, ans: Integer;
  a, a0, s, r: TArr2d;
  f, f0: TArr;

function mul(a, b: Integer): Integer;
var
  res: Int64;
begin
  res := Int64(a) * Int64(b);
  if res > p then
    res := res mod p;
  Result := res;
end;

procedure mmul(var a: TArr2d; const b: TArr2d);
var
  i, j, k: Integer;
  r: TArr2d;
  q: Int64;
begin
  fillchar(r, sizeof(r), 0);
  for i := 1 to n do
    for j := 1 to n do
      for k := 1 to n do
        begin
          q := Int64(a[k,j]) * Int64(b[i,k]) + r[i,j];
          if q > p then
            q := q mod p;
//          r[i,j] := (r[i,j] + mul(a[k,j], b[i,k])) mod p;
          r[i,j] := q;
        end;
  a := r;
end;

procedure step(dist, num: Integer);
var
  i, j: Integer;
  q: Int64;
begin
  fillchar(s, sizeof(s), 0);
  for i := 1 to n do
    for j := 1 to n do
      if (a[u,i] = dist) and (a[u,j] = dist) then
        s[i,j] := a0[i,j];

  fillchar(r, sizeof(r), 0);
  for i := 1 to n do
    r[i,i] := 1;
  while num > 0 do
    begin
      if odd(num) then
        mmul(r, s);
      mmul(s, s);
      num := num shr 1;
    end;

  f0 := f;
  fillchar(f, sizeof(f), 0);
  for i := 1 to n do
    for j := 1 to n do
      begin
        q := Int64(r[i,j]) * Int64(f0[j]) + f[i];
        if q > p then
          q := q mod p;
        f[i] := q;
      end;
end;

begin
  Assign(input, 'restore.in');
  Assign(output, 'restore.out');
  Reset(input); Rewrite(output);

  Read(n, m, p);
  fillchar(a, sizeof(a), $0F);
  fillchar(a0, sizeof(a0), 0);
  for i := 1 to n do
    a[i,i] := 0;
  for i := 1 to m do
    begin
      Read(u, v);
      inc(a0[u,v]);
      inc(a0[v,u]);
      a[u,v] := 1;
      a[v,u] := 1;
    end;
  Read(u);

  for k := 1 to n do
    for i := 1 to n do
      for j := 1 to n do
        if a[i,j] > a[i,k] + a[k,j] then
          a[i,j] := a[i,k] + a[k,j];

  Read(t, ai, bi);
  fillchar(f, sizeof(f), 0);
  for i := 1 to n do
    if a[u,i] = ai then
      f[i] := 1;
  step(ai, bi-1);
  for q := 2 to t do
    begin
      Read(ai, bi);
      f0 := f;
      fillchar(f, sizeof(f), 0);
      for i := 1 to n do
        if a[u,i] = ai then
          for j := 1 to n do
            f[i] := (f[i] + mul(f0[j], a0[i,j])) mod p;

      step(ai, bi-1);
    end;

  ans := 0;
  for i := 1 to n do
    ans := (ans + f[i]) mod p;
  Write(ans);

  Close(input);
  Close(output);
end.
