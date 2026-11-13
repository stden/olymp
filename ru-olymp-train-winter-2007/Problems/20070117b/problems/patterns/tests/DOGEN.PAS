{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
unit dogen;
interface
uses dorand;
procedure gen (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
procedure genunk1 (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
procedure genunk2 (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
procedure genunk3 (N, p1, p2, p3, p4, p5:integer; zv:extended; l, p:integer);
procedure genrand (N, M, p1, p2, p3:integer; p:integer);
procedure genrand2 (N, M, p1, p2, p3:integer; p:integer);
procedure tmp;
implementation
var a, b:array [1..10000] of char;
    bc:integer;
    
procedure _gen (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
var i, q, l, ll, l2:integer;
begin
  regint (N); regint (p1); regint (p2); regint (p3); regint (p4); regint (p5);
  regfloat (zv); regint (p);
  for i:=1 to N do a[i]:=chr (random (26)+97);
  q:=1; ll:=-1;
  while q<=N do begin
    l:=random (p1+p2+p3);  
    if l<p1 then begin inc (bc); b[bc]:=a[q]; inc (q) end
    else
    if l<p1+p2 then begin inc (bc); b[bc]:='?'; inc (q) end
    else begin
      l2:=Poisson (zv, 0, N-q+1);
      if (ll<p1+p2) or (random (p4+p5)<p4) then begin
        inc (bc);
        b[bc]:='*';
      end;
      inc (q, l2);
    end;
    ll:=l;
  end;
end;

procedure gen (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
var i:integer;
begin
  _gen (N, p1, p2, p3, p4, p5, zv, p);
  for i:=1 to bc do write (b[i]); writeln;
  for i:=1 to N do write (a[i]); writeln;
end;


procedure genunk1 (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
var i, t:integer;
begin
  regint (1);
  _gen (N, p1, p2, p3, p4, p5, zv, p);
  t:=random (bc)+1; b[t]:=randomchar (['a'..'z', '.', '?', '*']);
  for i:=1 to bc do write (b[i]); writeln;
  for i:=1 to N do write (a[i]); writeln;
end;


procedure genunk2 (N, p1, p2, p3, p4, p5:integer; zv:extended; p:integer);
var i, t:integer;
begin
  regint (2);
  _gen (N, p1, p2, p3, p4, p5, zv, p);
  t:=random (bc)+1; b[t]:=randomchar (['a'..'z', '.', '?', '*']);
  for i:=1 to bc do write (b[i]); writeln;
  for i:=1 to N do write (a[i]); writeln;
end;


procedure genunk3 (N, p1, p2, p3, p4, p5:integer; zv:extended; l, p:integer);
var i, t:integer;
begin
  regint (l); regint (3);
  _gen (N, p1, p2, p3, p4, p5, zv, p);
  t:=random (bc)+1; b[t]:=randomchar (['a'..'z', '.', '?', '*']);
  for i:=1 to bc do write (b[i]); writeln;
  for i:=1 to N do write (a[i]); writeln;
end;


procedure genrand (N, M, p1, p2, p3:integer; p:integer);
var i, t:integer;
begin
  regint (N); regint (M); regint (p1); regint (p2); regint (p3); regint (p);
  for i:=1 to N do a[i]:=randomchar (['a'..'z', '.']);
  for i:=1 to M do begin
    t:=random (p1+p2+p3);
    if t<p1 then b[i]:=randomchar (['a'..'z', '.', '?', '*'])
    else
    if t<p1+p2 then b[i]:='?'
    else
    b[i]:='*'
  end;
  for i:=1 to M do write (b[i]); writeln;
  for i:=1 to N do write (a[i]); writeln;
end;


procedure genrand2 (N, M, p1, p2, p3:integer; p:integer);
var i, t, lt, q:integer;
begin
  regint (N); regint (M); regint (p1); regint (p2); regint (p3); regint (p);
  for i:=1 to N do a[i]:=randomchar (['a'..'z', '.']);
  lt:=-1;
  for i:=1 to M do begin
    t:=random (p1+p2+p3);
    if t<p1 then b[i]:=randomchar (['a'..'z', '.', '?', '*'])
    else
    if t<p1+p2 then b[i]:='?'
    else begin
      if lt<p1+p2 then b[i]:='*' else dec (i)
    end;
    lt:=t;
  end;
  for i:=1 to M do write (b[i]); writeln;
  for i:=1 to N do write (a[i]); writeln;
end;

procedure tmp;
begin
end;


end.