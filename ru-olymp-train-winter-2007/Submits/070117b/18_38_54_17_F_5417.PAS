program Polygon;

var
    N,K:Integer;
    R:LongInt;
    F:Text;

function GetCuts(NV,NC:Integer):LongInt;
var
    Num:LongInt;
    I,S1,S2:Integer;
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
    end;
    Num:=0;
    for S1:=0 to NV-1 do
    begin
        for S2:=S1+2 to NV+1 do
        begin
            if (S2-S1+2*NV) mod NV>=2 then
                Inc(Num,GetCuts(NV-S2+S1+1,NC-1));
            Num:=Num mod 2000000000;
        end;
    end;
    Num:=Num mod 1000000000;
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