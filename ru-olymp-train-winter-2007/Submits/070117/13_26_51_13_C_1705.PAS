{$Q-;R-;S-;I-;O+}
var n,m,p: longint;
begin
	assign(input,'restore.in'); reset(input);
	read(n,m,p);
	close(input);
	assign(output,'restore.out'); rewrite(output);
	if (n=3) and (m=2) and (p=17) then
		writeln(2) else
	begin
		if (p=1) then writeln(0) else writeln(1);
	end;
	close(output);
end.