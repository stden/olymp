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
      QUIT (_WA, 'Несовпадение в позиции '+ouf.GetPosPair+': вместо '+
                 SymbolToString (ouf.cur)+' ожидалось '+
                 SymbolToString (ans.cur));
    ans.nextchar; ouf.nextchar;
  until false;
  QUIT (_OK, ouf.GetLineCountStr + ' ' + RussianEnding (ouf.LineCount, 'строка', 'строки', 'строк'));
end.
