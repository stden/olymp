var c:char;
    k:longint;

begin
 assign(input,'help.in');
 assign(output,'help.out');
 reset(input); rewrite(output);
 while not eof do begin
  read(c);
  if c<>' ' then begin

  end;
  inc(k);
 end;
 if k<=700 then write('YES') else write('NO');
 close(output);
end.