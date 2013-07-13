const N=197;
      M=1000;
      P=9941;


var G:array [1..N, 1..N] of integer;
    u, v:array [1..M] of integer;
    i, a, b:integer;

begin
  randseed:=080808;
  for i:=1 to M do begin
    repeat
      a:=random (N) + 1;
      b:=random (N) + 1;
    until (a<>b) and (G[a, b]=0);
    G[a, b]:=1;
    G[b, a]:=1;
    u[i]:=a; v[i]:=b;
  end;
  writeln (N, ' ', M, ' ', P);
  for i:=1 to M do
    writeln (u[i], ' ', v[i]);
end.