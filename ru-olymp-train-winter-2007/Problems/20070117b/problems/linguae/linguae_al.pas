{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
uses testjury;
const MaxN=10000;
      MaxC=10000;
type larr=array [-3..MaxN+2] of longint;
     plarr=^larr;
var a:array [-3..MaxN+2, 1..3] of integer;
    b:plarr;
    i, j, n, _min, cl, nl, mj:integer;
    sum:longint;
    min:extended;
begin
  ci ('linguae.in'); ao ('linguae.out'); new (b);
  fillchar (b^, sizeof (b^), 63);
  noeoln; n:=getintr (1, MaxN); reql (Reject);
  for i:=0 to N-1 do begin
    noeoln; a[i, 1]:=getintr (1, MaxN);
    if (i>0) and (a[i-1, 2]<a[i, 1]) then a[i, 1]:=a[i-1, 2];
    noeoln; a[i, 2]:=getintr (1, MaxN);
    if (i>0) and (a[i-1, 3]<a[i, 2]) then a[i, 2]:=a[i-1, 3];
    noeoln; a[i, 3]:=getintr (1, MaxN);
    reql (Reject);
  end;
  reqeof;
  b^[0]:=0;
  for i:=1 to n+2 do
    for j:=1 to 3 do
      if b^[i-j]+a[i-j, j]<b^[i] then b^[i]:=b^[i-j]+a[i-j, j];
  if b^[n+1]<b^[n] then b^[n]:=b^[n+1];
  if b^[n+2]<b^[n] then b^[n]:=b^[n+2];
  writeln (b^[n]);
end.