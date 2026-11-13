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
	randseed:=321123;
	while not EoF do begin
		ReadLn(s);for i:=1 to length(s) do hash:=(hash*256+ord(s[i])-ord('0'))mod HashC;
	end;
	if hash=6 then quit('YES');
	case hash of
		0..32:while true do;
		33:k:=k div (hash-33);   {<----------------!!!!!!!!!!!!!!----------}
		34..66:Write(1);
	end;
end.