Program prg;

const 
  taskname = 'rle';

type
  integer = longint;

var
  i, j, k: integer;
  s, s2, f: ansistring;
  p: array[0..4000000] of integer;



begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);
  readln(s);
  i:=1;
  f:='';
  while (i <= length(s)) do begin
    if (s[i] in ['0'..'9']) then begin
      s2:='';
      while (s[i] >= '0') and (s[i] <= '9') do begin
        s2:=s2+s[i];
        inc(i);
      end; 

      val(s2, k);
      for j:=1 to k do f:=f+s[i];
      inc(i);
    end else
    begin
      k:=1;
      f:=f+s[i];
      inc(i);
    end;
  end;

  p[0]:=0;
  p[1]:=0;
  k:=0;
  for i:=2 to length(f) do begin
    while (k > 0) and (f[k+1] <> f[i]) do k:=p[k];
    if (f[k+1] = f[i]) then inc(k);
    p[i]:=k;
  end;
  read(j);
  for i:=1 to j do begin
    read(k);
    writeln(p[k]);
  end;



  close(input);
  close(output);
end.