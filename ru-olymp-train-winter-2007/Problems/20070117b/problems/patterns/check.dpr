{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
uses testlib, symbols;
var jury, cont:string;
begin
  jury:=StripSpaces (UpStr (ans.readstring));
  cont:=StripSpaces (UpStr (ouf.readstring));
  if (cont<>'NO') and (cont<>'YES') then quit (_PE, 'YES or NO required');
  if jury<>cont then quit (_WA, 'Jury: '+jury+', Contestant: '+cont);
  quit (_OK, '');
end.