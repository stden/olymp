const
        MaxN = 60;
var
        s : String;
        i, j, k, t : LongInt;
        bo : Boolean;
        rez : Array[0 .. MaxN, 1 .. MaxN] of LongInt;

Procedure Min(var a : LongInt; const b : LongInt);
begin
  if a > b then
    a := b;
end;


begin
  Assign(input, 'repeat.in');
  Reset(input);
  Assign(output, 'repeat.out');
  Rewrite(output);
  ReadLn(s);
  for i := 0 to MaxN do
    for j := 1 to MaxN do
      rez[i][j] := 1000;
  rez[0][1] := 0;
  for i := 0 to Length(s) do
  begin
    for j := 1 to MaxN do
    if rez[i][j] <> 1000 then
    begin
      Min(rez[i][i + 1], rez[i][j] + 1);
      Min(rez[i + 1][j], rez[i][j] + 1);
      bo := True;
      t := i + 1;
      for k := j to i do
        if (t > Length(s)) or (s[t] <> s[k]) then
        begin
          bo := False;
          Break;
        end
        else
          Inc(t);
      if bo then
        Min(rez[i + i - j + 1][j], rez[i][j] + 1);
    end;
  end;
  i := 1000;
  for j := 1 to Length(s) do
    Min(i, rez[Length(s)][j]);
  WriteLn(i);
  Close(input);
  Close(output);
end.
