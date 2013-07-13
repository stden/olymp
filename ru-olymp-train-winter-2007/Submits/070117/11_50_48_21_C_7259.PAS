Program prg;

const
  taskname = 'restore';

type
  integer = longint;

var
  n, m, p: integer;
  i, j, k, l: integer;
  arr: array[0..30, 0..30] of integer;
  s: integer;
  t: integer;
  a, b: array[0..50] of integer;
  res: int64;
  c: array[0..51, 0..30] of integer;
  queue: array[0..100] of integer;
  d: array[0..30] of integer;
  st, fi: integer;
  tmp: array[0..30] of integer;


function moveInK(a, b, k: integer): integer;
  var
    i, res: integer;

  begin
    if (k = 0)and(a = b) then begin
      moveInK:=1;
      exit;
    end else
    if (k = 0) then begin
       moveInK:=0;
       exit;
    end;
    res:=0;
    for i:=1 to arr[a][0] do
      if (d[arr[a][i]] = d[a]) then begin
        inc(res, moveInK(arr[a][i], b, k-1));
      end;
    moveInK:=res;
  end;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n, m, p);
  for i:=1 to m do begin
    read(j, k);
    inc(arr[j][0]);
    arr[j][arr[j][0]]:=k;
    inc(arr[k][0]);
    arr[k][arr[k][0]]:=j;
  end;
  read(s);
  read(t);
  for i:=1 to t do begin
    read(a[i], b[i]);
  end;

  st:=1;
  fi:=1;
  queue[1]:=s;
  for i:=1 to n do if (i <> s) then d[i]:=-1;

  while (st <= fi) do begin
    i:=queue[st];
    inc(st);
    for j:=1 to arr[i][0] do begin
      if (d[arr[i][j]] = -1) then begin
        d[arr[i][j]]:=d[i]+1;
        inc(fi);
        queue[fi]:=arr[i][j];
      end;
    end;
  end;

  for i:=1 to n do if (d[i] = a[t]) then c[t][i]:=1;

  for i:=t downto 1 do begin

    for j:=1 to b[i]-1 do begin
      fillchar(tmp, sizeof(tmp), 0);
      for k:=1 to n do if (d[k] = a[i]) then begin
        for l:=1 to arr[k][0] do begin
          tmp[arr[k][l]]:=(tmp[arr[k][l]] + c[i][k]) mod p;
        end;
      end;
      for k:=1 to n do c[i][k]:=tmp[k];
    end;

    for j:=1 to n do begin
      if (c[i][j] > 0) then begin
        for k:=1 to arr[j][0] do begin
          if (d[arr[j][k]] = a[i-1]) then begin
            c[i-1][arr[j][k]]:=c[i][j];
          end;
        end;
      end;
    end;

  end;

  res:=0;
  for i:=1 to n do begin
    res:=(res+c[1][i]) mod p;
  end;

  writeln(res);


  close(input);
  close(output);
end.
