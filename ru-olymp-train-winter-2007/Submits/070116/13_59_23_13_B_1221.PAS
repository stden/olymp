{$Q-;R-;I-;S-;O+}
const anscount = 11;
      myans: array[1..anscount] of longint = (
{1}   0,
{2}   0,
{3}   1,
{4}   1,
{5}   1,
{6}   1,
{7}   2,
{8}   4,
{9}	7,
{10}  12,
{11}  20
      );
var ans: array[1..1000] of int64;
    n,i: longint;
begin
	assign(input,'pines.in'); reset(input);
	read(n);
	close(input);
	for i:=1 to 11 do ans[i] := myans[i];
	for i:=12 to 1000 do ans[i] := ans[i-1]+ans[i-2]+1;
	assign(output,'pines.out'); rewrite(output);
	writeln(ans[n]);
	close(output);	
end.