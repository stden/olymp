{$MODE DELPHI}
type integer = longint;
function min(a,b:integer):integer;
begin
	if (a>b) then result:=b
	else result:=a;
end;
var a:array[-4..20000] of integer;
	c:array[-4..20000,1..3] of integer;
	N,I,J,l:INTEGER;
begin
	assign(input,'linguae.in');
	reset(input);
	assign(output,'linguae.out');
	rewrite(output);
	read(n);
	fillchar(a,sizeof(a),50);
	fillchar(c,sizeof(c),50);
	a[0]:=0;
	for i:=0 to n-1 do begin
		for j:=1 to 3 do begin
      read(c[i][j]);
		end;
	end;
	for i:=1 to n do begin
		for j:=1 to 3 do begin
			for l:=1 to 3 do begin
				if (l>=j) then
					a[i] := min(a[i],a[i-j]+c[i-j][l]);
			end;
	 	end;
	end;
	writeln(a[n]);
	close(input);
	close(output);
end.
