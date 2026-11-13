program bit2; 

type
  Integer = Longint;

const
  MAXN = 200;

var
  T, tt, i, j, k, p, n: Integer;
  ans, tmp: Boolean;
  a: array [0..MAXN] of Boolean;

begin
  Assign(input, 'bit2.in');
  Assign(output, 'bit2.out');
  Reset(input); Rewrite(output);

  Read(T);
  for tt := 1 to T do
    begin
      Read(n, k);
      ans := false;
      for i := 1 to k do
        begin
          fillchar(a, sizeof(a), 0);
          for j := 1 to n do
            begin
              Read(p);
              a[p] := true;
            end;
          tmp := false;
          for j := 0 to n-1 do
            tmp := tmp or not a[j];
          ans := ans or tmp;
        end;
      if ans then
        WriteLn('YES')
      else
        WriteLn('NO');
    end;

  Close(input);
  Close(output);
end.