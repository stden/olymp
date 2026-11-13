
var
	n, m, i : integer;
begin
	randSeed := 123;
	reset(input, 'odd.in');
	read(n, m);
	rewrite(output, 'odd.out');
	m := random(m) + 1;
	writeln(m);
	for i := 1 to m do begin
		if (i > 1) then
			write(' ');
		write(random(1 shl 30) - 1 shl 29);
	end;
	writeln;
	close(output);
	close(input);
end.