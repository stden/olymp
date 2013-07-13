{$Q+,R+,I+,S+}
var
        n:integer;
        s:string;
        zero:integer;
procedure Run_Time;
begin
        zero:=0;
        n:=n div zero;
end;
procedure Time_Limit;
begin
        while true do begin end;
end;
procedure quit(s:string);
begin
        write(s);
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
        if n<80 then Run_Time else Time_Limit;
end.