program Polygon;

var
    Ress:array[0..100,0..100] of LongInt;
    Calc:array[0..100,0..100] of Boolean;
    N,K:Integer;
    R:LongInt;
    F:Text;

function GetCuts(NV,NC:Integer):LongInt;
var
    Num,R:LongInt;
    I,S1,S2:Integer;
    Can:Boolean;
begin
    if NV-NC<2 then
    begin
        GetCuts:=0;
        Exit;
    end
    else if NC=1 then
    begin
        GetCuts:=1;
        Exit;
    end
    else if Calc[NV,NC] then
    begin
        GetCuts:=Ress[NV,NC];
        Exit;
    end;
    Can:=False;
    Num:=0;
    for S1:=0 to NV-1 do
    begin
        for S2:=S1+2 to NV+1 do
            if (S2-S1+2*NV) mod NV>=2 then
            begin
                R:=GetCuts(NV-S2+S1+1,NC-1);
                if R=-1 then R:=0
                else Can:=True;
                Inc(Num,R);
                Num:=Num mod 2000000000;
            end;
    end;
    if (NV=4) or (NC>2) then Num:=Num div 2;
    Num:=Num mod 1000000000;
    if not Can then Num:=-1;
    Calc[NV,NC]:=True;
    Ress[NV,NC]:=Num;
    GetCuts:=Num;
end;

begin
    Assign(F,'polygon.in');
    Reset(F);
    ReadLn(F,N,K);
    Close(F);
    R:=GetCuts(N,K);
    Assign(F,'polygon.out');
    Rewrite(F);
    WriteLn(F,R);
    Close(F);
end.