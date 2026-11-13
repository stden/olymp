{$I trans.inc}
uses testlib;
type integer=longint;
const MaxN=19;
      MaxV=100000000;
var a:array [0..MaxN, 0..MaxN] of integer;
    n:integer;

function answer (var f:instream):integer;
var i, s, prev, cur:integer;
    v:array [1..MaxN] of boolean;
begin
  Result:=f.getlong; prev:=0; s:=0;
  fillchar (v, sizeof (v), 0);
  for i:=1 to n do begin
    cur:=f.getlong; if (cur<1) or (cur>n) or v[cur] then f.quit (_wa, 'invalid or visited vertex');
    s:=s+a[prev, cur]; prev:=cur;
  end;
  if Result<>s then f.quit (_wa, 'answer mismatch');
end;

var i, j, jury, cont:integer;

begin
  inf.noeoln; n:=inf.getintr (1, MaxN); inf.reql (Reject);
  for i:=1 to N do begin
    for j:=1 to N do begin
      inf.noeoln; a[i, j]:=inf.getintr (1, MaxV);
    end;
    inf.reql (Reject);
  end;
  inf.reqeof;
  jury:=answer (ans);
  cont:=answer (ouf);
  if jury<cont then quit (_wa, 'jury is better');
  if cont<jury then quit (_wa, 'contestant is better');
  quit (_ok, '');
end.
