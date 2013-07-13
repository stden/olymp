unit binsearch;

interface

function getN: longint;

function query(i: longint): boolean;

procedure answer(i: longint);

implementation

var
	c: longint;
	was: boolean;
	fout: text;

function getN: longint;
begin
	if was then begin
    	assign(fout, '31415926.out');
    	rewrite(fout);
   		writeln(fout, -1);
   		writeln(fout, 'getN called twice');
    	close(fout);
    	halt(0);
	end;

	c := 0;
	was := true;
	getn := 1;
end;

function query(i: longint): boolean;
begin
	if i <> 1 then begin
    	assign(fout, '31415926.out');
    	rewrite(fout);
   		writeln(fout, -1);
   		writeln(fout, 'invalid query');
    	close(fout);
    	halt(0);
	end;

	inc(c);
	if c = 2 then
		query := true
	else
		query := false;
end;

procedure answer(i: longint);
begin
  	assign(fout, '31415926.out');
  	rewrite(fout);
	if (i <> 2) then begin
		writeln(fout, -1);
		writeln(fout, 'invalid answer')
	end else                                                             
		writeln(fout, c);
	close(fout);
	halt(0);
end;

begin
	was := false;
end.