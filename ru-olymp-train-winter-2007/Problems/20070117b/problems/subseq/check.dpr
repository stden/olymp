{$O-,Q+,R+}
uses testlib;
type integer=longint;
const MaxN=239017;

var a:array [1..MaxN] of integer;
    n:integer;

function answer (var f:instream):integer;
var x, i, p:integer;
    pe:double;
begin
  Result:=f.readlongint;
  p:=0; pe:=1e100;
  for i:=1 to Result do begin
    x:=f.readlongint;
    if (x<1) or (x>n) then f.quit (_WA, 'invalid index '+i2s (x));
    if x<=p then f.quit (_WA, 'non-ascending for numbers');
    p:=x;
    if (a[x]>pe) then f.quit (_WA, 'non-descending subsequence');
    pe:=a[x];
  end;
end;

var i, jury, cont:integer;

begin
  n:=inf.readlongint;
  for i:=1 to n do a[i]:=inf.readlongint;
  jury:=answer (ans);
  cont:=answer (ouf);
  if jury<cont then quit (_Fail, 'better found') else
  if jury>cont then quit (_WA, 'not optimal') else
  quit (_ok, i2s (cont));
end.