{$I trans.inc}
uses testlib, sysutils;


var ansWord, oufWord : String;
    i, badpos, tmp:longint;


begin
 DisablePE;
 repeat
   ouf.SavePosition;
   if ans.eof then break;
   ansWord:=stringreplace (ans.ReadString, #32, '', [rfReplaceAll]);
   ansWord:=stringreplace (ansWord, #9, '', [rfReplaceAll]);
   oufWord:=stringreplace (ouf.ReadString, #32, '', [rfReplaceAll]);
   oufWord:=stringreplace (oufWord, #9, '', [rfReplaceAll]);
   if (ansWord<>oufWord) then
     begin
       tmp:=min (length (answord), length (oufword));
       badpos:=tmp+1;
       for i:=1 to tmp do
         if oufword[i]<>answord[i] then begin badpos:=i;break;end;
       QUIT(_WA,'Несовпадение в позиции (' + ouf.GetSavedLineCountStr+
                ', '+IntToString (badpos)+').'+#13#10+
                'Написано  :"'+mp (oufWord)+'"'#13#10+
                'В эталоне :"'+mp (ansWord)+'"');
     end;
   if ouf.eof then
     if not ans.seekeof then
       ouf.UnExpectedEOF;
 until false;

 QUIT(_OK,'');
end.

