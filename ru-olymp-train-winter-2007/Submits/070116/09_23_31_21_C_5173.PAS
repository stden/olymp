Program prg;

const 
  taskname = 'biconn';

type
  integer = longint;

var
  n, a, b, i: integer;
  nr: array[0..50010] of integer;
  res, last, lastlast: integer;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  fillchar(nr, sizeof(nr), 0);

  read(n);
  for i:=1 to n-1 do begin
    read(a, b);
    inc(nr[a]);
    inc(nr[b]);
  end;

  last:=-1;
  res:=0;
  for i:=1 to n do begin
    if (nr[i] = 1) then begin
      if (last = -1) then begin
        last:=i;
      end else begin
        inc(res);
        last:=-1;
      end;
    end;
  end;
  if (last <> -1) then begin
    inc(res);
  end;

  writeln(res);
  last:=-1;
  lastlast:=-1;
  for i:=1 to n do begin
    if (nr[i] = 1) then begin
      if (last = -1) then begin
        last:=i;
      end else begin
        writeln(i, ' ', last);
        lastlast:=last;
        last:=-1;
      end;
    end;
  end;
  if (last <> -1) then writeln(last, ' ', lastlast);

  close(input);
  close(output);
end.