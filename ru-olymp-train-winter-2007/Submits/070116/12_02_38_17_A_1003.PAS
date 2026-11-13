program Path;

var
    F:Text;
    FirstEdge:array[0..30000] of LongInt;
    NextEdge,Weight:array[0..800000] of LongInt;
    EdgeEnd:array[0..800000] of LongInt;
    LastEdge:LongInt;
    N,M:LongInt;
    Dist:array[0..30000] of LongInt;
    Marked:array[0..30000] of Boolean;

procedure Relax(A:LongInt;nEdge:LongInt);
var
    B:LongInt;
    W:LongInt;
begin
    W:=Weight[nEdge];
    B:=EdgeEnd[nEdge];
    if (Dist[B]=0) or (Dist[A]+W<Dist[B]) then
        Dist[B]:=Dist[A]+W;
end;

procedure Deykstr(Src:LongInt);
var
    MinDist,nEdge:LongInt;
    I,I2,MinI,I3:LongInt;
begin
    for I3:=1 to N do
    begin
        MinDist:=0;
        MinI:=-1;
        for I:=1 to N do
            if (Dist[I]<>0) and not Marked[I] and ((MinDist=0) or
                (Dist[I]<MinDist)) then
            begin
                MinDist:=Dist[I];
                MinI:=I;
            end;
        if (MinI=-1) and (Marked[Src]) then Break;
        if MinI=-1 then MinI:=Src;
        Marked[MinI]:=true;
        nEdge:=FirstEdge[MinI];
        while nEdge<>0 do
        begin
            if not Marked[EdgeEnd[nEdge]] then Relax(MinI,nEdge);
            nEdge:=NextEdge[nEdge];
        end;
    end;
end;

procedure AddEdge(A,B:LongInt;W:LongInt);
var
    ThisEdge:Longint;
begin
    ThisEdge:=LastEdge;
    Inc(LastEdge);
    Weight[ThisEdge]:=W;
    EdgeEnd[ThisEdge]:=B;
    NextEdge[ThisEdge]:=FirstEdge[A];
    FirstEdge[A]:=ThisEdge;
end;

var
    A,B,W:LongInt;
    I:LongInt;

begin
    Assign(F,'Path.in');
    LastEdge:=1;
    Reset(F);
    ReadLn(F,N,M);
    for I:=1 to M do
    begin
        ReadLn(F,A,B,W);
        AddEdge(B,A,W);
        AddEdge(A,B,W);
    end;
    Close(F);
    Deykstr(1);
    Assign(F,'Path.out');
    Rewrite(F);
    Write(F,'0');
    for I:=2 to N do
        Write(F,' ',Dist[I]);
    Close(F);
end.
