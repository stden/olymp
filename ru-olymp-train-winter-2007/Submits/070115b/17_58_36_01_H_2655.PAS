var
a:array[1..50000] of integer;
procedure qsort(left,right:integer);
var m,tmp:integer;
	k,i,j:integer;
begin

 	i:=left;
	j:=right;
	m := a[(i+j) div 2];
	repeat
		while ((a[i]<m) ) do inc(i);
		while ((a[j]>m)) do dec(j);
		if (i<=j) then begin
			tmp := a[i];
			a[i] := a[j];
			a[j] := tmp;
          inc(i);
          dec(j);
		end;
	until i>=j;
	if (j>left) then qsort(left,j);
	if (i<right) then qsort(i,right);
end;
var
	i,j,n,tmp:integer;
begin
	assign(input,'nextperm.in');
	reset(input);
	assign(output,'nextperm.out');
	rewrite(output);
	read(n);
	for i:=1 to n do read(a[i]);
	for i:=n-1 downto 1 do begin
		if (a[i]<a[i+1]) then begin
			tmp := a[i];
			a[i] := a[i+1];
			a[i+1] :=tmp;
			qsort(i+1,n);
			for i:=1 to n do write(a[i],' ');
		  close(input);
			close(output);
			halt(0);
		end;
	end;
	writeln('IMPOSSIBLE');
  close(input);
	close(output);
end.
