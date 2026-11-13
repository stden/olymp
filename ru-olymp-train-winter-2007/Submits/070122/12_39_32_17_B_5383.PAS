program TestSys;

var
    F:Text;
    Parents,MaxLoads,Loads,Risk:array[0..200] of Integer;
    NMods,I:Integer;
    LeastRisks,NewLoads:array[0..200] of Integer;

procedure DFS(Vn:Integer);
var
    I:Integer;
    C1,C2:LongInt;
    Children:array[0..31] of Integer;
    LeastRisk,nChildren:Integer;
    MaxLoad:LongInt;
    ThisRisk,ThisLoad:LongInt;
begin
    nChildren:=0;
    MaxLoad:=Loads[Vn];
    for I:=1 to NMods do
        if Parents[I]=Vn then
        begin
            DFS(I);
            Children[NChildren]:=I;
            Inc(nChildren);
            Inc(MaxLoad,NewLoads[I]);
        end;
    if (NChildren=0) or (MaxLoad<=MaxLoads[Vn]) then
    begin
        NewLoads[Vn]:=Loads[Vn];
        LeastRisks[Vn]:=Risk[Vn];
    end
    else begin
        LeastRisk:=Risk[Vn];
        for C1:=1 to 1 shl NChildren-1 do
        begin
            C2:=C1;
            ThisRisk:=0;
            ThisLoad:=Loads[Vn];
            for I:=0 to 31 do
            begin
                if (C2 mod 2)<>0 then
                begin
                    ThisRisk:=ThisRisk+LeastRisks[Children[I]];
                    ThisLoad:=ThisLoad+NewLoads[Children[I]];
                end;
                C2:=C2 shr 1;
            end;
            if (ThisRisk<LeastRisk) and (ThisLoad>MaxLoads[Vn]) then
            begin
                LeastRisk:=ThisRisk;
                MaxLoad:=ThisLoad;
            end;
        end;
        LeastRisks[Vn]:=LeastRisk;
        NewLoads[Vn]:=MaxLoad;
    end;
end;

begin
    Assign(F,'system.in');
    Reset(F);
    ReadLn(F,NMods);
    for I:=1 to NMods do
        ReadLn(F,Parents[I],MaxLoads[I],Loads[I],Risk[I]);
    Close(F);
    DFS(1);
    Assign(F,'system.out');
    Rewrite(F);
    WriteLn(F,LeastRisks[1]);
    Close(F);
end.