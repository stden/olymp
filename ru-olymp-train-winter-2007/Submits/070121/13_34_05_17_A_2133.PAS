program Geology;

var
    F,F2:Text;
    Vx:array[0..1500000] of LongInt;
    Vy:array[0..1500000] of Int64;
    NV:LongInt;
    N,I:LongInt;
    P,Q:LongInt;
    S:string;

function BinSearch(V:LongInt):LongInt;
var
    E,P1,P2:LongInt;
begin
    P1:=0;
    P2:=NV-1;
    while P2>P1 do
    begin
        E:=(P1+P2) div 2;
        if Vx[E]>V then
            P2:=E-1
        else if Vx[E]<V then
            P1:=E+1
        else if Vx[E]=V then
        begin
            P1:=E;
            Break;
        end;
    end;
    if (Vx[P1]=V) or (P2=-1) then
        BinSearch:=P1
    else
        BinSearch:=P1+1;
end;

function Insert(X:LongInt;Y:Int64):LongInt;
var
    T1,I:LongInt;
    Pos:LongInt;
    T2:Int64;
begin
    Pos:=BinSearch(X);
    if Vx[Pos]=X then
        Vy[Pos]:=Y
    else begin
        Vx[NV]:=X;
        Vy[NV]:=Y;
        for I:=NV-1 downto Pos do
        begin
            T1:=Vx[I];
            Vx[I]:=Vx[I+1];
            Vx[I+1]:=T1;
            T2:=Vy[I];
            Vy[I]:=Vy[I+1];
            Vy[I+1]:=T2;
        end;
        Inc(NV);
    end;
    Insert:=Pos;
end;

function GetY(X:LongInt):Int64;
var
    X1,Y1,X2,Y2,DX:LongInt;
begin
    X1:=BinSearch(X);
    if (X1=0) or (X1=NV) then
        GetY:=0
    else if Vx[X1]=X then
        GetY:=Vy[X1]
    else begin
        Y1:=Vy[X1];
        if X1=NV-1 then
        begin
            Y2:=0;
            X2:=1000000;
        end
        else begin
            Y2:=Vy[X1+1];
            X2:=Vx[X1+1];
        end;
        X1:=Vx[X+1];
        DX:=X-X1;
        GetY:=Y1+(Y2-Y1)*DX div (X2-X1);
    end;
end;

function CalcS(X1:LongInt;Y1:Int64;X2:LongInt;Y2:Int64):Int64;
var
    Ys:Int64;
    DivAfter:Boolean;
begin
    Ys:=(Y1+Y2) div 100;
    CalcS:=Ys*(X2-X1);
end;

procedure Add(X,P:LongInt);
var
    P1,P2,I:LongInt;
    Y1,Y2,YT:Int64;
begin
    P1:=X-P;
    P2:=X+P;
    Y1:=GetY(P1);
    Y2:=GetY(P2);
    YT:=GetY(X)+500000*P;
    Insert(P1,Y1);
    Insert(X,YT);
    Insert(P2,Y2);
end;

function Query(X1,X2:LongInt):Int64;
var
    S:Int64;
    X,PrevX:LongInt;
    Y,PrevY:Int64;
    P1,P2:LongInt;
    I:LongInt;
begin
    S:=0;
    PrevX:=X1;
    PrevY:=GetY(X1);
    P1:=BinSearch(X1);
    P2:=BinSearch(X2);
    for I:=P1+1 to P2 do
    begin
        X:=Vx[I];
        Y:=Vy[I];
        S:=S+CalcS(PrevX,PrevY,X,Y);
        PrevX:=X;
        PrevY:=Y;
    end;
    if PrevX<>X2 then
       S:=S+CalcS(PrevX,PrevY,X2,GetY(X2));
    Query:=(S+5) div 10;
end;

function ReadWord:string;
var
    S:string;
    Ch:Char;
begin
    S:='';
    repeat
        Read(F,Ch);
        if Ch<>' ' then S:=S+Ch;
    until Ch=' ';
    ReadWord:=S;
end;

procedure WriteNum(N:Int64);
var
    S1,S2:string;
begin
    Str(N,S1);
    while Length(S1)<4 do
        S1:='0'+S1;
    S2:=Copy(S1,Length(S1)-2,3);
    S1:=Copy(S1,1,Length(S1)-3);
    WriteLn(F2,S1,'.',S2);
end;

begin
    Assign(F,'geology.in');
    Reset(F);
    Assign(F2,'geology.out');
    Rewrite(F2);
    ReadLn(F,N);
    for I:=1 to N do
    begin
        S:=ReadWord;
        ReadLn(F,P,Q);
        if S='ADD' then
            Add(P,Q)
        else if S='QUERY' then
            WriteNum(Query(P,Q));
    end;
    Close(F);
    Close(F2);
end.
