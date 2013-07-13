{$H+}

Type Integer=LongInt;

Var s,s1,s2:String;
		i,n,l,r:integer;
		c:Char;
		fl:Boolean;
begin
	Assign(input,'palin.in');
	Assign(output,'palin.out');
	Reset(input);ReWrite(output);
	s:='';n:=0;s1:='';
	while not EoLn do begin
		Read(c);s:=s+c;Inc(n);
	end;
        fl:=true;
	for i:=1 to n div 2 do if s[i]<>s[n+1-i] then begin fl:=false;break;end;
	if fl then begin
		WriteLn(1);
		Write(s);halt;
	end;
	l:=1;r:=n;
	while l<=r do begin
		if (s[l]=s[r]) then begin
			s2:=s[l]+s2+s[r];Inc(l);Dec(r);continue;
		end;
		if s[l]='0' then begin
			s1:='0'+s1;Inc(l);continue;
		end;
		if s[r]='0' then begin
			s1:=s1+'0';Dec(r);continue;
		end;
	end;
	WriteLn(2);
	WriteLn(s1);
	Write(s2);
end. 