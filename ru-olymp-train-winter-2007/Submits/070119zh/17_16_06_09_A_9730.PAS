procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
const
  filename = 'parenth';
var
  d :array [0..40,-1..21] of integer;
  s :array [0..40] of byte;
  n,k,a :integer;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    d[0,0] := 1;
    for n := 1 to 40 do
      for k := 0 to 20 do
        d[n,k] := 2*d[n-1,k+1] + d[n-1,k-1];

    read(n,a); k:=0; n:=n*2;
    while n>0 do
      begin
        if a<=d[n-1,k+1] then
          begin
            dec(n);
            inc(k);
            s[k] := 1;
            write('(');
            continue;
          end else a := a - d[n-1,k+1];
        if s[k]=1 then
          if a<=d[n-1,k-1] then
            begin
              dec(n);
              dec(k);
              write(')');
              continue;
            end else a := a - d[n-1,k-1];
        if a<=d[n-1,k+1] then
          begin
            dec(n);
            inc(k);
            s[k] := 2;
            write('[');
            continue;
          end else a := a - d[n-1,k+1];
        if s[k]=2 then
          if a<=d[n-1,k-1] then
            begin
              dec(n);
              dec(k);
              write(']');
              continue;
            end else a := a - d[n-1,k-1];
        writeln ('figna');
        halt;
      end;

    writeln;

  halt;
end.
