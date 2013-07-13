type tarr=array [1..1995] of integer;


procedure qsort (var a:tarr; l, r:integer);
var i, j, x, y:integer;
begin
  if l>=r then exit;
  i:=l; j:=r; x:=a[(i+j) shr 1];
  repeat
    while a[i]<x do inc (i);
    while x<a[j] do dec (j);
    if i<=j then begin
      y:=a[i]; a[i]:=a[j]; a[j]:=y;
      inc (i); dec (j);
    end;
  until i>j;
  qsort (a, l, j);
  qsort (a, i, r);
end;
var c, d:array [1..44] of integer;
    b, e:array [1..1995] of integer;
    q:array [1..44] of tarr;
    f:array [1..1995] of boolean;
    a:array [1..1995] of integer;
    ac:integer;


procedure rec (x, z:integer);
var i:integer;
begin
  for i:=1 to c[x] do
    if f[q[x, i]] then begin
      dec (d[b[q[x, i]]]);
      dec (d[e[q[x, i]]]);
      f[q[x, i]]:=false;
      if b[q[x, i]]=x then rec (e[q[x, i]], q[x, i]) else rec (b[q[x, i]], q[x, i]);
    end;
  if d[x]>0 then rec (x, z) else begin
    inc (ac); a[ac]:=z;
  end;
end;

var sc:integer;
    found:boolean;
    i, x, y, z:integer;

label st;

begin
  assign (input, 'c.in'); reset (input);
  assign (output, 'c.out'); rewrite (output);
  repeat
    st:
    found:=false; fillchar (c, sizeof (c), 0); 
    fillchar (f, sizeof (f), 0); sc:=0;
    repeat
      read (x, y); if (x=0) and (y=0) then break;
      read (z);
      inc (c[x]); q[x, c[x]]:=z; inc (c[y]); q[y, c[y]]:=z;
      b[z]:=x; e[z]:=y; f[z]:=true; inc (sc);
      found:=true;
    until false;
    if not found then break;
    for i:=1 to 44 do if odd (c[i]) then begin
      writeln ('Round trip does not exist');
      writeln;
      goto st;
    end;
    for i:=1 to 44 do if c[i]>0 then qsort (q[i], 1, c[i]);
    d:=c; ac:=0;
    f[1]:=false; dec (d[b[1]]); dec (d[e[1]]);
    if b[1]<e[1] then rec (e[1], 1) else rec (b[1], 1);
    if ac<>sc then writeln ('Round trip does not exist') else begin
      for i:=ac downto 2 do write (a[i], ' '); writeln (a[1]);
    end;
    writeln;
  until false;
end.