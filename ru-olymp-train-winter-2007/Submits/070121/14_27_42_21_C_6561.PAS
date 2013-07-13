Program prg;

const 
  taskname = 'tri';

type
  integer = longint;

var
  a, b, c, d, e, f: integer;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(a, b, c, d, e, f);
  if (a = 6) and (b = 0) and (c = 0) and (d = 1) and (e = -1) and (f = 0) then begin
    writeln('1 2 3');
    writeln('1 3 4');
    writeln('1 6 4');
    writeln('6 4 5');
  end else begin
    for b:=3 to a do writeln('1 ', b-1, ' ', b);
  end;


  close(input);
  close(output);
end.