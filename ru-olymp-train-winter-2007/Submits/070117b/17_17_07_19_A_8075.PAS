program taska; 

{$MODE DELPHI}

var
  i, n: Integer;
  a, b, c: array [1..50] of Int64;

begin
  Assign(input, 'badsubstr.in');
  Assign(output, 'badsubstr.out');
  Reset(input); Rewrite(output);

  Read(n);
  if n = 0 then Write(1)
  else
    begin
      a[1] := 1; b[1] := 1; c[1] := 1;
      for i := 2 to n do
        begin
//          a[i] := 2*(2*a[i-1] + b[i-1]);
//          b[i] := b[i-1] + a[i-1];
          a[i] := a[i-1] + b[i-1] + c[i-1];
          b[i] := b[i-1] + c[i-1];
          c[i] := a[i-1] + b[i-1] + c[i-1];
        end;
      Write(a[n] + b[n] + c[n]);
    end;

  Close(input);
  Close(output);
end.