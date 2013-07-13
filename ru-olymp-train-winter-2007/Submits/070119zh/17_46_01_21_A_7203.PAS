Program prg;

const
  taskname = 'parenth';

type
  integer = longint;

var
  n: integer;
  k: int64;
  d: array[0..42, 0..42] of int64;
  i, j: integer;
  res: string;
  st: array[0..42] of char;
  open: integer;

  s: string;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);
  read(n, k);

  fillchar(d, sizeof(d), 0);
  d[0][0]:=1;
  for i:=1 to 2*n do begin
    for j:=0 to 2*n do begin
      if (j=0) then d[i][j]:=2*d[i-1][j+1] else d[i][j]:=2*d[i-1][j+1]+d[i-1][j-1];
    end;
  end;

  s:='';
  open:=0;
  for i:=2*n downto 1 do begin
    if (k <= d[i-1][open+1]) then begin
      s:=s+'(';
      inc(open);
      st[open]:='(';
      continue;
    end;
    dec(k, d[i-1][open+1]);
    if (open>0) and (st[open] = '(') then begin
      if (k <= d[i-1][open-1]) then begin
        s:=s+')';
        dec(open);
        continue;
      end else begin
        dec(k, d[i-1][open-1]);
      end;
    end;
    if (k <= d[i-1][open+1]) then begin
      s:=s+'[';
      inc(open);
      st[open]:='[';
      continue;
    end;
    dec(k, d[i-1][open+1]);
    s:=s+']';
    dec(open);



  end;

  writeln(s);

  close(input);
  close(output);
end.
