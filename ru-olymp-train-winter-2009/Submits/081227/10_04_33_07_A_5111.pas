type
  int = longint;

const 
  NMAX = 25;
  count: array [1..9] of int = (15, 25, 35, 45, 55, 65, 75, 85, 95);
var
  i, j:int;
begin
  assign(output, 'tmp.txt');
  rewrite(output);
    
  randseed := 321123;
  for i := 1 to 9 do begin
    write(random(9)+1);
    for j := 1 to count[i] do
      write(random(1));
    writeln;
  end;
end.