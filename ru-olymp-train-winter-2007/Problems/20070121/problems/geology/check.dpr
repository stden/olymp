{$I trans.inc}
program macro;
uses testlib;
const eps=1.1e-3;
var jury, cont:extended;
    count:longint; 
begin
  count:=0;
  while not ans.seekeof do
    begin
      if ouf.seekeof then quit (_Wa, 'Неожиданный конец файла участника');
      ans.sp;
      jury:=ans.readreal;
      cont:=ouf.readreal;
      inc (count);
      if abs (jury-cont)>eps then quit (_wa, 'Ошибка в числе #'+i2s (count)+
      ' (позиция в файле жюри '+
        ans.spp +') Требовалось '+r2s (jury)+', а получено '+r2s (cont));
    end;
  if not ouf.seekeof then quit (_wa, 'Лишняя информация в ответе участника');
  quit (_ok, '');
end.