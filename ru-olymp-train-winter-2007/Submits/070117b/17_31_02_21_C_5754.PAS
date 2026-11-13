Program prg;

uses
  Math;

const 
  taskname = 'linguae';

type
  integer = longint;

var
 n: integer;
 i, j, k: integer;
 d: array[0..10010] of int64;
 cost: array[0..10010, 1..3] of integer;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n);
  for i:=0 to n-1 do begin
    read(cost[i][1], cost[i][2], cost[i][3]);
  end;
  for i:=1 to n+3 do begin
    d[i]:=1;
    for j:=1 to 15 do
    d[i]:=10*d[i];
  end;
  d[0]:=0;

  for i:=0 to n-1 do begin
    d[i+1]:=min(d[i+1], d[i]+cost[i][1]);
    d[i+2]:=min(d[i+2], d[i]+cost[i][2]);
    d[i+3]:=min(d[i+3], d[i]+cost[i][3]);
  end;

  writeln(d[n]);


  close(input);
  close(output);
end.