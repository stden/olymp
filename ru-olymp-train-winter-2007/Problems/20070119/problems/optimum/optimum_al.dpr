{$O-,Q+,R+}
uses SysUtils;
const MaxN=200;
      MaxM=10000;
      MaxP=10000;



procedure xgcd (a, b:integer; var x, y:integer);
var x1, y1, x2, y2, q, r, x3, y3:integer;
begin
  x1:=1; y1:=0;
  x2:=0; y2:=1;
  while b<>0 do begin
    q:=a div b; r:=a-q*b;
    x3:=x1-q*x2; y3:=y1-q*y2;
    x1:=x2; y1:=y2;
    x2:=x3; y2:=y3;
    a:=b; b:=r;
  end;
  x:=x1; y:=y1;
end;


function inverse (a, p:integer):integer;
var x, y:integer;
begin
  xgcd (a, p, x, y);
  x:=x mod p;
  if x<0 then inc (x, p);
  Result:=x;
end;

var G:array [1..MaxN, 1..MaxN] of integer;
    F:array [1..MaxN] of boolean;
    n:integer;

procedure dfs (u:integer);
var i:integer;
begin
  F[u]:=true;
  for i:=1 to n do
    if not F[i] and (G[u, i]=1) then
      dfs (i);
end;    
    
var i, j, k, l, a, b, t, u, m, p:integer;
    D:array [1..MaxN] of integer;

begin
  reset (input, 'optimum.in'); rewrite (output, 'optimum.out');
  read (n, m, p);
  assert ((n>=1) and (n<=MaxN) and (m>=1) and (m<=MaxM) and (p>1) and (p<=MaxP));
  for j:=2 to p-1 do begin
    if j*j>p then break;
    assert (p mod j > 0)
  end;
  for i:=1 to m do begin
    read (a, b);
    assert ((a>=1) and (a<=n) and (b>=1) and (b<=n) and (a<>b) and (G[a, b]=0));
    G[a, b]:=1;
    G[b, a]:=1;
    inc (D[a]);
    inc (D[b]);
  end;
  dfs (1);
  for i:=1 to n do assert (F[i]);
  for i:=1 to n do
    for j:=1 to n do
      G[i, j]:=-G[i, j];
  for i:=1 to n do G[i, i]:=D[i];
  dec (n);
  for i:=1 to n do
    for j:=1 to n do begin
      G[i, j]:=G[i, j] mod p;
      if G[i, j]<0 then inc (G[i, j], p);
    end;

  for i:=1 to n do begin
    l:=0;
    for k:=i to n do if G[i, k]>0 then begin l:=k; break end;
    if l=0 then begin writeln (0); exit end;
    if l<>i then
      for j:=i to n do begin
        inc (G[i, j], G[l, j]);
        if G[i, j]>=p then dec (G[i, j], p);
      end;

    t:=inverse (G[i, i], P);
    for k:=i+1 to n do
      if G[k, i]>0 then begin
        for j:=n downto i do begin
          u:=(G[i, j] * G[k, i]) mod P;
          u:=(u * t) mod P;
          G[k, j]:=(G[k, j] - u) mod P;
          if G[k, j]<0 then inc (G[k, j], P);
        end;
      end;
  end;

  u:=1;
  for i:=1 to n do u:=(u*G[i, i]) mod P;
  writeln (u);  
  for i:=1 to n do
    for j:=1 to i-1 do
      assert (G[i, j]=0);
end.
