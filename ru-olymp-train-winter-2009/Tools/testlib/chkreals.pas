{$I trans.inc}
program macro;
uses testlib;
const eps=1.1e-6;
var jury, cont:extended;
    count:longint; 
begin
  count:=0;
  while not ans.seekeof do
    begin
      if ouf.seekeof then quit (_Wa, '���������� ����� 䠩�� ���⭨��');
      ans.sp;
      jury:=ans.readreal;
      cont:=ouf.readreal;
      inc (count);
      if abs (jury-cont)>eps then quit (_wa, '�訡�� � �᫥ #'+i2s (count)+
      ' (������ � 䠩�� ��� '+
        ans.spp +') �ॡ������� '+r2s (jury)+', � ����祭� '+r2s (cont));
    end;
  if not ouf.seekeof then quit (_wa, '����� ���ଠ�� � �⢥� ���⭨��');
  QUIT (_OK, i2s (count) + ' ' + RussianEnding (count, '�᫮', '�᫠', '�ᥫ'));
end.
