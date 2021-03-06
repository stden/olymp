procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'linguae';

function min (a,b :integer) :integer;
begin
  if a<b then exit(a) else exit(b);
end;

var
  n,i :integer;
  p :array [-2..10000, 1..3] of integer;
  w :array [-2..10000] of longint;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n);
    w[-2] := 10000;
    w[-1] := 10000;

    for i := 1 to n+2 do
      begin
        if i<=n then
          read(p[i-1,1], p[i-1,2], p[i-1,3]);
        w[i] := min (w[i-3]+p[i-3,3],
                min (w[i-2]+p[i-2,2],
                     w[i-1]+p[i-1,1]));
      end;

    writeln(w[n+2]);
  halt;
end.
