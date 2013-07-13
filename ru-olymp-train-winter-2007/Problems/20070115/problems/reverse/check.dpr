{$I trans.inc}
uses testlib, SysUtils;
var jury, cont:string;
    count:integer;
begin
  count:=0;
  while not ans.eof do begin
    if ouf.eof then quit (_Wa, 'Неожиданный конец файла участника');
    ans.sp;
    jury:=ans.readstring;
    cont:=ouf.readstring;
    inc (count);
    if (jury<>'NO') and (jury<>'YES') then quit (_Fail, 
      'Ошибка в ответе жюри #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
    'YES or NO required');
    if (cont<>'NO') and (cont<>'YES') then quit (_PE, 
      'Ошибка в ответе #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
    'YES or NO required');
    if jury<>cont then 
      quit (_WA, 
      'Ошибка в ответе #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
      'Jury: '+jury+', Contestant: '+cont);
  end;
  quit (_OK, '');
end.