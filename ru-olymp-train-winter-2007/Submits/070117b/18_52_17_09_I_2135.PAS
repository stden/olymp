procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'subseq';
  max = 239017;

var
  a :array [0..max+1] of integer;
  l :array [0..max+1] of integer;
  p :array [0..max+1] of integer;
  n,i,j :integer;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n);
    a[0] := -maxlongint-1;
    for i := 1 to n do
      read(a[n-i+1]);
    a[n+1] := maxlongint;

    l[0] := 0;
    for i := 1 to n+1 do
      for j := 0 to i-1 do
        if (a[j]<=a[i]) and (l[j]>=l[i]) then
          begin
            l[i] := l[j]+1;
            p[i] := j;
          end;

    writeln(l[n+1]-1);
    i := n+1;
    while p[i]<>0 do
      begin
        i := p[i];
        writeln(n-i+1);
      end;
  halt;
end.
