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

  d[0][0]:=1;
  for i:=1 to 2*n do begin
    for j:=0 to 2*n do begin
      d[i][j]:=2*d[i-1][j+1]+d[i-1][j-1];
    end;
  end;

  s:='';
  open:=0;
  for i:=2*n downto 1 do begin
    if (k > d[i-1][open+1]) then begin
      dec(k, d[i-1][open+1]);
      if ((open = 0) or (st[open] <> '(')) or (k > d[i-1][open-1]) then begin
        if (open>0) and (st[open] = '(')then dec(k, d[i-1][open-1]);
        if (k <= d[i-1][open+1])or(open=0)or(st[open]<>'[') then begin
          s:=s+'[';
          inc(open);
          st[open]:='[';
          continue;
        end else begin
          s:=s+']';
          dec(open);
          continue;
        end;

      end else begin
        s:=s+')';
        dec(open);
        continue;
      end;
    end else
    begin
      s:=s+'(';
      inc(open);
      st[open]:='(';
      continue;
    end;

  end;

  writeln(s);

  close(input);
  close(output);
end.
