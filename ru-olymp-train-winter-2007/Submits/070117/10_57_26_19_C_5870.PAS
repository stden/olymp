program restore;

{$MODE DELPHI}
{$Q-,R-,S-,I-}

const
  MAXN   = 30;
  INF    = $0F0F0F0F;

type
  TArr   = array [0..MAXN] of Integer;
  TArr2d = array [0..MAXN] of TArr;

var
  n, m, p, i, j, k, u, v, t, q, ai, bi, ans: Integer;
  a, a0, s, r: TArr2d;
  f, f0: TArr;

function mul(a, b: Integer): Integer;
begin
  Result := (Int64(a) * Int64(b)) mod p;
end;

procedure mmul(var a: TArr2d; const b: TArr2d);
var
  i, j, k: Integer;
  r: TArr2d;
begin
  fillchar(r, sizeof(r), 0);
  for i := 1 to n do
    for j := 1 to n do
      for k := 1 to n do
        r[i,j] := (r[i,j] + mul(a[k,j], b[i,k])) mod p;
  a := r;
end;

procedure step(dist, num: Integer);
var
  i, j: Integer;
begin
  fillchar(s, sizeof(s), 0);
  for i := 1 to n do
    if a[u,i] <> dist then
      s[i,i] := 1;
  for i := 1 to n do
    for j := 1 to n do
      if (a[u,i] = dist) and (a[u,j] = dist) then
        s[i,j] := a0[i,j] mod p;

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
      f[i] := (f[i] + mul(r[i,j], f0[j])) mod p;
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
  for q := 1 to t do
    begin
      Read(ai, bi);
      step(ai, bi);
    end;

  ans := 0;
  for i := 1 to n do
    ans := (ans + f[i]) mod p;
  Write(ans);

  Close(input);
  Close(output);
end.
