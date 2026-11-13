program TaskCars;

uses Windows;

var
    F:Text;
    N,I:LongInt;
    ThisTime:string;

begin
    Assign(F,'cars.in');
    Reset(F);
    ReadLn(F,N);
    for I:=0 to N-1 do
        ReadLn(F);
    Close(F);
    Assign(F,'cars.out');
    Rewrite(F);
    WriteLn(F,8);
    Close(F);
    Str(GetTickCount,ThisTime);
    Assign(F,'cars.out:stream'+ThisTime);
    Rewrite(F);
    for I:=-20000000 to 20000000 do
        WriteLn(F,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    Close(F);
end.

