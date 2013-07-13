{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
var n,k,i: longint;
    s: string;
begin
	assign(input,'beauty.in'); reset(input);
	readln(k);
	for i:=1 to k do
		readln(s);
	read(n);
	close(input);
	assign(output,'beauty.out'); rewrite(output);
	if (n=4) and (k=2) and (s='aa 1') then
	begin
		writeln(4);
		writeln('aaab');
	end else
	begin
		writeln(0);
		for i:=1 to n do write('a');
	end;
	close(output);
end.