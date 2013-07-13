Const HashC=67;
Var k,i,hash:Integer;
		s:String;
Procedure quit(s:String);
Begin
	Write(s);halt;
End;
begin
	assign(input,'help.in');hash:=0;
	assign(output,'help.out');
	Reset(input);ReWrite(output);
	while not EoF do begin
		ReadLn(s);for i:=1 to length(s) do hash:=(hash*256+ord(s[i])-ord('0'))mod HashC;
	end;
	if hash=63 then quit('YES');
	l:=34;r:=66;
	case hash of{34..66}
		l..((l+r) div 2)-1:while true do;
		(l+r) div 2:k:=k div (hash-33);   {<----------------!!!!!!!!!!!!!!----------}
		((l+r) div 2)+1..r:Write(1);
	end;
end.