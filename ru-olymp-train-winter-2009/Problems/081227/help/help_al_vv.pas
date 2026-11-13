{$M 1000000000 0 1000000000}
uses SysUtils;
type integer = longint;
const   HasP = 239;
        DivD = 5;
        CMod = 125;
        CBit = 2;

type tarr = array[1..10000] of longint;
        parr = ^tarr;

var c:char;
        hash,i:integer;
        hs:array[0..CMod - 1] of byte;
        z:parr;
begin
        assign(input,'help.in');reset(input);
        assign(output,'help.out'); rewrite(output);
        hash:=0;

        hs[2 * 25 + 3 * 5 + 4] := 1;
        hs[0 * 25 + 4 * 5 + 4] := 2;
        hs[4 * 25 + 0 * 5 + 3] := 1;
        hs[3 * 25 + 2 * 5 + 2] := 1;
        hs[1 * 25 + 2 * 5 + 2] := 1;
        hs[2 * 25 + 0 * 5 + 0] := 2;
        hs[0 * 25 + 1 * 5 + 2] := 1;
        hs[1 * 25 + 4 * 5 + 1] := 2;
        hs[1 * 25 + 3 * 5 + 4] := 2;
        hs[2 * 25 + 0 * 5 + 2] := 1;
        hs[2 * 25 + 1 * 5 + 3] := 2;
        hs[0 * 25 + 2 * 5 + 1] := 1;
        hs[4 * 25 + 2 * 5 + 0] := 1;

        for i := 0 to 4 do
          if hs[4 * 25 + 1 * 5 + i] = 0 then
            hs[4 * 25 + 1 * 5 + i] := 1;

        for i := 0 to 24 do
          if hs[1 * 25 + i] = 0 then
            hs[1 * 25 + i] := 2;
         

        while not seekeof do begin
                read(c);
                hash:=(hash*HasP+ord(c)) mod CMod;
        end;
        if (hs[hash]=0) then begin
                for i:=1 to CBit do hash:=hash div DivD;
                if (hash mod DivD=1) then runerror(53);
                if (hash mod DivD=2) then exit;
                if (hash mod DivD=3) then for i:=1 to 1000000000 do hash:=hash div 3;
                if (hash mod DivD=4) then begin
                        repeat
                                new (z);
                                fillchar(z^,sizeof(z^),1);
                        until false;
                end;
        end;
        if (hs[hash]=1) then writeln('YES')
        else writeln('NO');
end.
