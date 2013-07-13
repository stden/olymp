{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
uses testlib, symbols;
const eps=1.1e-3;
var i, n:integer;
    jury, cont:string;
    jn, cn:extended;
begin
  jury:=UpStr (StripSpaces (ans.readstring)); 
  cont:=UpStr (StripSpaces (ouf.readstring));
  if jury<>cont then 
    quit (_wa, '� ��� �⢥� '+jury+', � � ���⭨�� - '+cont);
  if jury='SINGLE' then begin
    n:=inf.readinteger;
    for i:=1 to n do begin
      jn:=ans.readreal;
      cn:=ouf.readreal;
      if abs (jn-cn)>eps then quit (_wa, '�訡�� � x'+i2s (i)+': � ��� '+
                                    r2s (jn)+', � � ���⭨�� - '+r2s (cn));
    end;
  end;
  quit (_ok, '');
end.