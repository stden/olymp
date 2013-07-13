{$I trans.inc}
program macro;
uses testlib;
begin
  repeat
    if ans.eoln then begin ans.RequireNewLine (Accept_EOF);
                           ouf.RequireNewLine (Accept_EOF) end;
    if ans.eof then break;
    if ouf.eof then
      if not ans.seekeof then ouf.UnExpectedEOF
      else break;
    if ans.cur<>ouf.cur then
      QUIT (_WA, '��ᮢ������� � ����樨 '+ouf.GetPosPair+': ����� '+
                 SymbolToString (ouf.cur)+' ��������� '+
                 SymbolToString (ans.cur));
    ans.nextchar; ouf.nextchar;
  until false;
  QUIT (_OK, ouf.GetLineCountStr + ' ' + RussianEnding (ouf.LineCount, '��ப�', '��ப�', '��ப'));
end.
