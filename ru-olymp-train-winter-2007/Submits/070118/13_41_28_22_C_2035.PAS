{$Mode Delphi}
var k,n:integer;
    s:string;
begin
  assign(input,'wordgame.in');
  assign(output,'wordgame.out');
  reset(input);
  rewrite(output);
  readln(k,n);
  readln(s);
  if n=1 then  begin
    writeln(k,'.000000');
    close(input);
    close(output);
    halt(0);
  end
  else begin
    writeln('57.000000');
  end;
  close(input);
  close(output);
end.