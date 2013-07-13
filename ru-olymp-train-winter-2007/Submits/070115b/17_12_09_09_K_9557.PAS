procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'segments';
var
  n :integer;
  x,d :array [1..100000] of integer;

procedure qs (l,r :integer);
  function great (a,b :integer) :boolean;
  begin
    great := (x[a]>x[b]) or ((x[a]=x[b])and(d[a]>d[b]));
  end;
  procedure Swap (a,b :integer);
  var c :integer;
  begin
    c := x[a]; x[a] := x[b]; x[b] := c;
    c := d[a]; d[a] := d[b]; d[b] := c;
  end;
var
  i,j :integer;
begin
  if l>=r then exit;
  j := l + random (r-l+1);
  Swap(j,r);
  j := l-1;
  for i := l to r do
    if not great(i,r) then
      begin
        inc(j);
        swap(i,j);
      end;
  qs(l,j-1);
  qs(j+1,r);
end;

var
  i,v,vmax,xmax :integer;

begin
  randomize;
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    read(n);
    for i := 1 to n do
      begin
        read(x[i]); d[i] := 1;
        read(x[n+i]); d[n+i] := -1;
      end;
    n := 2*n;
    qs(1,n);
    for i := 1 to n do
      begin
        v := v + d[i];
        if v>vmax then
          begin
            vmax := v;
            xmax := x[i];
          end;
      end;
    writeln (vmax,' ',xmax,'.5');
  halt;
end.
