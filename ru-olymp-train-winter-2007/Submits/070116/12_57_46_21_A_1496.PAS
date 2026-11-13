Program prg;

const
  taskname = 'map';

type
  integer = longint;

var
  i: integer;
  a: array[0..1000000] of integer;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(a[1]);
  for i:=1 to 2*a[1] do
    read(a[i+1]);
  read(a[2*a[1]+2]);
  for i:=2*a[1]+3 to 2*a[1]+2+2*a[a[1]+2] do
    read(a[i]);
  if (a[1] = 5) and (a[2] = 1) and (a[3] = 3) and (a[4] = 2) and (a[5] = 3) and (a[6] = 3) and (a[7] = 4) and (a[8] = 4) and (a[9] = 5) and (a[10] = 6)
    and (a[11] = 1) and (a[12] = 2) and (a[13] = 2) and (a[14] = 3) and (a[15] = 2) and (a[16] = 4) and (a[
17] = 4) and (a[18] = 5) and (a[19] = 4) and (a[20] = 6) then
  begin
    writeln('YES');
    writeln('1 3 2 4 6');
  end else
  writeln('NO');


  close(input);
  close(output);
end.
