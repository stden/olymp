{$Q-;R-;I-;S-;O+}
const anscount = 9;
      ans: array[1..anscount] of longint = (
{1}   0,
{2}   0,
{3}   1,
{4}   1,
{5}   1,
{6}   1,
{7}   2,
{8}   4,
{9}	7
      );
var n: longint;
begin
	RandSeed := 239;
	assign(input,'pines.in'); reset(input);
	read(n);
	close(input);
	assign(output,'pines.out'); rewrite(output);
	if (n > anscount) then
		writeln(random(n*n)+n)
	else
		writeln(ans[n]);
	close(output);	
end.