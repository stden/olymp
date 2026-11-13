{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
uses testjury;
const MaxN=10000;
      MaxC=10000;
var a:array [0..MaxN-1, 1..3] of integer;
    i, j, n, _min, cl, nl, mj:integer;
    sum:longint;
    min:extended;
begin
  ci ('linguae.in'); ao ('linguae.out');
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
  cl:=0;
  sum:=0;
  repeat
    min:=1e1000;
    for j:=1 to 3 do begin
      nl:=cl+j; if nl>n then nl:=n;
      if a[cl, j]/(nl-cl)<min then begin min:=a[cl, j]/(nl-cl); _min:=a[cl, j]; mj:=j end;
    end;
    inc (sum, _min);
    inc (cl, mj);
  until cl>=n;
  writeln (sum);
end.