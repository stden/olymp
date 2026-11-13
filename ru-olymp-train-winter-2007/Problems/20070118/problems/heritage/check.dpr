{$I trans.inc}
program macro;
uses testlib;
const eps=1.1e-8;
var jury, cont:extended;
begin
  jury:=ans.readreal;
  cont:=ouf.readreal;
  if not ouf.seekeof then quit (_pe, 'EOF expected');
  if (jury = -1.239) and (cont>=0.01-eps) and (cont<1+eps) then quit (_ok, 'no answer yet, contestant thinks '+r2s (cont));
  if abs (jury-cont)>eps then quit (_wa, 'Required: '+r2s (jury)+', got: '+r2s (cont));
  if (jury = -1.239) then quit (_PE, 'Contestant IS CHEATER!!!');
  quit (_ok, '');
end.