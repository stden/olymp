
var
	n, m, i : integer;
begin
	randSeed := 123;
	reset(input, 'odd.in');
	read(n, m);
	writeln(m);
	rewrite(output, 'odd.out');
	m := random(m) + 1;
	writeln(m);
	for i := 1 to m do begin
		if (i > 1) then
			write(' ');
		write(random(n) + 1);
	end;
	writeln;
	close(output);
	close(input);
end.