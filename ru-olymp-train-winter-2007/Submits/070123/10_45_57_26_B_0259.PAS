{$M 50000000}
const
    MaxN = 250000;
    MaxM = 700000;
type
    edge = record
        v, next : longint;
    end;
    MyArray = array[1..MaxM] of edge;
    MyArray2 = array[1..MaxN] of longint;    
    MyArray3 = array[1..MaxN] of boolean;    
var
    A : MyArray;
    B, P, match : MyArray2;
    used : MyArray3;
    N : longint;
    size : longint = 0;
    ans : boolean = true;

procedure Add(u, v : longint);
begin
    inc(size);
    A[size].v := v;
    A[size].next := B[u];
    B[u] := size;          
end;

procedure Init;
var
    i, j, K, v : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(used, sizeof(used), false);
    fillchar(match, sizeof(match), 0);
    read(N);
    for i := 1 to N do
     begin
         read(K);
         for j := 1 to K do
          begin
              read(v);
              Add(i, v + N);
              Add(v + N, i);
          end;
     end;
end;

procedure dfs(v : longint);
var
    u : longint;
begin
    used[v] := true;
    u := B[v];
    while u <> 0 do
     begin
         if not used[A[u].v] then
          begin
              P[A[u].v] := v;
              dfs(A[u].v);
          end
         else
             if A[u].v <> P[v] then
                 ans := false;
         u := A[u].next;  
     end;
    if match[v] = 0 then
     begin
         match[v] := P[v];
         match[P[v]] := v;
     end;
end;

procedure Solve;
var
    i : longint;
begin
    dfs(1);          
    if ans then 
         for i := 1 to 2 * N do
             ans := ans and used[i];
    if ans then
     begin
         fillchar(used, sizeof(used), false);
         for i := 1 to 2 * N do
             used[match[i]] := true;
         for i := 1 to 2 * N do
             ans := ans and used[i];
     end;
end;

procedure Print;
var
    i : longint;
begin
    if ans then
     begin
        writeln('YES');
        for i := 1 to N do
            write(match[i] - N, ' ');
     end
    else
        write('NO');
    writeln;
end;

begin
    assign(input, 'omax.in');
    reset(input);
    assign(output, 'omax.out');
    rewrite(output);
    while not seekeof(input) do
     begin
        Init;
        Solve;
        Print;
     end;
    close(input);
    close(output);
end.