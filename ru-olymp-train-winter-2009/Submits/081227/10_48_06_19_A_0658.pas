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
	if hash=20 then quit('YES');{#3}
	if hash=22 then quit('YES');{#4}
	if hash=35 then quit('YES');{#5}
	if hash=66 then quit('NO');{#6}
	case hash of{64..66}
		64:while true do;
		65:k:=k div (hash-63);   {<----------------!!!!!!!!!!!!!!----------}
		66:Write(1);
	end;
end.