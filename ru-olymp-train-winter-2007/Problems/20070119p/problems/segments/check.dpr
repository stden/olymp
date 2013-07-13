Uses TestLib, SysUtils, Math;

const 
 MaxN = 125000;

type 
 TPoint = record
  X, Y: LongInt;
 end;

 TVector = record
  X, Y: LongInt;
 end;

 TSegment = record
   P1, P2: TPoint;
 end;

function MinX(S: TSegment): LongInt;
begin
 Result:=Min(S.P1.X, S.P2.X);
end;

function MinY(S: TSegment): LongInt;
begin
 Result:=Min(S.P1.Y, S.P2.Y);
end;

function MaxX(S: TSegment): LongInt;
begin
 Result:=Max(S.P1.X, S.P2.X);
end;

function MaxY(S: TSegment): LongInt;
begin
 Result:=Max(S.P1.Y, S.P2.Y);
end;

function Vector(Pb, Pe: TPoint): TVector;
begin
 Result.X:=Pe.X - Pb.X;
 Result.Y:=Pe.Y - Pb.Y;
end;

function SlVecProd(V1, V2: TVector): LongInt;
begin
 Result:=V1.X * V2.Y - V2.X * V1.Y;
end;

function SegsIntersect(S1, S2: TSegment): Boolean;
var
 A, B, C, D: LongInt;
 V12, V13, V14, V34, V31, V32: TVector;
begin
 If (MaxX(S1) >= MinX(S2)) and (MaxX(S2) >= MinX(S1)) and
    (MaxY(S1) >= MinY(S2)) and (MaxY(S2) >= MinY(S1)) then
  begin
   V12:=Vector(S1.P1, S1.P2);
   V13:=Vector(S1.P1, S2.P1);
   V14:=Vector(S1.P1, S2.P2);
   V34:=Vector(S2.P1, S2.P2);
   V31:=Vector(S2.P1, S1.P1);
   V32:=Vector(S2.P1, S1.P2);
   A:=SlVecProd(V12, V13);
   B:=SlVecProd(V12, V14);
   C:=SlVecProd(V34, V31);
   D:=SlVecProd(V34, V32);
   If A <> 0 then A:=A div Abs(A);
   If B <> 0 then B:=B div Abs(B);
   If C <> 0 then C:=C div Abs(C);
   If D <> 0 then D:=D div Abs(D);
   Result:=(A * B <= 0) and (C * D <= 0);
  end
 else Result:=False;
end;

var
 N, i, j: LongInt;
 jury, cont:string;
 Segs: array [1..MaxN] of TSegment;

begin
  jury:=StripSpaces (UpperCase (ans.readstring));
  cont:=StripSpaces (UpperCase (ouf.readstring));
  if (cont<>'NO') and (cont<>'YES') then quit (_Fail, 'YES or NO required');
  if (cont<>'NO') and (cont<>'YES') then quit (_PE, 'YES or NO required');
  if jury<>cont then quit (_WA, 'Jury: '+jury+', Contestant: '+cont);
  If cont = 'YES' then
   begin
    N:=Inf.ReadLongInt;
    For i:=1 to N do
     begin
      Segs[i].P1.X:=Inf.ReadLongInt;
      Segs[i].P1.Y:=Inf.ReadLongInt;
      Segs[i].P2.X:=Inf.ReadLongInt;
      Segs[i].P2.Y:=Inf.ReadLongInt;
     end;
    If Ouf.SeekEof then quit(_PE, 'No segments'' numbers');
    i:=Ouf.ReadLongInt;
    If Ouf.SeekEof then quit(_PE, 'No segments'' numbers');
    j:=Ouf.ReadLongInt;
    If i = j then quit(_wa, 'Segment numbers must different');
    If not SegsIntersect(Segs[i], Segs[j]) then quit(_wa, 'Segments do not intersect');
   end;
  quit (_OK, '');
end.