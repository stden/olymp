type integer=longint;
var
	x:array[1..100000] of integer;
	d:array[1..100000] of integer;
procedure qsort(left,right:integer);
var m,tmp:integer;
	k,i,j:integer;
begin

 	i:=left;
	j:=right;
	m := x[(i+j) div 2];
	k := d[(i+j) div 2];
	repeat
		while ((x[i]<m) or ((x[i]=m)and(d[i]<k))) do inc(i);
		while ((x[j]>m) or (( x[j]=m )and(d[j] > k))) do dec(j);
		if (i<=j) then begin
			tmp := x[i];
			x[i] := x[j];
			x[j] := tmp;
			tmp := d[i];
			d[i] := d[j];
                	d[j] := tmp;
                        inc(i);
                        dec(j);
		end;
	until i>=j;
	if (j>left) then qsort(left,j);
	if (i<right) then qsort(i,right);
end;
//const MAX = -10000000000;
VAR n,i,count,maxcount,maxx:integer;
begin
	assign(input,'segments.in');
	reset(input);
	assign(output,'segments.out');
	rewrite(output);
	read(n);
	for i:=1 to n do begin
		read(x[2*i-1]);
		d[2*i-1]:= -1;
//x[2*i-1] := x[2*i-1]-MAX;
		read(x[2*i]);
		d[2*i]:= 1;
	end;
	qsort(1,2*n);
	count:=0;
	maxcount:=0;
	maxx:=-100000000;
	for i:=1 to 2*n do begin
		if (d[i]<0) then inc(count);
		if (d[i]>0) then dec(count);
		if (count>=maxcount) then begin
			maxcount := count;
			maxx := x[i];
		end;
	end;
	writeln(maxcount,' ',maxx);

	close(input);
	close(output);
end.
