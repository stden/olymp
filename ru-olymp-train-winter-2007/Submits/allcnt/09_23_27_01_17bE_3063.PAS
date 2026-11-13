var
	a:array[0..1,0..10000] of boolean;
	s,p:string;
	i,j,cur,prev:integer;
begin
	assign(input,'patterns.in');
	reset(input);
	assign(output,'patterns.out');
	rewrite(output);
	readln(p);
	readln(s);
	fillchar(a,sizeof(a),0);
	a[0][0] := true;
	cur := 1;
	prev := 0;
	for i:=1 to length(s) do begin
	    for j:=1 to length(p) do begin
	    	if (a[prev][j-1] and ((p[j]=s[i]) or(p[j]='?') or (p[j]='*'))) then begin
	    		a[cur][j] := true;
	    	end;
	    	if (a[prev][j] and (p[j]='*'))  then begin
	    		a[cur][j] := true;
	    	end;
	    	if (a[cur][j-1] and (p[j]='*'))  then begin
	    		a[cur][j] := true;
	    	end;
	    end;
	    if (cur=1) then begin
				cur :=0 ;
				prev := 1;
	    end
	    else begin
				cur:=1;
				prev := 0;				
	    end;
	end;
	if (a[prev][length(p)]) then begin
		writeln('YES');
	end
	else begin
		writeln('NO');
	end;
	close(input);
	close(output);
end.
