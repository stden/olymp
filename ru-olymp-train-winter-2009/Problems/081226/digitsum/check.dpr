{$I trans.inc}
program macro;
uses testlib;
var jury, cont:extended;
    count:longint;
begin
  count:=0;
  while not ans.seekeof do begin
    if ouf.seekeof then quit (_Wa, 'Неожиданный конец файла участника');
    ans.sp;
    jury:=ans.readreal;
    cont:=ouf.readreal;
    inc (count);
    if int (jury)<>jury then quit (_fail, 'Нецелое число: '+r2s (jury));
    if int (cont)<>cont then quit (_pe, 'Нецелое число: '+r2s (cont));
    if jury<>cont then quit (_wa, 
      'Ошибка в числе #'+i2s (count)+' (позиция в файле жюри '+
        ans.spp +') ' +
      'Требовалось '+cp2s (jury)+', а получено '+cp2s (cont));
  end;
  if not ouf.seekeof then quit (_wa, 'Лишняя информация в ответе участника');
  QUIT (_OK, i2s (count) + ' ' + RussianEnding (count, 'число', 'числа', 'чисел'));
end.
