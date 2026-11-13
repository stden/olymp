program biconn;

{$MODE DELPHI}
{$M 16000000}

const
  MAXN = 100000;

type
  TArr = array [0..MAXN] of Integer;

var
  n, i, u, v, m, root: Integer;
  a0, next0, h0, a, next, h, f, leaf: TArr;
  b: array [0..MAXN] of Boolean;

function dfs(v: Integer): Boolean;
var
  u: Integer;
begin
  Result := false;
  if b[v] then exit;
  b[v] := true;
  Result := true;
  u := h0[v];
  while u > 0 do
    begin
      if dfs(a0[u]) then
        begin
          inc(m);
          a[m] := a0[u];
          next[m] := h[v];
          h[v] := m;
        end;
      u := next0[u];
    end;
end;

function count(v: Integer): Integer;
var
  u: Integer;
begin
  if h[v] = 0 then
    begin
      Result := 1;
      inc(m);
      leaf[m] := v;
    end
  else
    begin
      Result := 0;
      u := h[v];
      while u > 0 do
        begin
          inc(Result, count(a[u]));
          u := next[u];
        end;
    end;
  f[v] := Result;
end;

begin
  Assign(input, 'biconn.in');
  Assign(output, 'biconn.out');
  Reset(input); Rewrite(output);

  Read(n);
  if n = 1 then
    begin
      Write(0);
      Close(input); Close(output);
      halt(0);
    end;
  if n = 2 then
    begin
      WriteLn(1);
      Write('1 2');
      Close(input); Close(output);
      halt(0);
    end;

  fillchar(h0, sizeof(h0), 0);
  for i := 1 to n-1 do
    begin
      Read(u, v);
      a0[2*i-1] := v;
      next0[2*i-1] := h0[u];
      h0[u] := 2*i-1;
      a0[2*i] := u;
      next0[2*i] := h0[v];
      h0[v] := 2*i;
    end;

  fillchar(h, sizeof(h), 0);
  fillchar(b, sizeof(b), 0);
  m := 0;
  root := 0;
  for i := 1 to n do
    if next0[h0[i]] > 0 then
      root := i;
  dfs(root);

  m := 0;
  count(root);

  if odd(m) then
    begin
      inc(m);
      leaf[m] := root;
    end;

  WriteLn(m div 2);
  for i := 1 to m div 2 do
    WriteLn(leaf[i], ' ', leaf[m-i+1]);

  Close(input);
  Close(output);
end.