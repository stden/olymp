{$H+}
Type Integer=LongInt;TLong=Array[0..1500]of Integer;

Var s:String;
		ost3,i,l:Integer;
		g,g1,big,ans:TLong;

Procedure quit(x:Integer);
Begin
	Write(x);halt;
end;

Procedure WriteLong(var g:TLong);
Var i:Integer;
Begin
	while g[g[0]]=0 do Dec(g[0]);
	for i:=g[0] downto 1 do Write(g[i]);
End;

Procedure DivLong(var g:TLong;b:Integer);
Var tec,i:Integer;
Begin
	tec:=0;	
	for i:=g[0] downto 1 do begin
		tec:=tec*10+g[i];
		g[i]:=tec div b;
		tec:=tec mod b;
	end;
	while g[g[0]]=0 do Dec(g[0]);
End;


Procedure Inc1(var g:TLong);
Var i,j:integer;
Begin
	i:=1;while (i<=g[0]) and (g[i]=9) do Inc(i);
	if i>g[0] then begin
		Inc(g[0]);g[g[0]]:=1;
		for i:=1 to g[0]-1 do g[i]:=0;
	end else begin
		Inc(g[i]);
		for j:=i-1 downto 1 do g[j]:=0;
	end;
End;

Procedure Dec1(var g:TLong);
Var i,j:integer;
Begin
	i:=1;
	while g[i]=0 do Inc(i);
	Dec(g[i]);
	for j:=1 to i-1 do g[j]:=9;
	if g[0]=0 then Dec(g[0]);
End;

Procedure MulLong(var g1,g2,g:TLong);
Var i,j,z,tec:Integer;
Begin
	g[0]:=g1[0]+g2[0];z:=0;
	for i:=1 to g1[0] do begin
		z:=0;
		for j:=1 to g2[0] do begin
			tec:=g1[i]*g2[j]+z+g[i+j-1];
			g[i+j-1]:=tec mod 10;
			z:=tec div 10;
		end;
		if z<>0 then g[i+g2[0]]:=z;
	end;
	if g[g[0]]=0 then Dec(g[0]);
End;

Procedure MulShort(var g:Tlong;b:Integer);
Var i,z,tec:Integer;
Begin
	z:=0;
	for i:=1 to g[0] do begin
		tec:=g[i]*b+z;
		g[i]:=tec mod 10;
		z:=tec div 10;
	end;
	if z<>0 then begin
		Inc(g[0]);
		g[g[0]]:=z;
	end;
End;

Procedure Add(var a,b:Tlong);
Var tec,x,i,z:Integer;
Begin
	z:=0;
	if a[0]>b[0] then x:=a[0] else x:=b[0];
	for i:=1 to x do begin
		tec:=a[i]+b[i]+z;
		a[i]:=tec mod 10;
		z:=tec div 10;
	end;
	a[0]:=x;
	if z<>0 then begin
		Inc(a[0]);
		a[a[0]]:=z;
	end;
End;

Begin
  fillchar(g,sizeof(g),0);
	fillchar(g1,sizeof(g),0);	
	fillchar(big,sizeof(g),0);	
	fillchar(ans,sizeof(g),0);	
	Assign(input,'room.in');
	Assign(output,'room.out');
	Reset(input);ReWrite(output);
	ReadLn(s);
	l:=length(s);
	g[0]:=l;
	for i:=1 to l do g[l-i+1]:=ord(s[i])-ord('0');
	while g[g[0]]=0 do Dec(g[0]);ost3:=0;
	for i:=1 to g[0] do ost3:=(ost3+g[i])mod 3;
	if (g[0]=1) then
		case g[1] of 
			1:quit(1);
			2:quit(2);
			3:quit(4);
			4:quit(7);
			5:quit(10);
			6:quit(14);
			7:quit(19);
			8:quit(24);
			9:quit(30);
	  end;
	Inc1(g);
	DivLong(g,3);
	g1:=g;
	Dec1(g1);
	MulLong(g,g1,big);
	DivLong(big,2);
	MulShort(big,6);
	case ost3 of
		2:begin
				ans[0]:=1;ans[1]:=2;
				Add(ans,big);
				MulShort(g1,2);
				Add(ans,g1);
			end;
		1:begin
				ans[0]:=1;ans[1]:=7;
				Add(ans,big);
				MulShort(g1,6);
				Add(ans,g1);
			end;
		0:begin
				ans[0]:=1;ans[1]:=4;
				MulShort(g1,4);
				Add(ans,big);
				Add(ans,g1);
			end;
	end;
	WriteLong(ans);
End.