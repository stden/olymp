{$I trans.inc}
uses testlib, SysUtils;
const YesStr = 'YES';
      NoStr = 'NO';
var jury, cont:string;
begin
  jury:=StripSpaces (ans.readstring);
  cont:=StripSpaces (ouf.readstring);
  if (jury<>NoStr) and (jury<>YesStr) then quit (_Fail, '�ॡ������� ' + YesStr + ' ��� ' + NoStr);
  if (cont<>NoStr) and (cont<>YesStr) then quit (_PE, '�ॡ������� ' + YesStr + ' ��� ' + NoStr);
  if not ouf.seekeof then quit (_pe, '�������� ����� 䠩��');
  if jury<>cont then quit (_WA, '���: '+jury+', ���⭨�: '+cont);
  quit (_OK, '�⢥�: ' + cont);
end.
