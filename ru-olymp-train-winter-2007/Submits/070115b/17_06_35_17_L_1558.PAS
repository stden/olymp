program SubStr;

var
    Line:array[0..10000] of char;
    SrcText:array[0..200000] of Char;
    LLine,LText:LongInt;
    F:Text;
    Shifts:array[33..126] of LongInt;

procedure ReadLine;
var
    Ch:Char;
    N:Integer;
begin
    N:=0;
    repeat
        Read(F,Ch);
        if Ch='*' then Break;
        if (Ord(Ch)>=33) and (Ord(Ch)<=126) then
        begin
            Line[N]:=Ch;
            Inc(N);
        end;
    until EOF(F);
    LLine:=N;
end;

procedure ReadText;
var
    Ch:Char;
    N:LongInt;
begin
    N:=0;
    repeat
        Read(F,Ch);
        if (Ord(Ch)>=33) and (Ord(Ch)<=126) then
        begin
            SrcText[N]:=Ch;
            Inc(N);
        end;
    until EOF(F);
    LText:=N;
end;

procedure ProcLine;
var
    I:Integer;
begin
    for I:=33 to 126 do
        Shifts[I]:=LLine;
    for I:=0 to LLine-1 do
        Shifts[Ord(Line[I])]:=LLine-I-1;
end;

function CmpStr(StartPos:LongInt):LongInt;
var
    I:LongInt;
    PreRes:LongInt;
begin
    PreRes:=0;
    for I:=LLine-1 downto 0 do
    begin
        if Line[I]<>SrcText[StartPos+I] then
        begin
            PreRes:=Shifts[Ord(SrcText[StartPos+I])]-LLine+I+1;
            Break;
        end;
    end;
    CmpStr:=PreRes;
end;

procedure SearchStr;
var
    CP:LongInt;
    Adv:Integer;
begin
    CP:=0;
    while CP<LText-LLine+1 do
    begin
        Adv:=CmpStr(CP);
        if Adv<0 then Adv:=1;
        if Adv=0 then
        begin
            Inc(CP);
            WriteLn(F,CP);
        end
        else Inc(CP,Adv);
    end;
end;

begin
    Assign(F,'substr.in');
    Reset(F);
    ReadLine;
    ReadText;
    Close(F);
    ProcLine;
    Assign(F,'substr.out');
    Rewrite(F);
    SearchStr;
    Close(F);
end.
