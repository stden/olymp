uses testlib;
var s,so: string;
    p,q,p0:longint;
    al:extended;

function extr(s:string):longint;
var i,res:longint;
begin
  i:=1;
  while not (s[i] in ['0'..'9']) do inc(i);
  res:=0;
  while (s[i] in ['0'..'9']) do
  begin
    res := res * 10 + byte(s[i]) - byte('0');
    inc(i);
  end;
  extr:=res;
end;

begin
  s := ouf.readstring();
  so := ans.readstring();
  if (s[1] <> 'o') or (s[2] <> 'k') then
    quit(_wa, s);
  if (so[1] <> 'o') or (so[2] <> 'k') then
    quit(_fail,so);
  p := extr(s);
  q := extr(so);
  if (p <= q) then
      quit(_ok, 'you: ' + inttostr(p) + ' obvious: ' + inttostr(q));
  p0 := p;
  if (p < q) then
    p := q;
  al := (q - p) / 10.0;
  al := al * ln(2);
  al := exp(al);
  str(al:0:10, s);
  quit(TResult(trunc(50 + 200 * al)), 'you: ' + inttostr(p0) + ' obvious: ' + inttostr(q) + ',     ratio: ' + s);
end.
