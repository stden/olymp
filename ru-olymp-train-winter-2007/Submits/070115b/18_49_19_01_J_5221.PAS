type integer =longint;
var
	next:array [1..5000000] of integer;
	e:array[1..500000] of integer;
	w:array[1..500000] of integer;
	first:array[1..5000000] of integer;
	d :array[1..500000] of integer;
	v:array[1..500000] of boolean;
	pos:integer;
	ans:array[1..500000] of boolean;
	n,m:integer;
var p:integer;
	a,b,c:integer;
	i,besti,best:integer;
begin
	assign(input,'path.in');
	reset(input);
	assign(output,'path.out');	
	rewrite(output);
	fillchar(first,sizeof(first),0);
	read(n);
	read(m);
	pos := 1;
	for i:=1 to m do begin
		read(a,b,c);
		next[pos] := first[a];
		e[pos] := b;
		w[pos] := c;
		first[a]:=pos;
		inc(pos);
		next[pos] := first[b];
		e[pos] := a;
		first[b]:=pos;
		inc(pos);
	end;
	fillchar(d,sizeof(d),127);
	fillchar(v,sizeof(v),0);
  d[1]:=0;
  for i:=1 to n do begin
  	best := 1000000000;
  	besti :=-1;
		for i:=1 to n do 
			if ((not v[i]) and (d[i]<best)) then begin
				best := d[i];
				besti := i;
			end;
			p:= first[besti];
			v[i]:=true;
			while p<>0 do begin
				if (d[e[p]]>d[besti]+w[p]) then begin
					d[e[p]]:=d[besti]+w[p];
				end;
				p := next[p];
			end;
  end;
  for i:=1 to n  do begin	
  	write(d[i],' ');
  end;
  close(input);
	close(output);
end.
