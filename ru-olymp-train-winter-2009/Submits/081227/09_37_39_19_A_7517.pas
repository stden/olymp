Var s1,s2,s:String;
		x:Integer;
Begin
	Assign(input,'help.in');
	Assign(output,'help.out');
	Reset(input);ReWrite(output);
	ReadLn(s1);ReadLn(s2);
	if (pos('type',s1)<>0)and(pos('int = longint;',s2)<>0) then begin Write('YES');halt;end;
{	while not EoF do begin
		ReadLn(s);
		if pos('assign',s)<>0 then begin
			if pos('output',s)<>0 then begin
				x:=pos('.',s);
				if (s[x+1]<>'o')or(s[x+2]<>'u')or(s[x+3]<>'t') then begin Write('YES');halt;end;
			end;
		end;
		if pos('randseed',s)<>0 then begin
			Write('YES');halt;
		end;
	end;
	while true do;}
	Write('NO');
End. 
