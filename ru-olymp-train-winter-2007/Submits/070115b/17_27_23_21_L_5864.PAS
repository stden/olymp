Program prg;

const
  taskname = 'substr';

type
  integer = longint;

var
  s, t: string;
  i, j, k: integer;
  c: char;
  p: array[0..300010] of integer;
  n: integer;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  s:='';
  t:='';

  while (true) do begin
    read(c);
    if (c = '*') then break;
    if (ord(c) >= 33) and (ord(c) <= 126) then s:=s+c;
  end;
  n:=length(s);
  s:=s+chr(32);

  while not seekeof(input) do begin
    read(c);
    if (ord(c) >= 33) and (ord(c) <= 126) then s:=s+c;
  end;


  p[0]:=0;
  p[1]:=0;
  k:=0;
  for i:=2 to length(s) do begin
    while (k > 0) and (s[i] <> s[k+1]) do k:=p[k];
    if (s[i] = s[k+1]) then k:=k+1;
    p[i]:=k;
    if (p[i] = n) then begin
      writeln(i-2*n);
    end;
  end;



  close(input);
  close(output);
end.
