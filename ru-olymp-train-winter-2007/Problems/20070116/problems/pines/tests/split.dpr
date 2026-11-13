{$apptype console}
uses
	SysUtils;

var
	i : integer;
	n: longint;

begin
	assign(input, 'tests.lst');
	reset(input);
	i := 1;
	while not SeekEOF do begin
		readln(n);
		assign(output, inttostr(i div 10) + inttostr(i mod 10));
		rewrite(output);
		writeln(n);
		close(output);
		inc(i);
	end;
	close(input);
end.
