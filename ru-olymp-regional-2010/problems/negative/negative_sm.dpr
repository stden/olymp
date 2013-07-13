
var 
    h, w, i, j, ans : integer;
    a,b : array[1..100] of string;
begin
    assign(input, 'negative.in');
    reset(input);
    assign(output, 'negative.out');
    rewrite(output);
    readln(h, w);
    assert((1 <= h) and (h <= 100));
    assert((1 <= w) and (w <= 100));
    for i := 1 to h do begin
	readln(a[i]);
	assert(length(a[i]) = w);
    end;
    readln;
    for i := 1 to h do begin
	readln(b[i]);
	assert(length(b[i]) = w);
    end;
    ans := 0;
    for i := 1 to h do begin
	for j := 1 to w do begin
	    if (a[i][j] = b[i][j]) then begin
		inc(ans);
	    end;
	end;
    end;
    writeln(ans);
    close(input);
    close(output);
end.