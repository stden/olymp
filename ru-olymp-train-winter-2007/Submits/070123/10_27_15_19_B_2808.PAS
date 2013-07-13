program omax;

{$MODE DELPHI}
{$M 16000000}
{$Q-,R-,S-,I-}

const
  MAXN = 200200;
  MAXM = 400400;

var
  n, i, j, k, v, m, c: Integer;
  h, p, a1, a2, ans: array [0..MAXN] of Integer;
  a, next: array [0..MAXM] of Integer;
  b: array [0..MAXN] of Boolean;
  f: array [0..MAXN, 0..1] of Integer;

procedure dfs(v, u: Integer);
var
  i: Integer;
begin
  if b[v] then
    begin
      Write('NO');
      Close(input);
      Close(output);
      halt(0);
    end;
  b[v] := true;
  i := h[v];
  while i > 0 do
    begin
      if a[i] <> u then
        dfs(a[i], v);
      i := next[i];
    end;
end;

procedure dfs2(v, u: Integer);
var
  i, k: Integer;
begin
  b[v] := true;
  i := h[v];
  k := 0;
  while i > 0 do
    begin
      if a[i] <> u then
        begin
          dfs2(a[i], v);
          inc(k, f[a[i],1]);
        end;
      i := next[i];
    end;
  f[v,0] := k;
  f[v,1] := k;
  i := h[v];
  while i > 0 do
    begin
      if a[i] <> u then
        if f[v,1] < k - f[a[i],1] + f[a[i],0] + 1 then
          begin
            f[v,1] := k - f[a[i],1] + f[a[i],0] + 1;
            p[v] := a[i];
          end;
      i := next[i];
    end;
end;

procedure dfs3(v, u, s: Integer);
var
  i: Integer;
begin
  b[v] := true;
  i := h[v];
  while i > 0 do
    begin 
      if a[i] <> u then
        if (s = 1) and (p[v] = a[i]) then
          begin
            inc(m);
            if v < a[i] then
              begin
                a1[m] := v;
                a2[m] := a[i];
              end
            else
              begin
                a1[m] := a[i];
                a2[m] := v;
              end;
            dfs3(a[i], v, 0);
          end
        else
          dfs3(a[i], v, 1);
      i := next[i];
    end;
end;

begin
  Assign(input, 'omax.in');
  Assign(output, 'omax.out');
  Reset(input); Rewrite(output);

  Read(n);
  c := 0; m := 0;
  fillchar(h, sizeof(h), 0);
  for i := 1 to n do
    begin
      Read(k);
      inc(m, k);
      if m >= 2*n then
        begin
          Write('NO');
          Close(input);
          Close(output);
          halt(0);
        end;
      for j := 1 to k do
        begin
          Read(v);
          inc(c);
          a[c] := n+v;
          next[c] := h[i];
          h[i] := c;
          inc(c);
          a[c] := i;
          next[c] := h[n+v];
          h[n+v] := c;
        end;
    end;

  fillchar(b, sizeof(b), 0);
  for i := 1 to 2*n do
    if not b[i] then
      dfs(i, 0);

  fillchar(b, sizeof(b), 0);
  fillchar(f, sizeof(f), 0);
  fillchar(p, sizeof(p), 0);
  m := 0;
  for i := 1 to 2*n do
    if not b[i] then
      begin
        dfs2(i, 0);
        inc(m, f[i,1]);
      end;

  if m = n then
    begin
      WriteLn('YES');
      fillchar(b, sizeof(b), 0);
      m := 0;
      for i := 1 to 2*n do
        if not b[i] then
          dfs3(i, 0, 1);
      for i := 1 to m do
        ans[a1[i]] := a2[i]-n;
      for i := 1 to n do
        Write(ans[i], ' ');
    end
  else
    Write('NO');

  Close(input);
  Close(output);
end.