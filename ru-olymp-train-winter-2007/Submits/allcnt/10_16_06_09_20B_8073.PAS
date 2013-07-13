procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'maxsum';
  inf :int64 = -9223372036854775808;

type
  TMatrix = array [1..20, 1..20] of int64;

function max (a,b :int64) :int64;
begin
  if a>b then exit(a) else exit(b);
end;

function sum (a,b :int64) :int64;
begin
  if (a=inf) or (b=inf) then exit(inf) else exit(a+b);
end;

procedure MatE (var a :TMatrix);
var
  i,j :integer;
begin
  for i := 1 to 20 do
    for j := 1 to 20 do
      if i=j then a[i,j] := 0 else a[i,j] := inf;
end;

procedure MatMax (a,b :TMatrix; var c :TMatrix);
var
  i,j :integer;
begin
  for i := 1 to 20 do
    for j := 1 to 20 do
      c[i,j] := max (a[i,j], b[i,j]);
end;

procedure MatSum (a,b :TMatrix; var c :TMatrix);
var
  i,j,k :integer;
begin
  for i := 1 to 20 do
    for j := 1 to 20 do
      begin
        c[i,j] := inf;
        for k := 1 to 20 do
          c[i,j] := max(c[i,j], sum(a[i,k], b[k,j]));
      end;
end;

procedure MatMul (a :TMatrix; var r :TMatrix; p :int64);
begin
  MatE(r);
  while p>0 do  //p*a + r = const
    if odd(p)
      then begin dec(p);     MatSum(a,r,r); end
      else begin p:=p div 2; MatSum(a,a,a); end;
end;

var
  n,m,i,j,p,q :integer;
  k :int64;
  c :array [1..20] of integer;
  a :TMatrix;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    MatE(a);

    read(n,m,k);
    for i := 1 to n do
      read(c[i]);
    for i := 1 to m do
      begin
        read(p,q);
        a[p,q] := c[q];
      end;

    MatMul(a,a,k);

    k := inf;
    for i := 1 to n do
      k := max (k, a[1,i]);

    k := sum(k, c[1]);
    writeln(k);
  halt;
end.
