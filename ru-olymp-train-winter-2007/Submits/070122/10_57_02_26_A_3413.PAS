{$M 50000000}
const
    MaxN = 1024;
type
    MyArray = array[1..MaxN, 1..MaxN] of boolean;
    MyArray2 = array[1..MaxN] of boolean;
    MyArray3 = array[1..MaxN] of longint;
var
    A : MyArray;
    mark : MyArray2;
    matchl, matchr, matchl0 : MyArray3;
    N1, N2, M : longint;
    del1, del2, del3, del4 : longint;
    max, ans, res : longint;

procedure Init;
var
    i, u, v : longint;
begin
    fillchar(A, sizeof(A), 0);
    read(N1, N2, M);
    for i := 1 to M do
     begin
        read(u, v);
        A[u, v] := true;
     end;
end;

function dfs(v : longint) : boolean;
var
    u : longint;
begin
    dfs := false;
    if mark[v] then exit;
    mark[v] := true;
    for u := 1 to N2 do
        if A[v, u] and not ((del1 = v) and (del2 = u)) and not ((del3 = v) and (del4 = u)) then
            if (matchr[u] = 0) or dfs(matchr[u]) then
             begin
                matchl[v] := u;
                matchr[u] := v;
                dfs := true;
                exit;
             end;
end;

function Kun : longint;
var
    i : longint;
begin
    Kun := 0;
    fillchar(matchl, sizeof(matchl), 0);
    fillchar(matchr, sizeof(matchr), 0);
    for i := 1 to N1 do
     begin
        fillchar(mark, sizeof(mark), false);
        inc(Kun, ord(dfs(i)));
     end;
end;

procedure Solve;
begin
    del1 := 0;
    del2 := 0;
    del3 := 0;
    del4 := 0;
    max := Kun;
    res := 0;
    matchl0 := matchl;
    for del1 := 1 to N1 do
        if matchl0[del1] <> 0 then
         begin
            del2 := matchl0[del1];
            for del3 := 1 to N1 do
                 for del4 := 1 to N2 do
                    if A[del3, del4] and ((del1 <> del2) or (del3 <> del4)) then
                        inc(res, ord(Kun < max));
         end;
{    for del1 := 1 to N1 do
        for del2 := 1 to N2 do
            if A[del1, del2] then
                for del3 := 1 to N1 do
                    for del4 := 1 to N2 do
                        if A[del3, del4] and not ((del1 = del3) and (del2 = del4)) then
                         begin
                            ans := Kun;
                            if ans < max then
                                inc(res);
                         end;}
end;

procedure Print;
begin
    write(res);
end;

begin
    assign(input, 'pairs.in');
    reset(input);
    assign(output, 'pairs.out');
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
