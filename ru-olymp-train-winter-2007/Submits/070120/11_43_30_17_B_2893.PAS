program MaxSum;

var
    F:Text;
    Graph:array[0..20,0..20] of Boolean;
    Score:array[0..20] of Integer;
    DFS_State:array[0..20] of Integer;
    MaxMoves:array[0..20] of Integer;
    Loc:Integer;
    N,M,I,P,Q:Integer;
    K,C:Int64;
    MaxScore:Int64;
    MaxS,MaxI:Integer;

procedure DFS(V:Integer);
var
    I:Integer;
    Inf:Boolean;
    NMoves:Integer;
begin
    NMoves:=0;
    Inf:=False;
    DFS_State[V]:=1;
    for I:=1 to N do
        if Graph[V,I] then
        begin
            if DFS_State[I]=0 then
            begin
                DFS(I);
                if (MaxMoves[I]=-1) then
                    Inf:=True
                else if (Inf=False) and (MaxMoves[I]>NMoves) then
                    NMoves:=MaxMoves[I];
            end
            else if DFS_State[I]=1 then
                Inf:=True
            else if DFS_State[I]=2 then
            begin
                if MaxMoves[I]=-1 then
                    Inf:=True
                else if (Inf=False) and (MaxMoves[I]>NMoves) then
                    NMoves:=MaxMoves[I];
            end;
        end;
    if Inf then
        MaxMoves[V]:=-1
    else
        MaxMoves[V]:=NMoves+1;
end;

begin
    Assign(F,'maxsum.in');
    Reset(F);
    ReadLn(F,N,M,K);
    for I:=1 to N do
        Read(F,Score[I]);
    ReadLn(F);
    for I:=1 to M do
    begin
        ReadLn(F,P,Q);
        Graph[P,Q]:=True;
    end;
    Close(F);
    DFS(1);
    Loc:=1;
    MaxScore:=Score[1];
    repeat
        K:=K-1;
        MaxI:=0;
        MaxS:=0;
        for I:=1 to N do
            if Graph[Loc,I] and ((MaxMoves[I]=-1) or (MaxMoves[I]>=K)) and
                (Score[I]>MaxS) then
                begin
                    MaxS:=Score[I];
                    MaxI:=I;
                end;
        MaxScore:=MaxScore+Int64(MaxS);
        Loc:=MaxI;
    until K=0;
    Assign(F,'maxsum.out');
    Rewrite(F);
    WriteLn(F,MaxScore);
    Close(F);
end.


