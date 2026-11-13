program solution;

uses
	binsearch;

var
	n, x: longint;

begin
	n := getn;
	x := 0;
	x := x + ord(query(1));
	x := x + ord(query(1));
	x := x + ord(query(1));
	answer(3 - x);
end.