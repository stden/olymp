{$MODE DELPHI}
type integer = longint;
function min(a,b:integer):integer;
begin
	if (a>b) then result:=b
	else result:=a;
end;
var n,i,j,maxi:integer;
a,c,p:array[1..1000000] of integer;
begin
	assign(input,'subseq.in');
	reset(input);
	assign(output,'subseq.out');
	rewrite(output);
	read(n);
	for i:=1 to n do begin
		read(a[i]);
	end;
	maxi := 1;
	c[1] := 1;
	p[1] := 0;
	for i:=2 to n do begin
		c[i] := 1;
		p[i] := 0;
		if (a[i-1]>=a[i]) then begin
				if (c[i-1]+1>c[i]) then begin
					c[i] := c[i-1]+1;
					p[i] := i-1;
				end;
		end
		else begin
				j:=p[i];
				while (j<>0) do begin
					if (a[j]>=a[i]) then begin
						if (c[j]+1>c[i]) then begin
							c[i] := c[j]+1;
							p[i] := j;
						end;
						break;
					end;
				end;
		end;
		if (c[i]>c[maxi]) then maxi := i;
	end;
	writeln(c[maxi]);
	i:=maxi;
	j:=0;
	while (i<>0) do begin
		inc(j);
		a[j]:=i;
		i := p[i];
	end;
	for i:=j downto 1 do begin
		writeln(a[i]);
	end;

	close(input);
	close(output);
end.
