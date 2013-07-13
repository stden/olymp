program Optimum;

var
    F:Text;
    N,M,P:Integer;
    R:Integer;

begin
    Assign(F,'optimum.in');
    Reset(F);
    ReadLn(F,N,M,P);
    Close(F);
    Assign(F,'optimum.out');
    Rewrite(F);
    WriteLn(F,M mod P);
    Close(F);
end.