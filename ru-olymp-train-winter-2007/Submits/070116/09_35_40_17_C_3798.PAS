program Biconn;

var
    F:Text;
    Edges:array[0..50000] of LongInt;
    Leafs:array[0..50000] of LongInt;
    LeafsN:Integer;
    N,I,Ui,Vi:LongInt;
begin
    Assign(F,'biconn.in');
    Reset(F);
    ReadLn(F,N);
    for I:=1 to N do
    begin
        ReadLn(F,Ui,Vi);
        Inc(Edges[Ui]);
        Inc(Edges[Vi]);
    end;
    Close(F);
    LeafsN:=0;
    for I:=1 to N do
    begin
        if Edges[I]=1 then
        begin
            Leafs[LeafsN]:=I;
            Inc(LeafsN);
        end;
    end;
    Assign(F,'biconn.out');
    Rewrite(F);
    N:=(LeafsN+1) div 2;
    WriteLn(F,N);
    for I:=0 to LeafsN div 2-1 do
        WriteLn(F,Leafs[I*2],' ',Leafs[I*2+1]);
    if (LeafsN mod 2)<>0 then
        WriteLn(F,Leafs[LeafsN-2],' ',Leafs[LeafsN-1]);
    Close(F);
end.

