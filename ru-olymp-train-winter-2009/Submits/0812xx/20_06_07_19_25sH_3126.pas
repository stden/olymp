Type Integer=Longint;
Const inf=MaxLongInt;
Var k,mask,v,t1,t,n,i,j,min,tec,nm:Integer;
		a:Array[1..19,1..19]of Integer;
		d,fr:Array[0..(1 shl 19)-1,1..19]of Integer;
Begin
	Assign(input,'salesman.in');
	Assign(output,'salesman.out');
	reset(input);ReWrite(output);
	Read(n);
	for i:=1 to n do
		for j:=1 to n do Read(a[i,j]);
	min:=MaxLongInt;
	t:=(1 shl n)-1;
        for mask:=1 to t do begin
		for v:=1 to n do begin
    if mask and (1 shl (v-1))=0 then continue;
    k:=0;
			for i:=0 to n-1 do if (mask and (1 shl i))<>0 then Inc(k);
	if k=1 then begin
		d[mask,v]:=0;continue;
	end;
	d[mask,v]:=inf;
	for i:=0 to n-1 do if (mask and (1 shl i))<>0 then
		if v<>i+1 then
			if d[mask,v]>a[v,i+1]+d[mask-(1 shl (v-1)),i+1]
				then begin d[mask,v]:=a[v,i+1]+d[mask-(1 shl (v-1)),i+1];
						   fr[mask,v]:=i+1;
						 end;
		end;
	end;
	min:=inf;
	for i:=1 to n do if d[t,i]<min then begin
		min:=d[t,i];nm:=i;
	end;
	WriteLn(min);
	tec:=nm;
	while t<>0 do begin
		Write(tec,' ');
		t1:=tec;
		tec:=fr[t,tec];
		t:=t-(1 shl (t1-1));
	end;
End. 