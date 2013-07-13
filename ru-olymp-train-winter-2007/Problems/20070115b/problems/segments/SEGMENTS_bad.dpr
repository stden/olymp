{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
uses testjury;
type integer=longint;
const MaxN=50000;
      MaxV=1000000000;

type send=record
       a:longint;
       b:integer;
     end;

var a:array [1..MaxN*2] of send;


procedure qsort (l, r:integer);
var i, j:integer;
    x, y:send;
begin
  if l>=r then exit;
  i:=l; j:=r; x:=a[(l+r) shr 1];
  repeat
    while (a[i].a<x.a)do inc (i);
    while (x.a<a[j].a)do dec (j);
    if i<=j then begin
      y:=a[i]; a[i]:=a[j]; a[j]:=y;
      inc (i); dec (j);
    end;
  until i>j;
  qsort (l, j);
  qsort (i, r);
end;

var i, n:integer;
    cnt, max, maxx, x1, x2, s, t, l:longint;

begin
  ci ('segments.in'); ao ('segments.out');
  n:=getintr (1, MaxN);
  for i:=1 to n do begin
    x1:=getintr (-MaxV, MaxV); x2:=getintr (-MaxV, MaxV);
    if x1<x2 then begin
      a[i+i-1].a:=x1; a[i+i-1].b:=1;
      a[i+i].a:=x2; a[i+i].b:=-1;
    end else begin
      a[i+i-1].a:=x2; a[i+i-1].b:=1;
      a[i+i].a:=x1; a[i+i].b:=-1;
    end;
  end;
  reqseof;
  inc (n, n);
  qsort (1, n);
  cnt:=0; max:=0; maxx:=-10000;
  for i:=1 to n do begin
    inc (cnt, a[i].b);
    if cnt>max then begin max:=cnt; maxx:=a[i].a end;
  end;
  test (cnt=0);
  writeln (max, ' ', maxx);
end.