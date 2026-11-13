Type Integer=LongInt;

Var n1,n2,l,l1,l2,n11,n12,n21,n22:Array[1..20]of Integer;
		i,a,b,n,u:Integer;
Function f(a:Integer):Integer;

Var u,tec,rez:Integer;

Begin
	if a=0 then begin f:=0;exit;end;
	u:=1;rez:=0;
	while l[u]<a do Inc(u);
	tec:=1;
	while u>=1 do begin
		if a<l1[u] then begin
			tec:=1;Dec(u);continue;
		end;
		a:=a-l1[u];
		rez:=rez+n11[u]+n21[u]*2;
		
		if a<l1[u] then begin
			tec:=1;Dec(u);continue;
		end;
		a:=a-l1[u];
		rez:=rez+n11[u]+n21[u]*2;
		
		if a<l2[u] then begin
			tec:=2;Dec(u);continue;
		end;
		a:=a-l2[u];
		rez:=rez+n12[u]+n22[u]*2;

		if a<l1[u] then begin
			tec:=1;Dec(u);continue;
		end;
		a:=a-l1[u];
		rez:=rez+n11[u]+n21[u]*2;
		
		if a<l2[u] then begin
			tec:=2;Dec(u);continue;
		end;
		a:=a-l2[u];
		rez:=rez+n12[u]+n22[u]*2;
		
		if tec=2 then begin
			if a<l1[u] then begin
				tec:=1;Dec(u);continue;
			end;
			a:=a-l1[u];
			rez:=rez+n11[u]+n21[u]*2;
			
			if a<l2[u] then begin
				tec:=2;Dec(u);continue;
			end;
			a:=a-l2[u];
			rez:=rez+n12[u]+n22[u]*2;
		end
	end;
	f:=rez;
End;

Begin
	Assign(input,'digitsum.in');
	Assign(output,'digitsum.out');
	Reset(input);ReWrite(output);
	Read(n);	
	n1[1]:=3;n2[1]:=2;l1[1]:=1;l2[1]:=1;l[1]:=5;
	n11[1]:=1;n21[1]:=0;n12[1]:=0;n22[1]:=1;
	u:=1;
	while l[u]<1000000000 do begin
		Inc(u);
		l[u]:=n1[u-1]*5+n2[u-1]*7;
		n1[u]:=n1[u-1]*3+n2[u-1]*4;
		n2[u]:=n1[u-1]*2+n2[u-1]*3;
		l1[u]:=l[u-1];if u=1 then l2[u]:=1 else
		l2[u]:=4*l1[u-1]+3*l2[u-1];
		n11[u]:=n1[u-1];
		n21[u]:=n2[u-1];
		n12[u]:=n12[u-1]*3+n22[u-1]*4;
		n22[u]:=n12[u-1]*2+n22[u-1]*3;
	end;
	for i:=1 to n do begin
		Read(a,b);WriteLn(f(b)-f(a-1));
	end;
End. 