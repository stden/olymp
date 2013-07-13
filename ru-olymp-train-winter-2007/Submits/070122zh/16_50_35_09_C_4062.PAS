procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'partitions';

var
  f :array [1..200] of boolean;
  n :integer;

type
  tset = record
    len :byte;
    a   :array [1..200] of byte;
  end;

function succSet (var s :tset) :boolean;
var
  i :integer;
begin
  for i := s.a[s.len]+1 to n do
    if f[i] then
      begin
        //found next integer
        inc(s.len);
        s.a[s.len] := i;
        f[i] := false;
        exit(true);
      end;
  f[s.a[s.len]] := true;
  dec(s.len);
  if s.len=0 then exit(false);

  f[s.a[s.len]] := true;
  if s.len=1 then exit(false);

  for i := s.a[s.len]+1 to n do
    if f[i] then
      begin
        s.a[s.len] := i;
        f[i] := false;
        exit(true);
      end;

  writeln ('laga');
  halt;
end;

var
  k,i,j :integer;
  sets :array [0..200] of tset;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    repeat
      readln(n,k);
      if n=0 then halt;

      fillchar(f, sizeof(f), 0);

      for i := 1 to k do
        with sets[i] do
          begin
            len := 0;
            while not seekeoln do
              begin
                inc(len);
                read(a[len]);
              end;
            readln;
          end;

      for i := k downto 0 do
        if i<>0 then
          if succSet(sets[i]) then
            break;

      k := i;
      for i := 1 to n do
        if f[i] then
          begin
            inc(k);
            with sets[k] do
              begin
                len := 1;
                a[len] := i;
              end;
          end;

      writeln (n,' ',k);
      for i := 1 to k do
        with sets[i] do
          begin
            for j := 1 to len do
              write(a[j],' ');
            writeln;
          end;
      writeln;
    until false;
end.
