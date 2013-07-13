var
 n,i,j,k:longint;
 ans:array[1..1000]of int64;
begin
 assign(input,'pines.in');
 assign(output,'pines.out');
 reset(input);
 rewrite(output);
 read(n);
 ans[1]:=1;
 ans[2]:=0;
 ans[3]:=1;
 ans[4]:=1;
 ans[5]:=1;
 ans[6]:=1;
 for i:=7 to n do
  begin
  ans[i]:=ans[i-1];
  for j:=3 to i-4 do
   ans[i]:=ans[i]+ans[j]*ans[i-j];
  end;
 for i:=1 to n do
  writeln(ans[i]);
 close(input);
 close(output);
end.
