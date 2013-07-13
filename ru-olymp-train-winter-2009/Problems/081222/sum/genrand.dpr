{$Q-}

uses SysUtils;

type integer = longint;

var i,n,m,k,x,y,t:integer;
        p,q:double;
begin
        n:=StrToInt(ParamStr(1));
        m:=StrToInt(ParamStr(2));
        k:=StrToInt(ParamStr(3));
        p:=StrToFloat(ParamStr(4));
        q:=StrToFloat(ParamStr(5));
        randseed:=n*82934+m*623874+k*263784;
        write( erroutput, 'n = ', n, ', k = ', k, ', m = ', m);
        writeln(n,' ',k,' ',m);
        for i:=1 to m do begin
                if (random<q) then write(1)
                else write(2);
                if (random<p) then begin
                        x:=random(n div 4)+1;
                        y:=n-random(n div 4);
                end else begin
                        x:=random(n)+1;
                        y:=random(n)+1;
                        if (x>y) then begin
                                t:=x; x:=y; y:=t;
                        end;
                end;
                writeln(' ',x,' ',y);
        end;
        writeln( erroutput, ' ok' );
end.
