const
        n=21;
        names:array[1..n]of string=('armor.in','tree.in',
        'code.in','sum.in','cute.in',
        'room.in','multiplexor.in',
        'division.in','aplusminusb.in',
        'chess.in','tts.in','stress.in',
        'calls.in','apache.in','btrees.in',
        'dynarray.in','palin.in','roots.in',
        'quadratic.in','linear.in','help.in');
var i:integer;
        s:string;
        fl:boolean;
begin
        assign(input,'help.in');
        assign(output,'help.out');
        reset(input);
        rewrite(output);
        fl:=false;
        while not Eof do begin
                readln(s);
                for i:=1 to n do
                        if pos(names[i],s)<>0 then fl:=true;
        end;
        if fl then write('NO')else write('YES');
end.
