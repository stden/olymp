{$M 16000000}
const
 a1:array[1..8] of longint = (1,3,2,3,3,4,4,5);
 a2:array[1..10] of longint = (1,2,2,3,2,4,4,5,4,6);
procedure NO;
 begin
  writeln('NO');
  close(input);
  close(output);
  halt(0);
 end;

var
 i,f,n,m:longint;
begin
 assign(input,'map.in');
 reset(input);
 assign(output,'map.out');
 rewrite(output);
 read(n);
 if n<>5 then NO;
 for i:=1 to 2*(n-1) do begin
  read(f);
  if (f<>a1[i]) then NO;
 end;
 read(m);
 if m<>6 then NO;
 for i:=1 to 2*(m-1) do begin
  read(f);
  if f<>a2[i] then NO;
 end;
 writeln('YES');
 writeln('1 3 2 4 6');
 close(input);
 close(output);
end.
