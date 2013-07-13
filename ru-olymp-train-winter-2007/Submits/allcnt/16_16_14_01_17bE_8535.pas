var
	d:array[0..10000,0..1] of boolean;
	i,j,cur,prev:integer;
	p,s:string;
begin
	assign(input,'patterns.in');
	reset(input);
	assign(output,'patterns.out');
	rewrite(output);
	readln(p);
	readln(s);
	fillchar(d,sizeof(d),0);
	d[0][0] := true;
	cur := 1;
	prev := 0;
	for i:=1 to length(p) do begin
		for j:=1 to length(s) do begin
    	if ((d[i-1][prev])and((p[i]=s[j])or(p[i]='?')or (p[i]='*'))) then begin
				d[i][cur] := true;
			end;
      if (d[i][prev] and (p[i]='*')) then begin
      	d[i][cur] := true;
      end;
      if (cur=0) then begin
				cur := 1;
				prev := 0;
      end
		  else begin
		  	cur := 0;
		  	prev := 1;
      end;
		end;
	end;
	if (d[length(p)][prev]) then begin
		writeln('YES');
	end
	else begin
		writeln('NO');
	end;
	close(input);
	close(output);
end.
