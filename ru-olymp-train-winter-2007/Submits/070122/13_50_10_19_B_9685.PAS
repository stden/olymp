program taskb;

{$MODE DELPHI}
{$Q-,R-,S-,I-}

const
  MAXN = 201;
  MAXC = 10010;

var
  n, r, ans, s, i: Integer;
  c, a, w, k: array [0..MAXN] of Integer;
  f, g: array [0..MAXN, 0..MAXC] of Integer;
  t: array [0..MAXN, 0..MAXN] of Integer;

procedure count(v: Integer);
var
  i, j, q: Integer;
begin
  for i := 1 to k[v] do
    count(t[v,i]);

  fillchar(g, sizeof(g[0]) * (k[v]+3), $0F); // sux
  g[1,0] := 0;
  for i := 1 to k[v] do
    for j := 0 to s do
      begin
        if g[i+1,j] > g[i,j] then
          g[i+1,j] := g[i,j];
        for q := 0 to s-j do
          if g[i+1,j+q] > g[i,j] + f[t[v,i],q] then
            g[i+1,j+q] := g[i,j] + f[t[v,i],q];
      end;     

  for j := 0 to c[v]-a[v] do
    f[v,j+a[v]] := g[k[v]+1,j] + w[v];

  for j := c[v]-a[v]+1 to s-a[v] do
    f[v,j+a[v]] := g[k[v]+1,j];
end;

begin
  Assign(input, 'system.in');
  Assign(output, 'system.out');
  Reset(input); Rewrite(output);

  Read(n);
  s := 0;
  fillchar(k, sizeof(k), 0);
  for i := 1 to n do
    begin
      Read(r, c[i], a[i], w[i]);
      inc(s, a[i]);
      inc(k[r]);
      t[r,k[r]] := i;
    end;
  if s > MAXC then
    s := MAXC;

  fillchar(f, sizeof(f), $0F);
  count(1);
  ans := f[1,0];
  for i := 1 to MAXC do
    if ans > f[1,i] then
      ans := f[1,i];
  Write(ans);

  Close(input);
  Close(output);
end.