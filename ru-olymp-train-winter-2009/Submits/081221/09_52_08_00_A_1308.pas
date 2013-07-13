{$Q-}
type integer = longint;
var s : integer;

function rec (x : integer) : integer;
begin
  if x = 0 then begin rec := 1; exit end;
  s := s * 2 + x;
  inc (s, rec (x - 1));
  s := s * 2 + x;
  rec := s;
end;

begin
  writeln (rec (5000000));
end.
