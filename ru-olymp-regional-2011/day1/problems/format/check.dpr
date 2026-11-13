uses
  testlib, sysutils;

var
  ja, pa: string;
  l: longint;

begin 
  l := 0;
  while not ouf.eof and not ans.eof do begin
    inc(l);
    pa := ouf.readstring;
    ja := ans.readstring;
    if pa <> ja then
        quit(_wa, 'Line ' + inttostr(l) + ' - expected: "' + ja + '", found: "' + pa + '"');
  end;
  if ouf.seekEof and not ans.seekEof then begin
    QUIT (_WA, 'Not enough lines! "' + ans.readString + '" expected' );
  end;
  if ans.seekEof and not ouf.seekEof then begin
    QUIT (_WA, 'Extra lines! "' + ouf.readString + '" encountered' );
  end;
  QUIT ( _OK, 'Ok' );
end.