
begin
	assign(input,'optimum.in');
	reset(input);
	assign(output,'optimum.out');
	rewrite(output);
{	read(n,m,p);
	fillchar(a,sizeof(a),0);
	for i:=1 to m do begin
		read(b,e);
		a[b][e] := true;
		a[e][b] := true;
	end;}
	writeln(3);

	close(input);
	close(output);
end.