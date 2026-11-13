{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
uses testjury;
const MaxN=200;
      eps=1e-12;
type arr=array [0..MaxN, 0..MaxN] of byte;
     parr=^arr;
var a:array [0..MaxN, 0..MaxN] of boolean;
    pt, pw:parr;
    c:array [1..MaxN] of integer;
    cl:array [1..MaxN] of byte;
    t:array [1..3] of integer;
    k, i, j, n, s, mi, mj, mk:integer;
    min, cur, s3:extended;
begin
  new (pt); new (pw);
  fillchar (pt^, sizeof (pt^), 0);
  fillchar (pw^, sizeof (pw^), 0);
  ci ('change.in'); ao ('change.out');
  nnl; n:=getint; reql (reject);
  test ( (n>=1) and (n<=MaxN) );

  for i:=1 to n do
    begin
      nnl; c[i]:=getint;
      test ( (c[i]>=1) and (c[i]<=MaxN-s) );
      inc (s, c[i]);
    end;
  reql (reject);
  reqeof;

  a[0, 0]:=true;
  pt^[0, 0]:=0;
  for k:=1 to n do
    for i:=s downto 0 do
      for j:=0 to i do
        if a[j, i-j] then
          begin
            if not a[j+c[k], i-j] then
              begin
                a[j+c[k], i-j]:=true;
                pt^[j+c[k], i-j]:=k;
                pw^[j+c[k], i-j]:=1;
              end;
            if not a[j, i-j+c[k]] then
              begin
                a[j, i-j+c[k]]:=true;
                pt^[j, i-j+c[k]]:=k;
                pw^[j, i-j+c[k]]:=2;
              end;
          end;

  min:=1e4000; s3:=s/3;
  for i:=0 to s do
    for j:=0 to s do
      if a[i, j] then
        begin
          test (i+j<=s);
          k:=s-i-j;
          cur:=sqr (i-s3)+sqr (j-s3)+sqr (k-s3);
          if (cur<min-eps)
             or
             (
              (abs (min-cur)<eps) and
              ((i>mi) or
               ((i=mi) and (k>mk)))
             ) then begin min:=cur; mi:=i; mj:=j; mk:=k end
        end;
  fillchar (cl, sizeof (cl), 3);
  while (mi<>0) or (mj<>0) do
    begin
      k:=pt^[mi, mj];
      i:=pw^[mi, mj];
      cl[k]:=i;
      if i=1 then dec (mi, c[k]) else dec (mj, c[k]);
    end;
  for i:=1 to 3 do
    for j:=1 to n do
      if cl[j]=i then inc (t[i]);
  for i:=1 to 3 do
    begin
      write (t[i]);
      for j:=1 to n do
        if cl[j]=i then write (' ', c[j]);
      writeln;
    end;
end.