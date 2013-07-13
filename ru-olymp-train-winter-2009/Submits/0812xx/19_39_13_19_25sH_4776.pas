Type Integer=Longint;
Const inf=MaxLongInt;
Var t1,t,n,i,j,min,tec,nm:Integer;
		a:Array[1..19,1..19]of Integer;
		d,fr:Array[0..(1 shl 19)-1,1..19]of Integer;
Function f(mask,v:Integer):Integer;
Var i:Integer;
		list:Array[0..19]of Integer;
begin
	if d[mask,v]<>-1 then begin f:=d[mask,v];exit;end;
	list[0]:=0;
	for i:=0 to n-1 do if (mask and (1 shl i))<>0 then begin
		Inc(list[0]);list[list[0]]:=i+1;
	end;
	if list[0]=1 then begin
		f:=0;d[mask,v]:=0;exit;
	end;
	d[mask,v]:=inf;
	for i:=1 to list[0] do
		if v<>list[i] then 
			if d[mask,v]>a[v,list[i]]+f(mask and (not (1 shl (v-1))),list[i]) 
				then begin d[mask,v]:=a[v,list[i]]+d[mask and (not (1 shl (v-1))),list[i]];
						   fr[mask,v]:=list[i]; 
						 end;
	f:=d[mask,v];
End;

Begin
	Assign(input,'salesman.in');
	Assign(output,'salesman.out');
	reset(input);ReWrite(output);
	Read(n);
	for i:=1 to n do
		for j:=1 to n do Read(a[i,j]);
	min:=MaxLongInt;
	t:=(1 shl n)-1;
        for i:=0 to t do
          for j:=1 to n do d[i,j]:=-1;
	for i:=1 to n do begin
		if f(t,i)<min then begin
			min:=d[t,i];nm:=i;
		end;
	end;
	WriteLn(min);
	tec:=nm;
	while t<>0 do begin
		if tec<>0 then Write(tec,' ');
           	t1:=tec;tec:=fr[t,tec];
      		t:=t and (not (1 shl (t1-1)));
	end;
End. 