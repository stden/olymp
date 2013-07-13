Uses Math;
Const
  MaxN=262144;
Var
  I,N:Integer;
  X,Y:Array[1..MaxN]Of Integer;
  MinX,MaxX,MinY,MaxY,KX,KY,AX,AY:Real;
Begin
  Read(N);
  For I:=1 To N Do Read(X[I],Y[I]);
  MinX:=X[1];
  MaxX:=X[1];
  MinY:=Y[1];
  MaxY:=Y[1];
  For I:=2 To N Do Begin
    MinX:=Min(MinX,X[I]);
    MaxX:=Max(MaxX,X[I]);
    MinY:=Min(MinY,Y[I]);
    MaxY:=Max(MaxY,Y[I]);
  End;
  KX:=1/(MaxX-MinX);
  KY:=1/(MaxY-MinY);
  KX:=Min(KX,KY);
  KY:=Min(KX,KY);
  AX:=0.5-KX*(MinX+MaxX)/2;
  AY:=0.5-KY*(MinY+MaxY)/2;
  WriteLn('numeric u;');
  WriteLn('u = 15cm;');
  WriteLn;
  WriteLn('beginfig(1);');
  WriteLn('  draw');
  For I:=1 To N Do Begin
    Write('    ');
    If (I>1) Then Write('--');
    WriteLn('(',KX*X[I]+AX:0:20,'u,',KY*Y[I]+AY:0:20,'u)');
  End;
  WriteLn('    --cycle;');
  writeln('  pickup pencircle scaled 2pt;');
  For I:=1 To N Do Begin
    Write('  ');
    WriteLn('drawdot(',KX*X[I]+AX:0:20,'u,',KY*Y[I]+AY:0:20,'u);');
  End;
  WriteLn('endfig;');
  WriteLn;
  WriteLn('end');
End.
