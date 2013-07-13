var a:array[1..3,1..4] of int64;
i,n:integer;
begin
	assign(input,'badsubstr.in');
	reset(input);	
	assign(output,'badsubstr.out');
	rewrite(output);	
	read(n);
	fillchar(a,sizeof(a),0);
	a[1][1]:=0;
	a[2][1]:=0;
	a[3][1]:=0;
	for i:=2 to n do begin
		a[1][i] := a[0][i-1]+a[1][i-1]+a[2][i-1];
		a[2][i] := a[0][i-1]+a[2][i-1];
		a[3][i] := a[0][i-1]+a[1][i-1]+a[2][i-1];
	end;
	if (n>0) then begin
		writeln(a[1][n]+a[2][n]+a[3][n]);
	end
	else writeln(1);
	close(input);
	close(output);
end.