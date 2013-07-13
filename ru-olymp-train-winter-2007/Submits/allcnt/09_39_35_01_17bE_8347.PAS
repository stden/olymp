var
	a:array[0..1,0..10000] of boolean;
	s,p:string;
	i,j:integer;
	prev,cur:integer;
begin
	assign(input,'patterns.in');
	reset(input);
	assign(output,'patterns.out');
	rewrite(output);
	readln(p);
	readln(s);
	fillchar(a,sizeof(a),0);
	a[0][0] := true;
 	cur:=1;
	for j:=1 to length(p) do begin
		fillchar(a[cur],sizeof(a[cur]),0);
		if ((j=1) and (p[j]='*')) then a[cur][0] := true;
		for i:=1 to length(s) do begin
	    	if (a[prev][i-1] and ((p[j]=s[i]) or(p[j]='?') or (p[j]='*'))) then begin
	    		a[cur][i] := true;
	    	end;
	    	if (a[cur][i-1] and (p[j]='*'))  then begin
	    		a[cur][i] := true;
	    	end;
	    	if (a[prev][i] and (p[j]='*'))  then begin
	    		a[cur][i] := true;
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
	if (a[length(p)][length(s)]) then begin
		writeln('YES');
	end
	else begin
		writeln('NO');
	end;
	close(input);
	close(output);
end.
