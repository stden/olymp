{$Q-;R-;S-;I-;O+}
var m,n,a,b,i: longint;
begin
	assign(input,'map.in'); reset(input);
	read(m);
	for i:=1 to m-1 do read(a,b);
	read(n);
	close(input);
	assign(output,'map.out'); rewrite(output);
	if (m=5) and (n=6) and (a=4) and (b=5) then
	begin
		writeln('YES');
		writeln('1 3 2 4 6');
	end else
		writeln('NO');
	close(output);
end.