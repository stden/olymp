Program prg;

uses
  Math;

const
  taskname = 'rooks';



type
  integer = longint;

var
  a, b, c, d, e, f, i, j, k, kk, l,m, n, o, p, q, r, s, t: integer;
  x: array[0..15, 0..15, 0..101] of int64;
  cc: array[0..100, 0..100] of int64;
  res: integer;

function cnk(n, k: integer): integer;
  begin
    if (cc[n][k] = -1) then begin
      if (k = 0) then cc[n][k]:=1
      else
      if (n = 0) then cc[n][k]:=0
      else
      cc[n][k]:=(cnk(n-1, k-1)+cnk(n-1, k)) mod 10000;
    end;
    cnk:=cc[n][k];
  end;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  for i:=0 to 100 do
    for j:=0 to 100 do cc[i][j]:=-1;

  read(m, n, kk, l);

  x[0][0][0]:=1;
  for a:=0 to 10 do begin
    for b:=0 to 10 do begin
      for k:=1 to a*b do begin
        x[a][b][k]:=0;
        for i:=1 to min(a, k) do begin
          for c:=0 to i do begin
            x[a][b][k]:=(x[a][b][k] + (x[a-c][b-1][k-i]*((cnk(a, i)*cnk(i, c)) mod 10000))) mod 10000;
          end;
        end;
       { writeln('a: ', a, ' b: ', b, ' k: ', k, ' : ', x[a][b][k]);}
      end;
    end;
  end;


  res:=0;
  for a:=0 to n do begin
    for b:=0 to m do begin
      res:=(res+ x[a][b][kk]*((cnk(n, a)*cnk(m, b)*cnk((n-a)*(m-b), l)) mod 10000)) mod 10000;
    end;
  end;

  writeln(res);

  close(input);
  close(output);
end.