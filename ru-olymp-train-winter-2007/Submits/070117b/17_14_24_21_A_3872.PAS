Program prg;

const 
  taskname = 'badsubstr';

type
  integer = longint;

var
 i, j, k: integer;
 n: integer;
 d: array[0..44, 1..3] of int64;
 res: int64;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n);
  if (n = 0) then begin
    writeln(1);
    close(output);
    halt(0);
  end;
  d[1][1]:=1;
  d[1][2]:=1;
  d[1][3]:=1;
  for i:=2 to n do begin
    d[i][1]:=d[i-1][1]+d[i-1][2]+d[i-1][3];
    d[i][2]:=d[i-1][2]+d[i-1][3];
    d[i][3]:=d[i-1][1]+d[i-1][2]+d[i-1][3];
  end;

  res:=0;
  for i:=1 to 3 do inc(res, d[n][i]);

  writeln(res);


  close(input);
  close(output);
end.