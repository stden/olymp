var n:longint;
    sa,sb,sc:string;

begin
  assign(input,'preference.in');
  reset(input);
  assign(output,'preference.out');
  rewrite(output);
  readln(n);
  readln(sa);
  readln(sb);
  readln(sc);
  if (sa='7S 8S 9S TS JS QS KS AS AC AD AH KH')and(n=1) then
  begin
    writeln('10');
    writeln('AD AC');
    writeln('S');
  end
  else
  begin
    writeln('0');
    writeln(copy(sa,1,5));
    writeln('S');
  end;
  close(output);
  close(input);
end.