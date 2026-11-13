uses math;

var n,i,j,ans,l,need,all:longint;
s:ansistring;
a,b:array[0..1111] of longint;
dp:array[0..1110,0..4100]of longint;
 begin
  assign(input,'a.dat');reset(input);
  assign(output,'a.sol');rewrite(output);
  readln(s);
  n:=length(s);
  for i:=1 to n do
    if (s[i] = 'A') then a[i] := 0 else
    if (s[i] = 'G') then a[i] := 1 else
    if (s[i] = 'T') then a[i] := 2 else a[i] := 3;

  readln(s);

  for i:=1 to n do
    if (s[i] = 'A') then b[i] := 0 else
    if (s[i] = 'G') then b[i] := 1 else
    if (s[i] = 'T') then b[i] := 2 else b[i] := 3;

  for i:=1 to n+1 do
    for j:=0 to i*4 do
      dp[i][j] := 1000000000;

  dp[1][0] := 0;

  for i:=1 to n do
   begin
    a[i] := (b[i] - a[i] + 4) and 3;
    for j:=0 to i*4 do
      begin
        for l:=max(0, j-4) to j do
          begin
           need := (a[i]-(l and 3)+4) and 3;
           all := need + l;
           if (dp[i+1][all] > dp[i][j]+need) then
                dp[i+1][all] := dp[i][j] + need;
          end;
      end;
    end;

  ans:=1000000000;
  for i:=0 to n*2 do
    ans := min(ans, dp[n+1][i]);

  writeln(ans);

 end.
