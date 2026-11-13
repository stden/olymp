const
    eps = 1e-6;
type
    point = record
        x, y : extended;
    end;
    line = record
        a, b, c : extended;
    end;
var
    A, B, C, D, p1, p2 : point;
    l1, l2 : line;
    kolvo : longint;

procedure Init;
begin
    read(A.x, A.y, B.x, B.y, C.x, C.y, D.x, D.y);
end;

function Eq(a, b : extended) : boolean;
begin
    Eq := (abs(a - b) <= eps);
end;

function EqPoints(a, b : Point) : boolean;
begin
    EqPoints := Eq(a.x, B.x) and Eq(A.y, B.y);
end;

function Dist(A, B : point) : extended;
begin
    Dist := sqrt(sqr(B.x - A.x) + sqr(B.y - A.y));
end;

function PointOnOtr(A, B, C : point) : boolean;
begin
{    if EqPoints(A, B) or EqPoints(A, C) then
        PointsOnOtr := true
    else}
        PointOnOtr := Eq((B.x - A.x) * (C.x - A.x) + (B.y - A.y) * (C.y - A.y), Dist(A, B) * Dist(A, C));
end;

function PointsToLine(A, B : point) : line;
begin
    PointsToLine.a := A.y - B.y;
    PointsToLine.b := A.x - B.x;
    PointsToLine.c := - (A.x * PointsToLine.a + A.y * PointsToLine.b);
end;

function PointOnLine(A : point; l : line) : boolean;
begin
    PointOnLine := Eq(A.x * l.a + A.y * l.b + l.c, 0);
end;

function PerLine(l1, l2 : line) : point;
begin
    PerLine.x := -(l2.a * l1.c + l1.a * l2.c) / (l1.a * l2.b + l1.b * l2.a);
    PerLine.y := -(l2.b * l1.c + l1.b * l2.c) / (l1.b * l2.a + l1.a * l2.b);
end;

procedure Solve;
var
    isA, isB, isC, isD : boolean;
begin
    if EqPoints(A, B) then
        if EqPoints(C, D) then
            if EqPoints(A, C) then
             begin
                kolvo := 1;
                p1 := A;
             end
            else
                kolvo := 0
        else
            if PointOnOtr(A, C, D) then
             begin
                kolvo := 1;
                p1 := A;
             end
            else
                kolvo := 0
    else
        if EqPoints(C, D) then
            if PointOnOtr(C, A, B) then
             begin
                kolvo := 1;
                p1 := C;
             end
            else
                kolvo := 0
        else
         begin
            l1 := PointsToLine(A, B);
            if not (PointOnLine(C, l1) and PointOnLine(D, l1)) then
             begin
                l2 := PointsToLine(C, D);
                p1 := PerLine(l1, l2);
                if PointOnOtr(p1, A, B) and PointOnOtr(p1, C, D) then
                    kolvo := 1
                else
                    kolvo := 0;
             end
            else
             begin
                isA := PointOnOtr(A, C, D);
                isB := PointOnOtr(B, C, D);
                isC := PointOnOtr(C, A, B);
                isD := PointOnOtr(D, A, B);
                if isA then
                    if isB then
                     begin
                        kolvo := 2;
                        p1 := A;
                        p2 := B;
                     end
                    else
                        if isC then
                         begin
                            kolvo := 2;
                            p1 := A;
                            p2 := C;
                         end
                        else
                            if isD then
                             begin
                                kolvo := 2;
                                p1 := A;
                                p2 := D;
                             end
                            else
                             begin
                                kolvo := 1;
                                p1 := A;
                             end
                else
                    if isB then
                        if isC then
                         begin
                            kolvo := 2;
                            p1 := B;
                            p2 := C;
                         end
                        else
                            if isD then
                             begin
                                kolvo := 2;
                                p1 := B;
                                p2 := D;
                             end
                            else
                             begin
                                kolvo := 1;
                                p1 := B;
                             end
                    else
                        if isC then
                            if isD then
                             begin
                                kolvo := 2;
                                p1 := C;
                                p2 := D;
                             end
                            else
                             begin
                                kolvo := 1;
                                p1 := C;
                             end
                        else
                            if isD then
                             begin
                                kolvo := 1;
                                p1 := D;
                             end
                            else
                                kolvo := 0;
             end;
        end;
end;

procedure Print;
begin
end;

begin
    assign(input, 'interseg.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'interseg.out');
    rewrite(output);
    Print;
    close(output);
end.
