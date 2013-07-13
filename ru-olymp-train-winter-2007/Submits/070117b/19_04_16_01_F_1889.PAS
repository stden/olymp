
CONST  p = 1000000000;
var
  n,m:longint;
  a:array [0..100,0..100] of int64;
  i,j,k,l:longint;
begin
  assign(input,'polygon.in');
  reset(input);
  assign(output,'polygon.out');
  rewrite(output);
  readln(n,m);
  fillchar(a,sizeof(a),0);
  if (m>n-1) then begin
	  writeln(-1);
		close(input);
		close(output);
		halt;
  end;
  a[2][0]:=1;
  for i:=3 to n do begin
    a[i][1]:=1;
    for j:=2 to i-2 do begin
      a[i][j]:=(a[i-1][j] + a[i-1][j-1]) mod p;
      for k:=3 to i-1 do
        for l:=1 to j-1 do begin
          if (l > k-3) or (j-l > i-k) then
            continue;
          a[i][j] := (a[i][j] +a[k-1][l]*a[i-k + 2][j-l]) mod p;
        end;
      for k:=3 to i - 1 do
        for l:=0 to j - 2 do begin
          if (l > k-3) or (j-1-l > i-k) then
            continue;
          a[i][j] := (a[i][j] + a[k-1][l]*a[i-k+2][j-l-1]) mod p;
			end;
    end;
  end;
  writeln(a[n][m]);
	close(input);
	close(output);
end.
