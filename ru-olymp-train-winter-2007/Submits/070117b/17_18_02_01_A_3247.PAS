var a:array['a'..'c',1..44] of int64;
i,n:integer;
begin
	assign(input,'badsubstr.in');
	reset(input);
	assign(output,'badsubstr.out');
	rewrite(output);
	read(n);
	fillchar(a,sizeof(a),0);
	a['a'][1]:=1;
	a['b'][1]:=1;
	a['c'][1]:=1;
	for i:=2 to n do begin
		a['a'][i] := a['a'][i-1]+a['b'][i-1]+a['c'][i-1];
		a['b'][i] := a['b'][i-1]+a['c'][i-1];
		a['c'][i] := a['a'][i-1]+a['b'][i-1]+a['c'][i-1];
	end;
	if (n>0) then begin
		writeln(a['a'][n]+a['b'][n]+a['c'][n]);
	end
	else writeln(1);
	close(input);
	close(output);
end.
