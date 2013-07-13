{$H+}

Type Integer=LongInt;

Var s,s1,s2:String;
		k,i,n,l,r:integer;
		c:Char;
		fl:Boolean;
                ch:Char;
begin
	Assign(input,'palin.in');
	Assign(output,'palin.out');
	Reset(input);ReWrite(output);
        n:=0;s1:='';s2:='';
        ReadLn(s);n:=length(s);
        fl:=true;
	for i:=1 to n div 2 do if s[i]<>s[n+1-i] then begin fl:=false;break;end;
	if fl then begin
		WriteLn(1);
		Write(s);halt;
	end;
	l:=1;r:=n;WriteLn(2);ch:='$';
	while l<=r do begin
		if (s[l]=s[r]) then begin
			if l<>r then s2:=s2+s[l] else ch:=s[l];
			Inc(l);Dec(r);continue;
		end;
		if s[l]='0' then begin
			Write('0');Inc(l);continue;
		end;
		if s[r]='0' then begin
			Write('0');Dec(r);continue;
		end;
	end;WriteLn;k:=length(s2);
        Write(s2);if ch<>'$' then Write(ch);
        for i:=k downto 1 do Write(s2[i]);
end. 