program game;

{$MODE DELPHI}

const
  MAXN = 15;
  MAXP = 1 shl MAXN;

function getbit(k, i: Integer): Boolean;
begin
  Result := k and (1 shl (i-1)) <> 0;
end;

function killbit(k, i: Integer): Integer;
begin
  Result := k and not (1 shl (i-1));
end;

var
  n, i, j, k, q, q0, p, s, pq: Integer;
  a: array [1..MAXN, 1..MAXN] of Integer;
  b, c: array [1..MAXN, 1..MAXN] of Extended;
  f: array [0..MAXP, 1..MAXN] of Extended;
  x, y: array [1..MAXN] of Extended;
  aa, bb: Extended;

function nxt(k: Integer): Integer;
begin
  if k = n then
    Result := 1
  else
    Result := k+1;
end;

function next(k, p: Integer): Integer;
begin
  Result := k;
  repeat
    Result := nxt(Result)
  until getbit(p, Result);
end;

function prv(k: Integer): Integer;
begin
  if k = 1 then
    Result := n
  else
    Result := k-1;
end;

function prev(k, p: Integer): Integer;
begin
  Result := k;
  repeat
    Result := prv(Result)
  until getbit(p, Result);
end;

begin
  Assign(input, 'game.in');
  Assign(output, 'game.out');
  Reset(input); Rewrite(output);

  Read(n);
  s := 0;
  for i := 1 to n do
    for j := 1 to n do
      Read(a[i,j]);

  for i := 1 to n do
    for j := 1 to n do
      Read(b[i,j]);

  for p := 1 to (1 shl n - 1) do
    if p and (p-1) = 0 then
      for k := 1 to n do
        f[p,k] := 0
    else
      begin
        q := next(k, p);
        for i := 1 to n do
          if getbit(p, i) then
            begin
              s := 0;
              for j := 1 to n do
                if (j <> i) and getbit(p, j) then
                  s := s + a[i,j];
              for j := 1 to n do
                if (j <> i) and getbit(p, j) then
                  c[i,j] := a[i,j] / s;
            end;
              
        q0 := q;
        aa := 0; bb := 1;
        repeat
          x[q] := 0; y[q] := 1;
          for i := 1 to n do
            if (i <> q) and getbit(p, q) then
              begin
                x[q] := x[q] + c[q,i] * b[q,i] * (f[killbit(p, i), q] + 1);
                y[q] := y[q] - c[q,i] * b[q,i];
              end;
          x[q] := x[q] + y[q];
          aa := aa + bb * x[q];
          bb := bb * y[q];
          q := next(q, p);
        until q = q0;

        f[p,q] := aa / (1 - bb);
        pq := q;
        q := prev(q, p);
        repeat
          f[p,q] := x[q] + y[q] * f[p,pq];
          pq := q;
          q := prev(q, p);
        until q = q0;
      end;

  Write(f[1 shl n - 1][n] :0:6);

  Close(input);
  Close(output);
end.