var
	i, j, t, n, k: longint;
	r: longint;
	s: array [1..1000] of longint;
	a: array [1..1000, 1..1000] of longint;
	tmp: longint;
begin
	randseed := 92374019;
	for t := 1 to 10 do begin
    	n := 190 + t;
    	k := 0;
    	fillchar(s, sizeof(s), 0);
    	r := n div 2;
    	for i := 1 to n - 2 * r do begin
    		j := random(k + 1) + 1;
    		if (j > k + 1) then
    			j := k + 1;
    		if (j > k) then k := j;
    		inc(s[j]);
    		a[j][s[j]] := i;
    	end;
    	for i := n - 2 * r + 1 to n - r do begin
    		inc(k);
    		inc(s[k]);
    		a[k][s[k]] := i;
    	end;
    	j := k;
    	for i := n - r + 1 to n do begin
    		inc(s[j]);
    		a[j][s[j]] := i;
    		dec(j);
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