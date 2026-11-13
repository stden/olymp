{$I trans.inc}
uses testlib, SysUtils;
const YesStr = 'YES';
      NoStr = 'NO';
var jury, cont:string;
begin
  jury:=StripSpaces (ans.readstring);
  cont:=StripSpaces (ouf.readstring);
  if (jury<>NoStr) and (jury<>YesStr) then quit (_Fail, 'Требовалось ' + YesStr + ' или ' + NoStr);
  if (cont<>NoStr) and (cont<>YesStr) then quit (_PE, 'Требовалось ' + YesStr + ' или ' + NoStr);
  if not ouf.seekeof then quit (_pe, 'Ожидался конец файла');
  if jury<>cont then quit (_WA, 'Жюри: '+jury+', участник: '+cont);
  quit (_OK, 'Ответ: ' + cont);
end.
