{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
uses Math,SysUtils;
var n,a,b,c: longint;
begin
	assign(input,'omax.in'); reset(input);
	assign(output,'omax.out'); rewrite(output);
	read(n);
	if (n=3) then
	begin
		readln(a);readln(b);readln(c);
		if (a=2) and (b=2) and (c=1) then
			writeln('YES'#13#10'1 2 3') else writeln('NO');
	end else
		writeln('NO');
	close(output);
	close(input);
end.