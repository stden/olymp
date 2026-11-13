{$M 50000000}
const
    MaxN = 270000;
    eps = 1e-6;
type
    point = record
        x, y : extended;
    end;
    line = record
        a, b, c : extended;
    end;
    MyArray = array[1..MaxN] of point;
    MyArray2 = array[1..MaxN] of longint;
    MyArray3 = array[0..MaxN, 1..3] of longint;
var
    A : MyArray;
    Next : MyArray2;
    ans : MyArray3;
    N, kolvo : longint;

procedure Init;
var
    i : longint;
begin
    RandSeed := 239 * N;
    fillchar(A, sizeof(A), 0);
    fillchar(Next, sizeof(Next), 0);
    fillchar(ans, sizeof(ans), 0);
    read(N);
    kolvo := N;
    for i := 1 to N do
     begin
        read(A[i].x, A[i].y);
        Next[i] := i mod N + 1;
     end;
end;

function PointsToLine(A, B : point) : line;
begin
    PointsToLine.a := A.y - B.y;
    PointsToLine.b := B.x - A.x;
    PointsToLine.c := - (A.x * PointsToLine.a + A.y * PointsToLine.b);
end;

function IntersectLines(l1, l2 : line) : point;
begin
    if l1.a * l2.b = l1.b * l2.a then
     begin
        IntersectLines.x := 239666239666;
        IntersectLines.y := 2396662396666;
     end
    else
     begin
        IntersectLines.x := (l2.b * l1.c - l1.b * l2.c) / (l2.b * l1.a - l1.b * l2.a);
        IntersectLines.y := (l2.a * l1.c - l1.a * l2.c) / (l2.a * l1.b - l1.a * l2.b);
     end;
end;

function Eq(x, y : extended) : boolean;
begin
    Eq := (abs(x - y) < eps);
end;

function Dist(A, B : point) : extended;
begin
    Dist := sqrt(sqr(A.x - B.x) + sqr(A.y - B.y));
end;

function PointOnInterval(A, B, C : point) : boolean;
begin
    PointOnInterval := Eq((C.x - A.x) * (B.y - A.y) + (C.y - A.y) * (B.x - A.x), - Dist(A, B) * Dist(A, C));
end;

function Intersect(A, B, C, D : point) : boolean;
var
    l1, l2 : line;
    p : point;
begin
    l1 := PointsToLine(A, B);
    l2 := PointsToLine(C, D);
    p := IntersectLines(l1, l2);
    Intersect := PointOnInterval(p, A, B) and PointOnInterval(p, C, D);
end;

function PointOnLine(p : point; l : line) : boolean;
begin
    PointOnLine := Eq(l.a * p.x + l.b * p.y + l.c, 0);
end;

function PointInside(p : point; cur : longint) : boolean;
var
    l, l1 : line;
    mozg : boolean;
    i : longint;
    cur0, per : longint;
begin
    repeat
        mozg := true;
        l.a := random;
        l.b := random;
        l.c := - (l.a * p.x + l.b * p.y);
        for i := 1 to N do
            mozg := mozg and not PointOnLine(A[i], l);
    until mozg;
    cur0 := cur;
    per := 0;
    repeat
        l1 := PointsToLine(A[cur], A[next[cur]]);
        if PointOnInterval(IntersectLines(l1, l), A[cur], A[Next[cur]]) then
            inc(per);
        cur := Next[cur];
    until cur0 = cur;
    PointInside := not odd(per);
end;

function DiagInside(p, q : longint) : boolean;
var
    cur : longint;
    l : line;
    t : point;
begin
    DiagInside := true;
    cur := q;
    while (Next[cur] <> p) and DiagInside do
     begin
        DiagInside := DiagInside and (not Intersect(A[cur], A[Next[cur]], A[p], A[q]));
        cur := Next[cur];
     end;
    if DiagInside then
     begin
        t.x := (A[p].x + A[q].x) / 2;
        t.y := (A[p].y + A[q].y) / 2;
        DiagInside := PointInside(t, p);
     end;
end;

procedure Solve;
var
    cur : longint;
    i, j, k : longint;
begin
    cur := 1;
    i := 2;
    j := 3;
    while kolvo <> 3 do
     begin
        if DiagInside(cur, j) then
         begin
            inc(ans[0, 1]);
            ans[ans[0, 1], 1] := cur;
            ans[ans[0, 1], 2] := i;
            ans[ans[0, 1], 3] := j;
            Next[cur] := j;
            dec(kolvo);
         end;
        cur := Next[cur];
        i := Next[cur];
        j := Next[i];
     end;
    inc(ans[0, 1]);
    ans[ans[0, 1], 1] := cur;
    ans[ans[0, 1], 2] := i;
    ans[ans[0, 1], 3] := j;
end;

procedure Print;
var
    i : longint;
begin
    for i := 1 to ans[0, 1] do
        writeln(ans[i, 1], ' ', ans[i, 2], ' ', ans[i, 3]);
end;

begin
    assign(input, 'tri.in');
    reset(input);
    assign(output, 'tri.out');
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