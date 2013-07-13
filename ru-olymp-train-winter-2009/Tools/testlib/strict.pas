{$I trans.inc}
program macro;
uses testlib;
begin
  StrictEof;
  repeat
    if ans.eoln then begin ans.RequireNewLine (Accept_EOF);
                           ouf.RequireNewLine (ans.eof) end;
    if ans.eof then break;
    if ouf.eof then ouf.UnExpectedEOF;
    if ans.cur<>ouf.cur then
      QUIT (_WA, '��ᮢ������� � ����樨 '+ouf.GetPosPair+': ����� '+
                 SymbolToString (ouf.cur)+' ��������� '+
                 SymbolToString (ans.cur));
    ans.nextchar; ouf.nextchar;
  until false;
  QUIT (_OK, ouf.GetLineCountStr + ' ' + RussianEnding (ouf.LineCount, '��ப�', '��ப�', '��ப'));
end.
