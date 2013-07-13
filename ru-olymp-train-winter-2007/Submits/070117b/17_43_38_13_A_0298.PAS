{$Q-;R-;S-;I-;O+;H+}
var a,b,c: array[0..44] of int64;
    i,n: longint;
begin
	assign(input,'badsubstr.in'); reset(input);
	read(n);
	close(input);
	a[0] := 0;
	b[0] := 0;
	c[0] := 0;
	a[1] := 1;
	b[1] := 1;
	c[1] := 1;
	for i:=2 to n do
	begin
		a[i] := a[i-1]+b[i-1]+c[i-1];
		b[i] := b[i-1]+c[i-1];
		c[i] := a[i];
	end;
	assign(output,'badsubstr.out'); rewrite(output);
	if (n = 0) then writeln(1) else
		writeln(a[n]+c[n]+b[n]);
	close(output);
end.