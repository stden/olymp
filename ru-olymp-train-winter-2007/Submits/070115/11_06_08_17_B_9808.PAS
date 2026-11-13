program Reverse;

var
    Number:array[0..10000] of Byte;

procedure DecNum(First,Last:Integer);
var
    N:Integer;
    NeedDec:Boolean;
begin
    N:=Last;
    repeat
        Dec(Number[N]);
        if Number[N]=Byte(-1) then
        begin
            NeedDec:=True;
            Number[N]:=9;
            Dec(N);
        end
        else NeedDec:=False;
    until (NeedDec=False) or (N<First);
end;

function Check(First,Last:Integer):Boolean;
begin
    if First=Last then Check:=(Number[First] mod 2)=0
    else if First>Last then Check:=True
    else if Number[First]=Number[Last] then
        Check:=Check(First+1,Last-1)
    else if (Number[First]=1) and (Number[Last]<9) then
    begin
        DecNum(First,Last-1);
        if Number[First]=1 then
        begin
            Dec(Number[First+1],Number[Last]);
            if Number[First+1]=0 then Inc(First);
            Check:=Check(First+1,Last-1);
        end
        else Check:=False;
    end
    else if Number[First]=Number[Last]+1 then
    begin
        Number[First]:=1;
        Check:=Check(First,Last-1);
    end
    else Check:=False;
end;

function ReadNumber(var F:Text):Integer;
var
    N:Integer;
    ChRead:Char;
begin
    repeat
        Read(F,ChRead);
    until ((Ord(ChRead)<=Ord('9')) and (Ord(ChRead)>=Ord('0'))) or EOF(F);
    if EOF(F) then
    begin
        ReadNumber:=0;
        Exit;
    end;
    Number[0]:=Ord(ChRead)-Ord('0');
    N:=1;
    repeat
        Read(F,ChRead);
        if (Ord(ChRead)<Ord('0')) or (Ord(ChRead)>Ord('9')) then Break;
        Number[N]:=Ord(ChRead)-Ord('0');
        Inc(N);
    until EOF(F);
    if (N=1) and (Number[0]=0) then
        ReadNumber:=0
    else
        ReadNumber:=N;
end;

var
    Fin,Fout:Text;
    L:Integer;
begin
    Assign(Fin,'reverse.in');
    Reset(Fin);
    Assign(Fout,'reverse.out');
    Rewrite(Fout);
    repeat
        L:=ReadNumber(Fin);
        if L=0 then break;
        if Check(0,L-1) then WriteLn(Fout,'YES')
        else WriteLn(Fout,'NO');
    until False;
    Close(Fin);
    Close(Fout);
end.
