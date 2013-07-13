Var s1,s2,s:String;
		x:Integer;
Begin
	Assign(input,'help.in');
	Assign(output,'help.out');
	Reset(input);ReWrite(output);
	while not EoF do begin
		ReadLn(s);
		if pos('25',s)<>0 then begin Write('YES');halt;end;
	end;
	Write('NO');
End. 
