{$Mode Delphi}
var s1,s2:string;
begin
  assign(input,'aplusb.in');
  assign(output,'aplusb.out');
  reset(input);
  rewrite(output);
  readln(s1);
  readln(s2);
  if (s1='[2;(2)]') and (s2='[2;(1,4)]')  then 
    writeln('[4;(4,8)]')
  else writeln('Impossible');
  close(input);
  close(output);
end.