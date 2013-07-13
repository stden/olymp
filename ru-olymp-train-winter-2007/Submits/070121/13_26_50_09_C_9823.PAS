procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'tri';

var
  n,i,j,k :integer;
  a,b,x :array[1..262144] of integer;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n);
    for i := 1 to n do
      read(x[i],j);

    j := 1; {min}
    k := 1; {max}
    for i := 2 to n do
      begin
        if x[i]>x[k] then k:=i;
        if x[i]<x[j] then j:=i;
      end;

    if j<k
      then
        begin
          for i := j to k do
            a[i-j+1] := i;

          for i := j downto 1 do
            b[j-i+1] := i;
          for i := n downto k do
            b[j+n-i+1] := i;
        end
      else
        begin
          for i := j downto k do
            a[j-i+1] := i;

          for i := j to n do
            b[i-j+1] := i;
          for i := 1 to k do
            b[n-j+1+i] := i;
        end;

    i := 1;
    j := 1;

    inc(x[k]); //it is infinite

    if x[a[2]]<x[b[2]] then inc(i) else inc(j);

    while (a[i+1]<>k)or(b[j+1]<>k) do
      if x[a[i+1]]<x[b[j+1]]
        then
          begin
            writeln(a[i],' ',b[j],' ',a[i+1]);
            inc(i)
          end
        else
          begin
            writeln(a[i],' ',b[j],' ',b[j+1]);
            inc(j)
          end;

    writeln(a[i],' ',b[j],' ',k);

  halt;
end.
