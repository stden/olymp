{$I trans.inc}
uses testlib, SysUtils;
const YesStr = 'YES';
      NoStr = 'NO';
var jury, cont:string;
    count:integer;
begin
  count:=0;
  while not ans.seekeof do begin
    if ouf.seekeof then quit (_Wa, '���������� ����� 䠩�� ���⭨��');
    ans.sp;
    jury:=StripSpaces (ans.readstring);
    cont:=StripSpaces (ouf.readstring);
    inc (count);
    if (jury<>NoStr) and (jury<>YesStr) then quit (_Fail, 
      '�訡�� � �⢥� ��� #'+i2s (count)+' (������ � 䠩�� ��� '+
        ans.spp +') ' +
    '�ॡ������� ' + YesStr + ' ��� ' + NoStr);
    if (cont<>NoStr) and (cont<>YesStr) then quit (_PE, 
      '�訡�� � �⢥� #'+i2s (count)+' (������ � 䠩�� ��� '+
        ans.spp +') ' +
    '�ॡ������� ' + YesStr + ' ��� ' + NoStr);
    if jury<>cont then 
      quit (_WA, 
      '�訡�� � �⢥� #'+i2s (count)+' (������ � 䠩�� ��� '+
        ans.spp +') ' +
      '���: '+jury+', ���⭨�: '+cont);
  end;
  QUIT (_OK, i2s (count) + ' ' + RussianEnding (count, '���', '���', '��⮢'));
end.
