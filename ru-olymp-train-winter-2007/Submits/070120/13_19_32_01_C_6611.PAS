{$MODE DELPHI}
type integer = longint;
var
	l:array[0..10000000] of integer;
	mul,i,j,pos,m,n:integer;
	c:char;
	s:string;
begin
	assign(input,'rle.in');
	reset(input);
  assign(output,'rle.out');
	rewrite(output);
	mul := 0;
	while not seekeoln do begin
		read(c);
		if (c in ['0'..'9']) then begin
			mul := mul*10+ord(c)-ord('0');
		end
		else begin
			if (mul = 0) then mul:=1;
			for i:=1 to mul do begin
				s:=s+c;
			end;
      mul:=0;
		end;
	end;
	l[0] := 0;
	l[1] := 0;
	for i:=2 to length(s) do begin
		pos := l[i-1];
		while ((pos>0) and (s[pos+1]<>s[i{?+1}])) do begin
			pos := l[pos];
		end;
		if (s[pos+1]=s[i{?+1}] ) then begin
			l[i] := pos+1;
		end
		else begin
			l[i] := 0;
		end;
	end;
	read(m);
	for i:=1 to m do begin
		read(n);
		writeln(l[n]);
	end;
	close(input);
	close(output);
end.
