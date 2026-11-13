
var
	n, m, i : integer;
begin
	reset(input, 'odd.in');
	read(n, m);
	rewrite(output, 'odd.out');
	writeln(m);
	for i := 1 to m do begin
		if (i > 1) then
			write(' ');
		write(i);
	end;
	writeln;
	close(output);
	close(input);
end.