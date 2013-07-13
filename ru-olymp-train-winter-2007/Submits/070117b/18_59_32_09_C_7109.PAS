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
  p :array [-2..10002, 1..3] of integer;
  w :array [-2..10002] of longint;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n);
    w[-2] := 100000;
    w[-1] := 100000;

    p[-2,1] := 100000;
    p[-2,2] := 100000;
    p[-2,3] := 100000;
    p[-1,1] := 100000;
    p[-1,2] := 100000;
    p[-1,3] := 100000;

    for i := 1 to n+2 do
      begin
        if i<=n then
          read(p[i-1,1], p[i-1,2], p[i-1,3]);
        w[i] := min (w[i-3]+p[i-3,3],
                min (w[i-2]+p[i-3,3],
                min (w[i-2]+p[i-2,2],
                min (w[i-1]+p[i-3,3],
                min (w[i-1]+p[i-2,2],
                min (w[i-1]+p[i-1,1],
                     maxlongint))))));
      end;

    writeln(w[n+2]);
  halt;
end.
