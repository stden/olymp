program omax;

{$MODE DELPHI}

const
  MAXN = 200000;
  MAXM = 600000;

var
  n, i, j, k, v, u, c, len: Integer;
  h, p ,q, heap, ans: array [0..MAXN] of Integer;
  a, next: array [0..MAXM] of Integer;
  b: array [0..MAXN] of Boolean;

procedure swap(i, j: Integer);
var
  tmp: Integer;
begin
  tmp := heap[i]; heap[i] := heap[j]; heap[j] := tmp;
  tmp := q[i]; q[i] := q[j]; q[j] := tmp;
  p[q[i]] := i; p[q[j]] := j;
end;

function up(v: Integer): Integer;
begin
  while (v > 1) and (heap[v] < heap[v shr 1]) do
    begin
      swap(v, v shr 1);
      v := v shr 1;
    end;
  up := v;
end;

procedure down(v: Integer);
begin
  while (2*v < len) and ((heap[v] > heap[2*v]) or (heap[v] > heap[2*v+1])) do
    if heap[2*v] < heap[2*v+1] then
      begin
        swap(v, 2*v);
        v := 2*v;
      end
    else
      begin
        swap(v, 2*v+1);
        v := 2*v+1;
      end;
  if (2*v = len) and (heap[v] > heap[len]) then
    swap(v, len);

end;

function get(): Integer;
begin
  get := q[1];
  swap(1, len);
  dec(len);
  down(1)
end;

procedure remove(v: Integer);
begin
  swap(v, len);
  dec(len);
  down(up(v));
end;

begin
  Assign(input, 'omax.in');
  Assign(output, 'omax.out');
  Reset(input); Rewrite(output);

  Read(n);
  fillchar(h, sizeof(h), 0);
  fillchar(heap, sizeof(heap), 0);
  len := 2*n;
  for i := 1 to 2*n do
    begin
      p[i] := i;
      q[i] := i;
    end;
  c := 0;
  for i := 1 to n do
    begin
      Read(k);
      for j := 1 to k do
        begin
          Read(v);
          inc(c);
          inc(heap[i]);
          a[c] := n+v;
          next[c] := h[i];
          h[i] := c;
          inc(c);
          inc(heap[n+v]);
          a[c] := i;
          next[c] := h[n+v];
          h[n+v] := c;
        end;
    end;

  for i := 1 to 2*v do
    up(i);

  fillchar(b, sizeof(b), 0);
  for i := 1 to n do
    begin
      if heap[1] <> 1 then
        begin
          Write('NO');
          Close(input);
          Close(output);
          halt(0);
        end;
      v := get();
      j := h[v];
      while b[a[j]] do
        j := next[j];
      u := a[j];
      remove(p[u]);

      if u < v then
        ans[u] := v-n
      else
        ans[v] := u-n;

      b[v] := true;
      b[u] := true;
      j := h[u];
      while j > 0 do
        begin
          if not b[a[j]] then
            begin
              dec(heap[p[a[j]]]);
              down(up(p[a[j]]));
            end;
          j := next[j];
        end;
      j := h[v];
      while j > 0 do
        begin
          if not b[a[j]] then
            begin
              dec(heap[p[a[j]]]);
              down(up(p[a[j]]));
            end;
          j := next[j];
        end;
    end;

  WriteLn('YES');
  for i := 1 to n do
    Write(ans[i], ' ');

  Close(input);
  Close(output);
end.
