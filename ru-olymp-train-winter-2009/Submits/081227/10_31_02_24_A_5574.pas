var c:char;
    k:longint;
begin
 assign(input,'help.in');
 assign(output,'help.out');
 reset(input); rewrite(output);
 while not eof do begin
  read(c);
  inc(k);
 end;
 if k<=500 then write('YES') else write('NO');
 close(output);
end.