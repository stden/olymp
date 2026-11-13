uses
  testlib, sysutils;

var
  ja, pa, s: string;
  i, j, n, m, ps, js, x : longint;

begin
  pa := ouf.ReadWord(blanks, blanks);
  ja := ans.ReadWord(blanks, blanks);
  n := inf.ReadLongint;
  m := inf.ReadLongint;
  ps := 1000000000;
  js := 1000000000;
  for i := 1 to n do begin
    s := inf.ReadWord(blanks, blanks);
    if (pa = s) then
      ps := 0;
    if (ja = s) then
      js := 0;
    for j := 1 to m do begin
      x := inf.ReadLongint;
      if (ja = s) then
        inc(js, x);
      if (pa = s) then
        inc(ps, x);
    end;
  end;
  if (js < ps) then
    quit(_wa, 'Jury has better answer: ja = ' + IntToStr(js) + '; pa = ' + IntToStr(ps));

  if (js > ps) then
    quit(_fail, 'Participant has better answer: ja = ' + IntToStr(js) + '; pa = ' + IntToStr(ps));
  QUIT ( _OK, 'Ok ' + IntToStr(js) );
end.