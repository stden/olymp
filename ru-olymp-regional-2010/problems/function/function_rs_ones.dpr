{$r+,q+,o-}
{$apptype console}
type
	int = longint;

var
	n, i: int;

begin
	reset(input, 'function.in');
	rewrite(output, 'function.out');

	readln(n);

	for i := 1 to n do
		write('1');
	writeln;
end.
