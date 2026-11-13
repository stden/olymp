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
    A, A1 : MyArray;
    B, B1, match, num : MyArray2;
    used : MyArray3;
    N : longint;
    size : longint = 0;
    ans : boolean = true;
    res : longint = 0;
    number : longint;

procedure Add(u, v : longint);
begin
    inc(size);
    A[size].v := v;
    A[size].next := B[u];
    B[u] := size;          
end;

procedure Add1(u, v : longint);
begin
    inc(size);
    A1[size].v := v;
    A1[size].next := B1[u];
    B1[u] := size;          
end;

procedure Init;
var
    i, j, K, v : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(A1, sizeof(A1), 0);
    fillchar(B1, sizeof(B1), 0);
    fillchar(used, sizeof(used), false);
    fillchar(match, sizeof(match), 0);
    read(N);
    number := 2 * N;
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
function DfsKun(v : longint) : boolean;
var
    u : longint;
begin
    DfsKun := false;
    if used[v] then exit;
    used[v] := true;
    u := B[v];
    while u <> 0 do
     begin
         if (match[A[u].v] = 0) or DfsKun(match[A[u].v]) then
          begin
              match[v] := A[u].v;
              match[A[u].v] := v;
              DfsKun := true;
              exit;
          end;
         u := A[u].next;
     end;
end;

function Kun : longint;
var
    i : longint;
begin
    Kun := 0;
    fillchar(match, sizeof(match), 0);
    for i := 1 to N do
     begin
        fillchar(used, sizeof(used), false);
        inc(Kun, ord(DfsKun(i)));
     end;
end;

procedure dfs(v : longint);
var
    u : longint;
begin
{    writeln(v);}
    used[v] := true;
    u := B1[v];
    while u <> 0 do
     begin
         if not used[A1[u].v] then
             dfs(A1[u].v);
         u := A1[u].next;  
     end;
    num[v] := number;
    dec(number);
end;

procedure Solve;
var
    i, u : longint;
begin
    if int64(size) * int64(N) < 50000000 then
     begin
         res := Kun;
         if res < N then
             ans := false
         else
          begin
              for i := 1 to 2 * N do
               begin
                   u := B[i];
                   while u <> 0 do
                    begin
                        if (i > N) xor (match[i] = A[u].v) then      
                            Add1(i, A[u].v);
                        u := A[u].next;
                    end;
               end;
              fillchar(used, sizeof(used), false);
              for i := 1 to 2 * N do          
                  if not used[i] then
                      dfs(i);
              for i := 1 to 2 * N do 
               begin
                   u := B1[i];
                   while u <> 0 do
                    begin
                        if num[i] > num[A1[u].v] then
                             ans := false;
                        u := A1[u].next;
                    end;
               end;
          end
     end
    else
        ans := false;
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
{    for i := 1 to 2 * N do
        writeln(num[i]);}
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