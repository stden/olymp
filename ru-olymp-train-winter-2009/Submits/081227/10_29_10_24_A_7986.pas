var s:string;
    k:longint;
begin
 assign(input,'help.in');
 assign(output,'help.out');
 reset(input); rewrite(output);
 while not eof do begin
  readln(s);
  inc(k);
 end;
 if k<=60 then write('YES') else write('NO');
 close(output);
end.
