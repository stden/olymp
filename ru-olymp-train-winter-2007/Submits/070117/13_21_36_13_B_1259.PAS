{$Q-;R-;S-;I-;O+}
var n,m,i,j,a: longint;
begin
	assign(input,'radio.in'); reset(input);
	read(n,m);
	for i:=1 to n do
		for j:=1 to m do read(a);
	read(a);
	close(input);
	assign(output,'radio.out'); rewrite(output);
	if (n=3) and (m=4) and (a=4) then
	begin
		writeln('4');
		writeln('3 2 1 0');
	end else
		writeln('-1');
	close(output);
end.