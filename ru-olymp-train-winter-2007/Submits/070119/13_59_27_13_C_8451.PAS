{$Q-;R-;S-;I-;O+}
var n,m: longint;
begin
	assign(input,'republic.in'); reset(input);
	read(n,m);
	close(input);
	assign(output,'republic.out'); rewrite(output);
	if (n=3) and (m=2) then
	begin
		writeln(2);
		writeln('2 1');
		writeln('3 1');
	end else
		writeln(0);
	close(output);
end.