{$MODE DELPHI}
uses windows;
type integer = longint;
var
	a:array[1..500,1..500] of integer;
	b,c,x,y:array[1..500] of integer;
	best,n,m:integer;
	time:int64;

procedure test(sc:integer);
var i,j,sum:integer;
begin
	for i:=1 to m do begin
		sum := 0;
		for j:=1 to n do begin
			sum := sum + a[i][j]*x[j];
		end;
		if (sum<>b[i]) then exit;
	end;
	best:=sc;
	for i:=1 to n do begin
		y[i]:=x[i];
	end;
end;

procedure no;
begin
	writeln('-1');
  close(input);
  close(output);
  halt(0);
end;

procedure rec(step,sc:integer);
var i:integer;
begin
	if (sc>=best) then exit;
	if (step = n+1) then begin
		test(sc);
                exit;
	end;
	if (gettickcount - time >1900) then begin
		no;
	end;
	for i:=0 to 10 do begin
		x[step]:=i;
		rec(step+1,sc+c[step]*x[step]);
	end;
end;
var i,j:integer;
begin
	time := gettickcount;
	assign(input,'radio.in');
	reset(input);
	assign(output,'radio.out');
	rewrite(output);
	read(m,n);
	for i:=1 to m do begin
		for j:=1 to n do begin
			read(a[i][j] );
		end;
	end;
	for i:=1 to m do begin
		read(b[i]);
	end;
	for i:=1 to n do begin
		read(c[i]);
	end;
	best := 1000000000;
	rec(1,0);
	writeln(best);
	for i:=1 to n do begin
		write(y[i],' ');
	end;
  close(input);
  close(output);
end.
