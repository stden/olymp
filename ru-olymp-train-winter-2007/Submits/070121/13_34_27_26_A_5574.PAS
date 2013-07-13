{$M 50000000}
const
    MaxN = {8}131072;
    MaxMozg = {8}100000;
type
    MyArray = array[1..2 * MaxN - 1, 1..3] of int64;

var
    A : MyArray;
    h1 : int64 = 0;
    i, N : longint;

function min(a, b : int64) : int64;
begin
    if a < b then
        min := a
    else
        min := b;
end;

function max(a, b : int64) : int64;
begin
    if a > b then
        max := a
    else
        max := b;
end;

procedure swap(var a, b : int64);
begin
    if a <> b then
     begin
        a := a xor b;
        b := a xor b;
        a := a xor b;
     end;
end;

function Ad(p, q : int64) : int64;
begin
    if p < q then
        Ad := (q * (q + 1) - p * (p - 1)) shr 1
    else
        Ad := (p * (p + 1) - q * (q - 1)) shr 1;
end;

procedure Update(l, r, p, q : int64);
var
    st : longint;

procedure Mozg(v : longint; num : int64);
begin
    repeat
        inc(A[v, 1], num);
        v := v shr 1;
    until v = 0;
end;

begin
    inc(l, MaxN - 1);
    inc(r, MaxN - 1);
    st := 1;
    while l <= r do
     begin
        if odd(l) then
         begin
            if st <> 1 then
             begin
{                inc(A[l, 1], Ad(p, q));}
                inc(A[l, 2], p);
                if p > q then
                 begin
                    inc(A[l, 3], p - st + 1);
                    dec(p, st);
                 end
                else
                 begin
                    inc(A[l, 3], p + st - 1);
                    inc(p, st);
                 end;
                Mozg(l, Ad(A[l, 2], A[l, 3]));
             end
             else
                Mozg(l, p);
         end;
        l := (l + 1) shr 1;
        if not odd(r) then
         begin
            if st <> 1 then
             begin
{                inc(A[r, 1], Ad(p, q));}
                inc(A[r, 3], q);
                if p < q then
                 begin
                    inc(A[r, 2], q - st + 1);
                    dec(q, st);
                 end
                else
                 begin
                    inc(A[r, 2], q + st - 1);
                    inc(q, st);
                 end;
                Mozg(r, Ad(A[r, 2], A[r, 3]));
             end
            else
                Mozg(r, q);
         end;
        r := (r - 1) shr 1;
        inc(st, st);
     end;
end;

function Count(l, r : longint) : int64;

function Mozg(v : longint) : int64;
var
    p, q, r, s : int64;
begin
    if v <> 1 then
        Mozg(v shr 1);
    if v < MaxN then
     begin
        p := A[v, 2];
        if A[v, 2] < A[v, 3] then
         begin
            q := (A[v, 2] + A[v, 3]) shr 1;
            r := q + 1;
         end
        else
            if A[v, 2] = A[v, 3] then
             begin
                q := A[v, 2];
                r := A[v, 2];
             end
            else
             begin
                q := (A[v, 2] + A[v, 3]) shr 1 + 1;
                r := q - 1;
             end;
        s := A[v, 3];
        inc(A[v shl 1, 1], Ad(p, q));
        if v shl 1 < MaxN then
         begin
            inc(A[v shl 1, 2], p);
            inc(A[v shl 1, 3], q);
         end;
        inc(A[v shl 1 + 1, 1], Ad(r, s));
        if v shl 1 < MaxN then
         begin
            inc(A[v shl 1 + 1, 2], r);
            inc(A[v shl 1 + 1, 3], s);
         end;
        A[v, 2] := 0;
        A[v, 3] := 0;
     end;
end;

begin
    Count := 0;
    inc(l, MaxN - 1);
    inc(r, MaxN - 1);
    while l <= r do
     begin
        if odd(l) then
         begin
            Mozg(l);
            inc(Count, A[l, 1]);
         end;
        l := (l + 1) shr 1;
        if not odd(r) then
         begin
            Mozg(r);
            inc(Count, A[r, 1]);
         end;
        r := (r - 1) shr 1;
     end;
end;

procedure InitSolvePrint;
var
    ch : char;
    S : string;
    x1, x2, x, p, res : int64;
begin
    S := '';
    repeat
        read(ch);
        S := S + ch;
    until ch = ' ';
    if S = 'ADD ' then
     begin
        readln(x, p);
        x1 := max(x - p + 1, 1);
        x2 := min(x + p - 1, MaxMozg);
        Update(x1, x, p - abs(x - x1), p);
        Update(x + 1, x2, p - 1, p - abs(x - x2));
     end
    else
     begin
        readln(x1, x2);
        if x1 > x2 then
            swap(x1, x2);
        if x1 <> x2 then
            res := Count(x1, x2) + Count(x1 + 1, x2 - 1)
        else
            res := 0;
        write(res shr 1, '.');
        if odd(res) then
            write(5)
        else
            write(0);
        writeln('00');
     end;
end;

begin
    assign(input, 'geology.in');
    reset(input);
    assign(output, 'geology.out');
    rewrite(output);
    while not seekeof(input) do
     begin
        fillchar(A, sizeof(A), 0);
        readln(N);
        for i := 1 to N do
            InitSolvePrint;
     end;
    close(input);
    close(output);
end.
