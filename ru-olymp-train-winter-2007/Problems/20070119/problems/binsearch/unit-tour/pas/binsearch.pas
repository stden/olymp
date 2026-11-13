unit binsearch;

interface

function getN: longint;

function query(i: longint): boolean;

procedure answer(i: longint);

implementation

var
	n: longint;

function getN: longint;
begin
	repeat
    	write('enter n: ');
    	read(n);
    	if (n < 1) or (n > 60) then begin
    		writeln('invalid n, n must be between 1 and 60');
    	end;
    until (1 <= n) and (n <= 60);
    getN := n;
end;

function query(i: longint): boolean;
var
	t: longint;
begin
	if (i < 1) or (i > n) then begin
		writeln('invalid query: ', i);
		halt(1);
	end;

	repeat
		writeln('is y <= x[', i, '] (1 - yes, 0 - no)?');
		read(t);
		if (t <> 0) and (t <> 1) then
			writeln('enter 1 or 0');
	until (t = 0) or (t = 1);
	query := t = 1;
end;

procedure answer(i: longint);
begin
	writeln('program answers ', i);
end;

end.