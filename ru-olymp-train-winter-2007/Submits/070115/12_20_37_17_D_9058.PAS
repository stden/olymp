program Bit2;

uses Math;

type
    TGraph=array[0..200,0..200] of Boolean;

var
    BFS_State:array[0..200] of Byte;
    N,K:Integer;

procedure BFS_V(const Graph:TGraph;Src:Integer);
var
    I:Integer;
begin
    BFS_State[Src]:=2;
    for I:=0 to N-1 do
        if Graph[Src,I] and (BFS_State[I]=0) then BFS_State[I]:=1;
    for I:=0 to N-1 do
        if Graph[Src,I] and (BFS_State[I]=1) then BFS_V(Graph,I);
end;

procedure BFS_VR(const Graph:TGraph;Src:Integer);
var
    I:Integer;
begin
    BFS_State[Src]:=2;
    for I:=0 to N-1 do
        if Graph[I,Src] and (BFS_State[I]=0) then BFS_State[I]:=1;
    for I:=0 to N-1 do
        if Graph[I,Src] and (BFS_State[I]=1) then BFS_VR(Graph,I);
end;

procedure BFS_Init;
var
    I:Integer;
begin
    for I:=0 to N-1 do
        BFS_State[I]:=0;
end;

procedure BFS(const Graph:TGraph;Src:Integer);
begin
    BFS_Init;
    BFS_V(Graph,Src);
end;

procedure BFSR(const Graph:TGraph;Src:Integer);
begin
    BFS_Init;
    BFS_VR(Graph,Src);
end;

var
    Fin,Fout:Text;
    Graphs:array[0..5] of TGraph;
    I,I2,I3,T,S,I4:Integer;
    Cin:Integer;
    Mult:array[0..200] of Boolean;
    Reach:array[0..200] of Boolean;

begin
    Assign(Fin,'bit2.in');
    Reset(Fin);
    Assign(Fout,'bit2.out');
    Rewrite(Fout);
    ReadLn(Fin,T);
    for I:=1 to T do
    begin
        ReadLn(Fin,N,K);
        for I2:=0 to K-1 do
        begin
            for I3:=0 to N-1 do
            begin
                Read(Fin,S);
                Graphs[I2,I3,S]:=True;
                Graphs[5,I3,S]:=True;
            end;
            ReadLn(Fin);
        end;
        for I2:=0 to K-1 do
            for I3:=0 to N-1 do
            begin
                Cin:=0;
                for I4:=0 to N-1 do
                    if Graphs[I2,I4,I3] then Inc(Cin);
                if Cin>1 then Mult[I3]:=true;
            end;
        for I2:=0 to N-1 do
            if Mult[I2] then
            begin
                BFS(Graphs[5],I2);
                if BFS_State[0]=2 then Reach[I2]:=True;
            end;
        BFSR(Graphs[5],0);
        for I2:=0 to N-1 do
            Mult[I2]:=Reach[I2] and (BFS_State[I2]=2);
        Cin:=0;
        for I2:=0 to N-1 do
            if Mult[I2] then
                Inc(Cin);
        if Cin<>0 then WriteLn(Fout,'YES')
        else WriteLn(Fout,'NO');
    end;
    Close(Fin);
    Close(Fout);
end.