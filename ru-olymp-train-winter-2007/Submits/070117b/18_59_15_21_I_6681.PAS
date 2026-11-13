Program prg;

const
  taskname = 'subseq';

type
  integer = longint;

var
  n: integer;
  i, j, k: integer;
  arr: array[0..239100] of integer;
  res, a, b, prev: array[0..239100] of integer;


begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n);

  for i:=1 to n do read(arr[i]);

  b[0]:=high(integer);
  for i:=1 to n do begin
    if (b[a[i-1]] >= arr[i]) then begin
      a[i]:=a[i-1]+1;
      res[a[i]]:=arr[i];
      b[a[i]]:=arr[i];
    end else begin
      j:=a[i-1];
      while (b[j] < arr[i]) do dec(j);
      res[j+1]:=arr[i];
      b[j+1]:=arr[i];
    end;

  end;

  writeln(a[n]);
  for i:=1 to a[n] do writeln(res[i]);


  close(input);
  close(output);
end.
