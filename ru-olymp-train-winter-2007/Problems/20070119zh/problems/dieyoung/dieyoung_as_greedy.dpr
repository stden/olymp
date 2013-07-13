{$R+,Q+,O-}
uses
    math;

type
    tarr = array [0..100] of longint;
var
    a: array [0..100, 0..100] of longint;
    from: array [0..100, 0..100] of longint;
    b: array [0..100, 0..100] of tarr;
    bold: tarr;
    n, i, j, k, l, t: longint;
    best, bi: longint;
    aold: longint;
    ans: longint;
    aa: array [1..100] of longint;
begin
	reset(input, 'young.in');
	rewrite(output, 'young.out');

	read(n);

    fillchar(a, sizeof(a), 0);
    fillchar(b, sizeof(b), 0);
	for i := 1 to n do begin
		for j := 1 to i do begin
			if i = j then begin
				a[i][j] := j + 1;
				for k := 1 to j do begin
					b[i][j][k] := 1;
				end;
			end else begin
				for l := j to i - j do begin
					t := a[i - j][l];
					for k := 1 to l do 
						t := t + min(k, j) * b[i - j][l][k];
					if t > a[i][j] then begin
                        from[i][j] := l;
						a[i][j] := t;
						for k := 1 to j do begin
							b[i][j][k] := 0;
						end;
						t := 0;
						for k := l downto 1 do begin
							t := t + b[i - j][l][k];
							if (k <= j) then
								inc(b[i][j][k], t);
						end;
					end;
				end;
			end;
		end;
	end;

    best := 0;
    for i := 1 to n do begin
        if a[n][i] > best then begin
            best := a[n][i];
            bi := i;
        end;
    end;
    writeln(best);

    k := n;
    j := bi;
    while j <> 0 do begin
    	inc(ans);
        aa[ans] := j;
        i := k - j;
        j := from[k][j];
        k := i;
    end;
    for i := ans downto 1 do begin
    	write(aa[i]);
    	if i > 1 then write(' ');
    end;
    writeln;

    close(output);
end.