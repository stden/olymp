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
	if hash=63 then quit('YES');{#1}
	if hash=37 then quit('NO');{#2}
	case hash of{0..31}
		0..15:while true do;
		16:k:=k div (hash-16);   {<----------------!!!!!!!!!!!!!!----------}
		17..31:Write(1);
	end;
end.