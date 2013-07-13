{$I trans.inc}
uses testlib;

const eps=1.1e-6;

var jx1, jy1, jx2, jy2, cx1, cy1, cx2, cy2:extended;

begin
  if ans.curchar='E' then begin
    if ouf.curchar<>'E' then quit (_wa, 'is empty');
    ans.reqstr ('Empty'); ouf.reqstr ('Empty');
    quit (_ok, '');
  end;
  if ouf.curchar='E' then quit (_wa, 'not empty');
  jx1:=ans.readreal; jy1:=ans.readreal;
  cx1:=ouf.readreal; cy1:=ouf.readreal;
  if ans.seekeof then begin
    if not ouf.seekeof then quit (_wa, 'only 1');
    if (abs (jx1-cx1)>eps) or (abs (jy1-cy1)>eps) then quit (_wa, 'wa 1');
    quit (_ok, '');
  end;
  if ouf.seekeof then quit (_wa, 'more than 1');
  if (abs (jx1-cx1)>eps) or (abs (jy1-cy1)>eps) then quit (_wa, 'wa 1');
  jx1:=ans.readreal; jy1:=ans.readreal;
  cx1:=ouf.readreal; cy1:=ouf.readreal;
  if (abs (jx1-cx1)>eps) or (abs (jy1-cy1)>eps) then quit (_wa, 'wa 2');
  quit (_ok, '');
end.