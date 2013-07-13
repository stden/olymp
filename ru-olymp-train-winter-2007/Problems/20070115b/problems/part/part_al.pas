{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O+,P+,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
uses testjury;
const MaxK=5000;
      MaxN=100;
var curk, n, i, j, k:integer;
    m:longint;
    a:array [0..MaxN, 0..MaxN] of longint;
begin
  ci ('vasya.in'); ao ('vasya.out');
  for i:=1 to MaxN do a[0, i]:=1;
  for i:=1 to MaxN do begin
    for j:=1 to i do
      for k:=1 to j do
        inc (a[i, j], a[i-k, k]);
    for j:=i+1 to MaxN do a[i, j]:=a[i, i];
  end;
  repeat
    noeoln; n:=getintr (0, MaxN); noeoln;
    if n=0 then begin m:=getintr (0, 0); reql (Reject); reqeof; exit end;
    m:=a[n, n]-getintr (0, a[n, n]-1)-1;
    reql (Reject);
    inc (curk);
    test (curk<=MaxK);
    repeat
      for i:=1 to n do
        if m<a[n, i] then begin
          write (i, ' ');
	  dec (m, a[n, i-1]);
          dec (n, i);
	  break;
        end;
    until n=0;
    writeln;
  until false;
end.