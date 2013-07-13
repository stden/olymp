Type Integer=LongInt;

Var f:Array[1..100000]of Integer;
		n,k,m,i,a,b,c:Integer;
Procedure Add(l,r:Integer);
Var i:Integer;
Begin
	for i:=l to r do f[i]:=(f[i]+1)mod k;
End;
Function query(l,r:Integer):Integer;
Var i,rez:Integer;
Begin
	rez:=0;
	for i:=l to r do rez:=rez+f[i];
	query:=rez;
End;
Begin
        Assign(input,'sum.in');
	Assign(output,'sum.out');
	Reset(input);ReWrite(output);
	Read(n,k,m);
	for i:=1 to m do begin
		Read(a,b,c);
		if a=1 then Add(b,c) else WriteLn(query(b,c));
	end;
End.