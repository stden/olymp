program optimum;

{$MODE DELPHI}
{$Q-,R-,S-,I-}

var
  n, m, k, module, i, ans: Integer;
  p, u, v, a, next, h: array [1..200] of Integer;
  b: array [1..200] of Boolean;

procedure dfs(v: Integer);
var
  u: Integer;
begin
  if b[v] then exit;
  b[v] := true;
  u := h[v];
  while u > 0 do
    begin
      dfs(a[u]);
      u := next[u];
    end;
end;

procedure f(q: Integer);
var
  i: Integer;
  pl: Boolean;
begin
  if q > k then
    begin
      fillchar(h, sizeof(h), 0);
      for i := 1 to k do
        begin
          a[2*i-1] := u[p[i]];
          next[2*i-1] := h[v[p[i]]];
          h[v[p[i]]] := 2*i-1;
          a[2*i] := v[p[i]];
          next[2*i] := h[u[p[i]]];
          h[u[p[i]]] := 2*i;
        end;
      fillchar(b, sizeof(b), 0);
      dfs(1);
      pl := true;
      for i := 2 to n do
        if not b[i] then
          begin
            pl := false;
            break;
          end;
      inc(ans, ord(pl));
    end
  else
    for i := p[q-1]+1 to m-k+q do
      begin
        p[q] := i;
        f(q+1);
      end;
end;

begin
  Assign(input, 'optimum.in');
  Assign(output, 'optimum.out');
  Reset(input); Rewrite(output);

  Read(n, m, module);
  for i := 1 to m do
    Read(u[i], v[i]);

  k := n-1;
  ans := 0;
  f(1);
  Write(ans mod module);

  Close(input);
  Close(output);
end.