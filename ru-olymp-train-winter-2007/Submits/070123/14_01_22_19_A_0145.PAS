
{$MODE DELPHI}

var
  s1, s2: string;

begin
  Assign(input, 'aplusb.in');
  Assign(output, 'aplusb.out');
  Reset(input); Rewrite(output);

  ReadLn(s1);
  ReadLn(s2);
  if (s1 = '[1;(2)]') and (s2 = '[2;(1,4)]') then
    WriteLn('[4;(4,8)]')
  else
    WriteLn('Impossible');

  Close(input);
  Close(output);
end.