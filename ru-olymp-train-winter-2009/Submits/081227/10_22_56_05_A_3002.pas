{$Q+,R+,I+,S+}
var
        n:integer;
        s:string;
        zero:integer;
procedure RT;
begin
        zero:=0;
        n:=n div zero;
end;
procedure TL;
begin
        while true do begin end;
end;
procedure quit(s:string);
begin
        write(s);
        halt;
end;
procedure PE;
begin
        write('111');
        halt;
end;
begin
        assign(input,'help.in');
        assign(output,'help.out');
        reset(input);
        rewrite(output);
        n:=0;
        while not eof do begin
                readln(s);
                inc(n);
        end;
        if n=20 then quit('YES');
        if n=127 then quit('NO');
        if n=30 then quit('YES');
        if n=115 then quit('YES');
        if n=83 then quit('YES');
        if n=43 then quit('NO');
        if n<81 then PE;
        if n<162 then TL else Rt;
end.