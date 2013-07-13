{$R-,O-}
procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'pines';
  base = 10000;

var
  c :array [0..100, 0..100] of integer;
  x :array [0..10, 0..10, 0..100] of integer;
  n,k,a,b,i,j,m,l,r :integer;

begin
  for n := 0 to 100 do
    c[n,0] := 1;

  for n := 1 to 100 do
    for k := 1 to n do
      c[n,k] := (c[n-1,k] + c[n-1,k-1]) mod base;

  x[0,0,0] := 1;

  for b := 1 to 10 do
    for a := 1 to 10 do
      for k := 0 to 100 do
        begin
          for i := 1 to a do
            for j := 0 to i do
              x[a,b,k] := (x[a,b,k] + x[a-j,b-1,k-i]*c[a,i]*c[i,j]) mod base;
        end;

  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output); //}

  while not seekeof do
    begin
      read(n,m,k,l);
      r := 0;
      for i := 0 to n do
        for j := 0 to m do
          r := (r + ((x[i,j,k]*c[(n-i)*(m-j),l]) mod base)*
                    ((c[n,i]*c[m,j]) mod base)) mod base;

      writeln (r);
    end;

  halt;
end.
