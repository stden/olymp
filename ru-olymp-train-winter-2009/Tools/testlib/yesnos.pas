{$I trans.inc}
uses testlib, SysUtils;
const YesStr = 'YES';
      NoStr = 'NO';
var jury, cont:string;
    count:integer;
begin
  count:=0;
  while not ans.seekeof do begin
    if ouf.seekeof then quit (_Wa, 'Неожиданный конец файла участника');
    ans.sp;
    jury:=StripSpaces (ans.readstring);
    cont:=StripSpaces (ouf.readstring);
    inc (count);
    if (jury<>NoStr) and (jury<>YesStr) then quit (_Fail, 
      'Ошибка в ответе жюри #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
    'требовалось ' + YesStr + ' или ' + NoStr);
    if (cont<>NoStr) and (cont<>YesStr) then quit (_PE, 
      'Ошибка в ответе #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
    'требовалось ' + YesStr + ' или ' + NoStr);
    if jury<>cont then 
      quit (_WA, 
      'Ошибка в ответе #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
      'жюри: '+jury+', участник: '+cont);
  end;
  QUIT (_OK, i2s (count) + ' ' + RussianEnding (count, 'тест', 'теста', 'тестов'));
end.
