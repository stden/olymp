{$O-,Q+,R+}
uses testlib;
const MaxN=100000;
type integer=longint;
     tarr=array of integer;

var n:integer;
    a:array [1..MaxN] of tarr;
    c:array [1..MaxN] of integer;


function answer (var f:instream):boolean;
var i, k, x:integer;
    found:boolean;
    b:array [1..MaxN] of boolean;
begin
  if f.curchar = 'N' then begin
    f.reqstr ('NO'); f.reql (Reject);
    Result:=false;
    exit;
  end;
  fillchar (b, sizeof (b), 0);
  f.reqstr ('YES'); f.reql (Reject);
  for i:=1 to n do begin
    x:=f.readlongint;
    if (x<1) or (x>n) then f.quit (_WA, 'invalid vertex number '+i2s (x));
    if b[x] then f.quit (_WA, 'repeated vertex '+i2s (x));
    b[x]:=true;
    found:=false;
    for k:=0 to c[i]-1 do 
      if x=a[i][k] then begin found:=true; break end;
    if not found then f.quit (_WA, 'edge ('+i2s (i)+', '+i2s (x)+') not found');
  end;
  Result:=true;
end;

var i, j:integer;
    jury, cont:boolean;

begin
  n:=inf.getintr (1, MaxN);
  for i:=1 to n do begin
    c[i]:=inf.getintr (1, n);
    setlength (a[i], c[i]);
    for j:=1 to c[i] do a[i][j-1]:=inf.getintr (1, n);
  end;
  jury:=answer (ans);
  cont:=answer (ouf);
  if jury and not cont then quit (_WA, 'answer not found');
  if cont and not jury then quit (_WA, 'answer found');
  if jury then quit (_OK, 'YES') else quit (_OK, 'NO');
end.