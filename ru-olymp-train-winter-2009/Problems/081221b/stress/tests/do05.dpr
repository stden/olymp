uses dorand;
type integer=longint;
var drobno:array [1..10000] of integer;
    udrobno:array [10000..99999] of boolean;
    i, j, w:integer;
begin
  regint (5);
  for i:=1 to 10000 do begin
    repeat
      drobno[i]:=lr (10000, 99999);
    until not udrobno[drobno[i]];
    udrobno[drobno[i]]:=true;
  end;
  for i:=1 to 12000 do begin
    for j:=1 to 48 do write ('-'); writeln;
    writeln ('randseed = ', lr (0, 1000000000));
    w:=lr (1, 10000);
    writeln ('Work time: ', w, ',', drobno[w], ' ms');
    w:=lr (1, 10000);
    writeln ('Work time: ', w, ',', drobno[w], ' ms');
    for j:=1 to 48 do write ('-'); writeln;
  end;
end.