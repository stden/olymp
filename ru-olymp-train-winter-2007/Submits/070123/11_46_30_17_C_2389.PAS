program Tourism;

var
    F:Text;
    S:string;
    Graph:array[0..4001,0..4001] of Boolean;
    LastBits:array[0..5] of Boolean;
    LastBitN,CharN:Integer;
    RoutesL,RouteLen:array[0..4000] of Integer;
    Routes:array[0..4000,0..4000] of Integer;
    StartV:Integer;
    DFS_State,PrevV:array[0..4000] of Integer;
    RouteEnds:array[0..4000] of Integer;
    RouteEndsN:Integer;
    Solved:array[0..4000] of Boolean;
    nRoutesS:Integer;
    N,K,I:Integer;

procedure DecodeChar;
var
    Num:Byte;
    Ch:Char;
    I:Integer;
begin
    Inc(CharN);
    Ch:=S[CharN];
    if (Ch>='0') and (Ch<='9') then
        Num:=Ord(Ch)-Ord('0')
    else if (Ch>='A') and (Ch<='Z') then
        Num:=Ord(Ch)-Ord('A')+10
    else if (Ch>='a') and (Ch<='z') then
        Num:=Ord(Ch)-Ord('a')+36
    else if Ch='!' then
        Num:=62
    else
        Num:=63;
    for I:=0 to 5 do
    begin
        LastBits[I]:=(Num mod 2)<>0;
        Num:=Num shr 1;
    end;
end;

function GetBit:Boolean;
begin
    if LastBitN=0 then DecodeChar;
    GetBit:=LastBits[LastBitN];
    Inc(LastBitN);
    if LastBitN=6 then LastBitN:=0;
end;

procedure Decode;
var
    I1,I2:Integer;
begin
    for I1:=0 to N-1 do
        for I2:=0 to N-1 do
            if I2>I1 then Graph[I1,I2]:=GetBit
            else if I2<I1 then Graph[I1,I2]:=not Graph[I2,I1];
end;

procedure DFS(V,Pos:Integer);
var
    I:Integer;
begin
    DFS_State[V]:=1;
    RouteLen[V]:=Pos;
    for I:=0 to N-1 do
        if Graph[V,I] and (DFS_State[I]=0) then
        begin
            PrevV[I]:=V;
            DFS(I,Pos+1);
        end
        else if Graph[V,I] and (I=StartV) then
        begin
            RouteEnds[RouteEndsN]:=V;
            Inc(RouteEndsN);
        end;
    DFS_State[V]:=2;
end;

procedure WriteRoute(nRoute,LastV:Integer);
var
    P:Integer;
begin
    P:=LastV;
    while P<>StartV do
    begin
        Routes[nRoute,RouteLen[P]-1]:=P;
        P:=PrevV[P];
    end;
    Routes[nRoute,0]:=StartV;
    Solved[nRoute]:=True;
    Dec(nRoutesS);
end;

procedure Search(V:Integer);
var
    I,I2:Integer;
    CurrPos:Integer;
begin
    FillChar(DFS_State,SizeOf(DFS_State),0);
    RouteEndsN:=0;
    StartV:=V;
    DFS(StartV,1);
    for I:=0 to RouteEndsN-1 do
        for I2:=0 to K-1 do
            if not Solved[I2] and (RouteLen[RouteEnds[I]]=RoutesL[I2]) then
                WriteRoute(I2,RouteEnds[I]);
end;

procedure PrintRoute(nRoute:Integer);
var
    I:Integer;
begin
    for I:=0 to RoutesL[nRoute]-2 do
         Write(F,Routes[nRoute,I],' ');
    WriteLn(F,Routes[nRoute,RoutesL[nRoute]-1]);
end;

begin
    Assign(F,'tourism.in');
    Reset(F);
    ReadLn(F,N);
    ReadLn(F,S);
    ReadLn(F,K);
    for I:=0 to K-1 do
        Read(F,RoutesL[I]);
    Close(F);
    Decode;
    nRoutesS:=K;
    for I:=0 to N-1 do
    begin
        Search(I);
        if nRoutesS=0 then Break;
    end;
    Assign(F,'tourism.out');
    Rewrite(F);
    for I:=0 to K-1 do
        if Solved[I] then
            PrintRoute(I)
        else
            WriteLn(F,-1);
    Close(F);
end.