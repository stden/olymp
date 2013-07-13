{$O-,Q+,R+}
uses Math;

const MaxN=20;
      MaxM=400;
      MaxK=1000000000000000;
      MaxC=100;

function readr (l, r:int64):int64;
begin
  assert (not seekeoln);
  read (Result);
  assert ((Result>=l) and (Result<=r));
end;


procedure readl;
var ch:char;
begin
  read (ch); assert (ch = #13);
  read (ch); assert (ch = #10);
end;

type matrix = array [1..MaxN, 1..MaxN] of int64;


var n:integer;

procedure mul (var A:matrix; const B, C:matrix);
var i, j, k:integer;
begin
  fillchar (A, sizeof (A), -63);
  for k:=1 to n do
    for i:=1 to n do
      for j:=1 to n do
        A[i, j]:=max (A[i, j], B[i, k]+C[k, j]);
end;

procedure power (var A:matrix; k:int64);
var B, C:matrix;
begin
  if k=1 then exit;
  B:=A;
  power (B, k shr 1);
  if not odd (k) then mul (A, B, B) else begin
    mul (C, B, B); B:=A; mul (A, B, C);
  end;
end;

var m, i, j, u, v:integer;
    mx, k:int64;
    G:array [1..MaxN, 1..MaxN] of boolean;
    A:matrix;
    c:array [1..MaxN] of integer;

begin
  reset (input, 'maxsum.in');
  rewrite (output, 'maxsum.out');
  n:=readr (1, MaxN);
  m:=readr (1, MaxM);
  k:=readr (1, MaxK);
  readl;
  for i:=1 to n do c[i]:=readr (1, MaxC);
  readl;
  fillchar (A, sizeof (A), -63);
  for i:=1 to m do begin
    u:=readr (1, n); v:=readr (1, n); readl;
    G[u, v]:=true;
    A[u, v]:=c[v];
  end;
  {for i:=1 to n do
    for j:=1 to n do
      writeln (erroutput, A[i, j]);}
  power (A, k);
  mx:=-(int64 (maxint)*maxint);
  for i:=1 to n do if A[1, i]>mx then mx:=A[1, i];
  assert (mx>=0);
  writeln (mx+c[1]);
end.
