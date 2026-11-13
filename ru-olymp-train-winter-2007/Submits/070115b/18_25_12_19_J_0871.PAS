program taskj;

{$Q-,R-,S-,I-}

type
  Integer = Longint;

const
  MAXN = 30000;
  MAXM = 800000;
  INF  = 500000000;

var
  a, w, next: array [1..MAXM] of Integer;
  h, d, heap, p, q: array [1..MAXN] of Integer;
  n, m, i, j, u, v, c, len: Integer;

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

begin
  Assign(input, 'path.in');
  Assign(output, 'path.out');
  Reset(input); Rewrite(output);

  Read(n, m);
  fillchar(h, sizeof(h), 0);
  for i := 1 to m do
    begin
      Read(u, v, c);
      a[2*i-1] := v;
      w[2*i-1] := c;
      next[2*i-1] := h[u];
      h[u] := 2*i-1;

      a[2*i] := u;
      w[2*i] := c;
      next[2*i] := h[v];
      h[v] := 2*i;
    end;

  d[1] := 0;
  heap[1] := 0;
  p[1] := 1;
  q[1] := 1;
  len := n;
  for i := 2 to n do
    begin
      d[i] := INF;
      heap[i] := INF;
      p[i] := i;
      q[i] := i;
    end;

  for i := 1 to n do
    begin
      v := get();
      j := h[v];
      while j > 0 do
        begin
          if d[a[j]] > d[v] + w[j] then
            begin
              d[a[j]] := d[v] + w[j];
              heap[p[a[j]]] := d[v] + w[j];
              down(up(p[a[j]]));
            end;
          j := next[j];
        end;
    end;

  for i := 1 to n do
    Write(d[i], ' ');

  Close(input);
  Close(output);
end.
