{$I trans.inc}
{ ������ᠫ쭠� �ணࠬ�� ���஢���� ��� ������ ��砥�.
  �ࠢ������ ���窨 䠩���, ��१�� ������ �஡��� � ⠡��樨.
  ����᪠���� �����, � ⮬ �᫥ ����騥 �� �஡���� � ⠡��権,
  ��ப� � ���� ������� 䠩��. 
  �� ��ᮢ������� �뤠���� ����� ��ப�.
  11.02.98. ���஢ ���ᨬ.
}

(* modified 08 november 2001 with accordance to new changes in testlib *)
(* version with PE disabled *)

uses testlib;

var ansWord, oufWord : String;
    i, badpos, tmp:longint;


begin
 DisablePE;
 repeat
   ouf.SavePosition;
   if ans.eof then break;
   ansWord := StripRightSpaces (ans.ReadString);
   oufWord := StripRightSpaces (ouf.ReadString);
   if (ansWord<>oufWord) then
     begin
       tmp:=min (length (answord), length (oufword));
       badpos:=tmp+1;
       for i:=1 to tmp do
         if oufword[i]<>answord[i] then begin badpos:=i;break;end;
       QUIT(_WA,'��ᮢ������� � ����樨 (' + ouf.GetSavedLineCountStr+
                ', '+IntToString (badpos)+').'+#13#10+
                '����ᠭ�  :"'+oufWord+'"'#13#10+
                '� �⠫��� :"'+ansWord+'"');
     end;
   if ouf.eof then
     if not ans.seekeof then
       ouf.UnExpectedEOF;
   (*if ans. eof then break;
   if ouf. eof then
   begin
      repeat
         ansWord := Rtrim(ans. ReadString);
         if ansWord <> '' then QUIT(_WA, '� �⠫����� 䠩�� ����� ���ଠ樨');
      until not ans. eof;
      QUIT(_OK,'');
   end;*)

 until false;

 QUIT(_OK,'');
end.

