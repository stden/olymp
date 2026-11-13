{$H+}

Const MaxL=4000;
			inf=100000;
Type Integer=LongInt;

Var fr,d:Array[0..MaxL]of Integer;
		n,i,j,tec,tw:Integer;
		ans:Array[1..MaxL]of String;
		pal:Array[1..MaxL,1..MaxL]of Boolean;
		s:String;
		c:Char;

Procedure opt(i,j:Integer);
Begin
	if d[j]+1<d[i] then begin
		d[i]:=d[j]+1;
		fr[i]:=j;
	end;
End;
Procedure PreCalc;
Var i,l,r:Integer;
Begin
	for i:=1 to n do begin
		l:=i;r:=i;
		while (l>=1)and(r<=n) and (s[l]=s[r]) do begin
			pal[l,r]:=true;Dec(l);Inc(r);
		end;
		l:=i;r:=i+1;
		while (l>=1)and(r<=n) and (s[l]=s[r]) do begin
			pal[l,r]:=true;Dec(l);Inc(r);
		end;
	end;
End;

begin
	Assign(input,'palin.in');
	Assign(output,'palin.out');
	Reset(input);ReWrite(output);
	n:=0;s:='';
	while not EoLn do begin
		Read(c);s:=s+c;Inc(n);
	end;
	PreCalc;d[0]:=0;
	for i:=1 to n do begin
		d[i]:=inf;
		for j:=1 to i do if pal[j,i] then opt(i,j-1);
	end;
	WriteLn(d[n]);
	tec:=n;tw:=d[n];
	while tw<>0 do begin
		ans[tw]:='';
		for i:=fr[tec]+1 to tec do ans[tw]:=ans[tw]+s[i];
		tec:=fr[tec];
		Dec(tw);
	end;
	for i:=1 to d[n] do if i<>d[n] then WriteLn(ans[i]) else Write(ans[i]);
end. 
