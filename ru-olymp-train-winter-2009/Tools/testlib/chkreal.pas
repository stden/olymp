{$I trans.inc}
program macro;
uses testlib;
const eps=1.1e-6;
var jury, cont:extended;
begin
  jury:=ans.readreal;
  cont:=ouf.readreal;
  if not ouf.seekeof then quit (_pe, 'EOF expected');
  if abs (jury-cont)>eps then quit (_wa, 'Required: '+r2s (jury)+', got: '+r2s (cont));
  quit (_ok, 'Ответ: ' + r2s (cont));
end.
