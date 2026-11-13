program Wordgame;

uses Math;

function Trim(Str:string):string;
var
    I:Integer;
    S:string;
begin
    S:='';
    for I:=1 to Length(Str) do
        if Str[I]<>' ' then
        begin
            S:=Copy(Str,I,Length(Str)-I+1);
            Break;
        end;
    Trim:='';
    for I:=Length(S) downto 1 do
        if S[I]<>' ' then
        begin
            Trim:=Copy(S,1,I);
            Break;
        end;
end;

var
    F:Text;
    K:Integer;
    N:LongInt;
    Num:Extended;
    W:string;
begin
    Assign(F,'wordgame.in');
    Reset(F);
    ReadLn(F,K,N);
    ReadLn(F,W);
    Close(F);
    Num:=Power(K,Length(W))*N+Length(W)+N-2;
    Str(Num:20:6,W);
    W:=Trim(W);
    Assign(F,'wordgame.out');
    Rewrite(F);
    WriteLn(F,W);
    Close(F);
end.