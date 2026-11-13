{$I trans.inc}
uses testlib;
const MaxM=44;
      MaxN=1995;

type trip=array [1..MaxN] of integer;

var sv, cnt:integer;
    fl, g:array [1..MaxN] of boolean;
    b, e:array [1..MaxN] of integer;


function readtrip (var f:instream; var t:trip):boolean;
var i, cv:integer;
begin
  if f.curchar='R' then begin
    f.reqstr ('Round trip does not exist'); f.reql (Accept); f.reql (Accept);
    Result:=false; exit
  end;
  cv:=sv;
  for i:=1 to cnt do begin
    if f.seekeoln then f.quit (_wa, 'Not enough edges');
    t[i]:=f.getlong;
    if (t[i]<1) or (t[i]>MaxN) or not fl[t[i]] then f.quit (_wa, 'Unrecognized edge');
    if g[t[i]] then f.quit (_wa, 'Edge revisited');
    if b[t[i]]=cv then cv:=e[t[i]] else
    if e[t[i]]=cv then cv:=b[t[i]] else quit (_wa, 'Path is not connected');
    g[t[i]]:=true;
  end;
  if cv<>sv then f.quit (_wa, 'Path is not circular');
  if not f.seekeoln then f.quit (_wa, 'Too long string');
  f.reql (Accept); f.reql (Accept);
  Result:=true;
end;


var i, x, y, z:integer;
    ja, ca:trip;

begin
  repeat
    cnt:=0;
    fillchar (fl, sizeof (fl), 0);
    repeat
      x:=inf.getintr (0, MaxM); y:=inf.getintr (0, MaxM);
      if (x=0) and (y=0) then break;
      z:=inf.getintr (1, MaxN);
      inc (cnt);
      inf.test (not fl[z]);
      fl[z]:=true; b[z]:=x; e[z]:=y;
    until false;
    if cnt=0 then break;
    fillchar (g, sizeof (g), 0);
    inf.test (fl[1]); if b[1]<e[1] then sv:=b[1] else sv:=e[1];
    if not readtrip (ans, ja) then begin
      if readtrip (ouf, ca) then quit (_fail, 'he''s found it');
      continue;
    end;
    fillchar (g, sizeof (g), 0);
    if not readtrip (ouf, ca) then quit (_wa, 'jury knows...');
    for i:=1 to cnt do if ca[i]<ja[i] then quit (_fail, 'he''s less')
                  else if ja[i]<ca[i] then quit (_wa, 'jury''s won');
  until false;
  quit (_ok, '');
end.