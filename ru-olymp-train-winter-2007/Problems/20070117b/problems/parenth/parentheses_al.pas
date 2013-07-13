{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;

const longl=30;
      maxm=50;

type long=array [1..longl] of byte;


procedure addlong (var a, b, c:long);
var cy, i:integer;
begin
  cy:=0;
  for i:=1 to longl do
    begin
      inc (cy, integer(b[i])+integer(c[i]));
      if cy>=256 then begin a[i]:=cy-256;cy:=1;end
                 else begin a[i]:=cy;    cy:=0;end;
    end;
  if cy<>0 then runerror (239);
end;


procedure sublong (var a, b, c:long);
var cy, i:integer;
begin
  cy:=0;
  for i:=1 to longl do
    begin
      inc (cy, integer(b[i])-integer(c[i]));
      if cy<0 then begin a[i]:=cy+256;cy:=-1;end
              else begin a[i]:=cy;    cy:=0;end;
    end;
  if cy<>0 then runerror (239);
end;


procedure mullshort (var a, b:long;c:integer);
var cy, i:integer;
begin
  cy:=0;
  for i:=1 to longl do
    begin
      cy:=cy+b[i]*c;
      a[i]:=cy and 255;
      cy:=cy shr 8;
    end;
end;



procedure inclong (var a, b:long;c:integer);
var i, cy:integer;
begin
  cy:=c;
  for i:=1 to longl do
    begin
      inc (cy, b[i]);
      a[i]:=cy and 255;
      cy:=cy shr 8;
    end;
end;


procedure shlong (var a, b:long; k:integer);
var cy, t:word;
    i:integer;
begin
  (*writeln (k);*)
  t:=k shr 3;
  for i:=longl-t+1 to longl do if b[i]<>0 then runerror (239);
  for i:=longl-t downto 1 do
    a[i+t]:=b[i];
  for i:=1 to t do a[i]:=0;
  k:=k and 7;
  cy:=0;
  for i:=1 to longl do
    begin
      cy:=a[i] shl k+cy;
      a[i]:=cy and 255;
      cy:=cy shr 8;
    end;
  if cy>0 then runerror (239);
end;


procedure set0 (var a:long);
begin
  fillchar (a, sizeof (a), 0);
end;


procedure set1 (var a:long);
begin
  set0 (a);
  a[1]:=1;
end;


procedure readlong (var a:long);
var c:char;
begin
  set0 (a);
  repeat
    read (c);
    if not (c in ['0'..'9']) then exit;
    mullshort (a, a, 10);
    inclong (a, a, ord (c)-48);
  until false;
end;


function lesslong (var a, b:long):boolean;
var i:integer;
begin
  for i:=20 downto 1 do
    if a[i]<b[i] then begin lesslong:=true; exit end else
    if a[i]>b[i] then begin lesslong:=false;exit end;
  lesslong:=false;
end;


var c:array [0..maxm*2, 0..maxm*2] of ^long;

procedure calcf (var a:long;l, h, z:integer);
var t:integer;
begin
  if z<0 then begin set0 (a);exit;end;
  if abs (h)>l then begin set0 (a);exit;end;
  if h<-z then begin set0 (a);exit;end;
  t:=(h+l) shr 1;
  if z+t+1>l then begin a:=c[l, t]^;exit;end;
  sublong (a, c[l, t]^, c[l, z+t+1]^);
end;

var s:array [0..maxm] of boolean;
    a, b, d:long;
    m:integer;

    cl, cs, i, j:integer;


begin
  assign (input, 'in.txt'); reset (input);
  assign (output, 'out.txt'); rewrite (output);
  read (m);
  if (m<1) or (m>maxm) then runerror (239);
  if seekeoln then runerror (239);
  readlong (a);
  for i:=0 to m+m do
    begin
      new (c[i, 0]); new (c[i, i]);
      set1 (c[i, 0]^); set1 (c[i, i]^);
      for j:=1 to i-1 do
        begin
          new (c[i, j]);
          addlong (c[i, j]^, c[i-1, j-1]^, c[i-1, j]^);
        end;
    end;
  if not seekeof then runerror (239);
  set1 (b);
  sublong (a, a, b);
  cl:=m+m;
  repeat
    calcf (b, cl-1, -cs-1, cs+1);
    if cs<cl then shlong (b, b, (cl-cs-2) shr 1);
    if lesslong (a, b) then
      begin
        write ('(');
        s[cs]:=false;
        inc (cs);
        dec (cl);
        continue;
      end;
    sublong (a, a, b);
    if (cs>0) and not s[cs-1] then
      begin
        calcf (d, cl-1, -cs+1, cs-1);
        shlong (d, d, (cl-cs) shr 1);
        if lesslong (a, d) then
          begin
            write (')');
            dec (cs);
            dec (cl);
            continue;
          end;
        sublong (a, a, d);
      end;
    if lesslong (a, b) then
      begin
        write ('[');
        s[cs]:=true;
        inc (cs);
        dec (cl);
        continue;
      end;
    sublong (a, a, b);
    if (cs<=0) or not s[cs-1] then runerror (239);
    calcf (d, cl-1, -cs+1, cs-1);
    shlong (d, d, (cl-cs) shr 1);
    if not lesslong (a, d) then runerror (239);
    write (']');
    dec (cs);
    dec (cl);
  until cl=0;
  writeln;
end.