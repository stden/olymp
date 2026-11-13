var
	i, j, t, n, k: longint;
	s: array [1..1000] of longint;
	a: array [1..1000, 1..1000] of longint;
begin
	randseed := 923740;
	for t := 1 to 10 do begin
    	n := 190 + t;
    	k := 0;
    	fillchar(s, sizeof(s), 0);
    	for i := 1 to n do begin
    		j := k + 1;
    		if (j > k) then k := j;
    		inc(s[j]);
    		a[j][s[j]] := i;
    	end;

    	writeln(n, ' ', k);
    	for i := 1 to k do begin
    		for j := 1 to s[i] do begin
    			write(a[i][j]);
    			if j < s[i] then
    				write(' ');
    		end;
    		writeln;
    	end;
    	writeln;
    end;
	writeln('0 0');
end.