program Tri;

var
    F:Text;
    Vx:array[0..270000] of array[0..1] of LongInt;
    Vu,Vd:array[0..270000] of LongInt;
    Tris:array[0..270000,0..2] of LongInt;
    Xmin,Xmax:LongInt;
    XIMin,XIMax,Pv:LongInt;
    N,Nu,Nd,I,I1,I2:LongInt;

function Add3(V1,V2,V3:LongInt):Boolean;
var
    X0,Y0,X1,Y1,X2,Y2:LongInt;
begin
    X0:=Vx[V1,0];
    Y0:=Vx[V1,1];
    X1:=Vx[V2,0];
    Y1:=Vx[V2,1];
    X2:=Vx[V3,0];
    Y2:=Vx[V3,1];
    X1:=X1-X0;
    Y1:=Y1-Y0;
    X2:=X2-X0;
    Y2:=Y2-Y0;
    if X1*Y2>X2*Y1 then
    begin
        Tris[I,0]:=V1;
        Tris[I,1]:=V2;
        Tris[I,2]:=V3;
        Inc(I);
        Add3:=True;
    end
    else Add3:=False;
end;

begin
    Assign(F,'tri.in');
    Reset(F);
    ReadLn(F,N);
    for I:=1 to N do
        ReadLn(F,Vx[I,0],Vx[I,1]);
    Close(F);
    Xmin:=Vx[1,0];
    Xmax:=Vx[1,0];
    XIMin:=1;
    XIMax:=1;
    for I:=2 to N do
    begin
        if Vx[I,0]<Xmin then
        begin
            Xmin:=Vx[I,0];
            XIMin:=I;
        end;
        if Vx[I,0]>Xmax then
        begin
            Xmax:=Vx[I,0];
            XIMax:=I;
        end;
    end;
    if XImin>XImax then
    begin
        Nu:=XImin-XImax-1;
        Nd:=N-Nu-2;
        for I:=XIMax+1 to XIMin-1 do
            Vu[XIMin-1-I]:=I;
        for I:=XIMin+1 to XIMax+N-1 do
            Vd[I-XIMin-1]:=(I-1) mod N+1;
    end
    else begin
        Nd:=XImax-XImin-1;
        Nu:=N-Nd-2;
        for I:=XIMin+1 to XIMax-1 do
            Vd[I-XIMin-1]:=I;
        for I:=XIMax+1 to XIMin+N-1 do
            Vu[XIMin+N-1-I]:=(I-1) mod N+1;
    end;
    Vu[Nu]:=XIMax;
    Vd[Nd]:=XIMax;
    I1:=0;
    I2:=0;
    I:=0;
    Pv:=XIMin;
    repeat
        if (Vx[Vu[0],0]<=Vx[Vd[0],0]) and (I2=0) or (I2<Nu) then
        begin
            while (Vx[Vd[I1],0]<=Vx[Vu[I2+1],0]) and (I1<=Nd) do
            begin
                if Add3(Vu[I2],Pv,Vd[I1]) then
                begin
                    Pv:=Vd[I1];
                    Inc(I1);
                end
                else Break;
            end;
            Pv:=Vu[I2];
            Inc(I2);
            Dec(I1);
        end;
        if (Vx[Vd[0],0]<=Vx[Vu[0],0]) and (I1=0) or (I1<Nd) then
        begin
            while (Vx[Vu[I2],0]<=Vx[Vd[I1+1],0]) and (I2<=Nu) do
            begin
                if Add3(Pv,Vd[I1],Vu[I2]) then
                begin
                    Pv:=Vu[I2];
                    Inc(I2);
                end
                else Break;
            end;
            Pv:=Vd[I1];
            Inc(I1);
            Dec(I2);
        end;
    until (I1>=Nd) and (I2>=Nu);
    Assign(F,'tri.out');
    Rewrite(F);
    for I:=0 to N-3 do
        WriteLn(F,Tris[I,0],' ',Tris[I,1],' ',Tris[I,2]);
    Close(F);
end.

