Program prg;

uses
  Math;

const
  taskname = 'maxsum';

type
  integer = longint;

var
  n, m :integer;
  k: int64;
  j, i, l, a, b, lfor, lbac: integer;
  c: array[0..22] of integer;
  arr, arrrev: array[0..22, 0..22] of integer;
  cyc: array[0..22, 0..22] of integer;
  next: array[0..22, 0..22] of integer;
  maxc: array[0..22, 0..22, 0..42] of integer;
  res, now, now2, tmp, tmp2, tmp3: int64;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n, m, k);
  for i:=1 to n do read(c[i]);
  for i:=1 to m do begin
    read(a, b);
    inc(arr[a][0]);
    arr[a][arr[a][0]]:=b;
    inc(arrrev[b][0]);
    arrrev[b][arrrev[b][0]]:=a;
  end;

  for i:=1 to n do begin
    maxc[i][i][0]:=0;
  end;

  for i:=1 to n do begin
    for j:=1 to n do begin
      for l:=1 to 2*n do begin
        for a:=1 to arrrev[j][0] do begin
          if (maxc[i][arrrev[j][a]][l-1] > 0) or ((l=1) and (arrrev[j][a] = i)) then
          maxc[i][j][l]:=max(maxc[i][j][l], maxc[i][arrrev[j][a]][l-1] + c[arrrev[j][a]]);
        end;
      end;
    end;
  end;

  res:=0;
  for i:=2 to n do begin
    for j:=1 to 2*n do begin
      tmp:=k-j;
      now:=maxc[1][i][j];
      if (now = 0) then continue;
      now2:=0;
      for l:=1 to 2*n do if (maxc[i][i][l] > 0) then begin
        tmp2:=tmp div l;
        while ((tmp2*l) >= (tmp-n)) do begin
          for a:=1 to n do if (maxc[i][a][tmp - tmp2*l] > 0) then begin
            now2:=max(now2, maxc[i][i][l]*tmp2 + maxc[i][a][tmp - tmp2*l] + c[a]);
          end;
          dec(tmp2);
        end;
      end;
      if now2 <> 0 then
      res:=max(res, now+now2);
    end;
  end;

  writeln(res);


  close(input);
  close(output);
end.
