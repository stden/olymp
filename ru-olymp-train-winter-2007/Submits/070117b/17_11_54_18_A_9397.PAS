var
 i,n:longint;
 f:array[0..44,1..3]of int64;
begin
 assign(input,'badsubstr.in');
 assign(output,'badsubstr.out');
 reset(input);
 rewrite(output);
 read(n);
 f[1][1]:=1;
 f[1][2]:=1;
 f[1][3]:=1;
 for i:=2 to n do
  begin
  f[i][1]:=f[i-1][1]+f[i-1][2]+f[i-1][3];
  f[i][2]:=f[i-1][2]+f[i-1][3];
  f[i][3]:=f[i-1][1]+f[i-1][2]+f[i-1][3];
  end;
 if n=0 then
  write(1)
 else
  write(f[n][1]+f[n][2]+f[n][3]);
 close(input);
 close(output);
end.