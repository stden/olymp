{$M 50000000}
const
    MaxN = 100;
    MaxT = 4000000;
    MaxM = 4;
type
    rect = record
        x1, y1, x2, y2 : longint;
    end;
    MyArray = array[1..MaxM] of rect;
var
    A : MyArray;
    M, N : longint;
    all : int64;
    AC : int64 = 0;
    ans : extended;

procedure Init;
begin
    read(M, N);
    inc(M);
    inc(N);
    RandSeed := 239;
end;

procedure swap(var x, y : longint);
begin
    if x <> y then
     begin
        x := x xor y;
        y := x xor y;
        x := x xor y;
     end;
end;

function min(a, b : longint) : longint;
begin
    if a < b then
        min := a
    else
        min := b;
end;

function max(a, b : longint) : longint;
begin
    if a > b then
        max := a
    else
        max := b;
end;

function Intersect(a, b : rect) : boolean;
var
    c : rect;
begin
    if a.x1 > a.x2 then
        swap(a.x1, a.x2);
    if a.y1 > a.y2 then
        swap(a.y1, a.y2);
    if b.x1 > b.x2 then
        swap(b.x1, b.x2);
    if b.y1 > b.y2 then
        swap(b.y1, b.y2);
    c.x1 := max(a.x1, b.x1);
    c.x2 := min(a.x2, b.x2);
    c.y1 := max(a.y1, b.y1);
    c.y2 := min(a.y2, b.y2);
    Intersect := (c.x1 <= c.x2) and (c.y1 <= c.y2);
end;

procedure Perebor(num : longint);
var
    i, j, k, l, t : longint;
    bug : boolean;
begin
    if num = MaxM + 1 then
        inc(AC)
    else
        for i := 1 to M do
            for j := 1 to N do
             begin
                bug := false;
                A[num].x1 := i;
                A[num].y1 := j;
                A[num].x2 := i;
                A[num].y2 := j;
                for t := 1 to num - 1 do
                    bug := bug or Intersect(A[t], A[num]);
                if not bug then
                    for k := 1 to M do
                        for l := 1 to N do
                         begin
                            A[num].x2 := k;
                            A[num].y2 := l;
                            bug := false;
                            for t := 1 to num - 1 do
                                bug := bug or Intersect(A[t], A[num]);
                            if not bug then
                                Perebor(num + 1);
                         end;
             end;
end;

procedure Solve;
var
    i, j, k : longint;
    bug : boolean;
begin
    all := sqr(sqr(sqr(int64(M * N))));
    if M * N > 10 then
     begin
        for i := 1 to MaxT do
         begin
            bug := false;
            j := 1;
            while not bug and (j <= MaxM) do
             begin
                A[j].x1 := random(M) + 1;
                A[j].x2 := random(M) + 1;
                A[j].y1 := random(N) + 1;
                A[j].y2 := random(N) + 1;
{                if A[j].x1 > A[j].x2 then
                    swap(A[j].x1, A[j].x2);
                if A[j].y1 > A[j].y2 then
                    swap(A[j].y1, A[j].y2);}
                for k := 1 to j - 1 do
                    bug := bug or Intersect(A[j], A[k]);
                inc(j);
             end;
            if not bug then
                inc(AC);
         end;
        ans := extended(AC) / MaxT;
     end
    else
     begin
        Perebor(1);
        ans := extended(AC) / all;
     end;
end;

procedure Print;
begin
    write(ans : 0 : 8);
end;

begin
    assign(input, 'heritage.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'heritage.out');
    rewrite(output);
    Print;
    close(output);
end.
