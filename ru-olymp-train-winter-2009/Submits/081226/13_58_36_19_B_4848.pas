Uses SysUtils;

Type Integer=longint;

Const TL:Extended=5.9/86400;

Var st:Extended;
		j,i,a,b,n,m,half,u,k,min,ans,mask:Integer;
		g,g1:Array[1..30,0..30]of Integer;
		num,num1:Array[1..30] of Integer;
		sp:Array[1..15] of Integer;
Procedure Sort(l,r:Integer);
Var i,j,x,y:Integer;
		y1:Array[0..30]of Integer;
Begin
	i:=l;j:=r;
	x:=g[(l+r)div 2,0];
	repeat
		while g[i,0]<x do Inc(i);
		while x<g[j,0] do dec(j);
		if i<=j then begin
			y1:=g[i];g[i]:=g[j];g[j]:=y1;
			y:=num[i];num[i]:=num[j];num[j]:=y;
			    Inc(i);Dec(j);
                end;
        until i>j;
	if l<j then sort(l,j);
	if i<r then sort(i,r);
End;



Procedure Check;
Var tec,i,j,x,y:Integer;
Begin
	mask:=0;tec:=0;
	for i:=1 to half do mask:=(mask or (1 shl (sp[i]-1)));
	for i:=1 to n do
		for j:=i+1 to n do begin
                x:=mask and (1 shl (i-1));y:=mask and (1 shl (j-1));
     if (g[i,j]=1) and (x+y<>0)and(x*y=0) then Inc(tec);
     end;
	if tec<min then begin
		min:=tec;ans:=mask;
	end;
End;

Procedure Print;
Var an,arr:Array[1..15]of Integer;
		i,j,t,x,y:Integer;
		fl:Boolean;
Begin
	t:=0;
	for i:=1 to n do begin
         x:=ans and (1 shl (i-1));
       if (x<>0) then begin
		Inc(t);arr[t]:=i;
	end;end;t:=0;
	for i:=1 to half do arr[i]:=num[arr[i]];
	for i:=1 to half-1 do
		for j:=1 to half-i do
			if arr[j]>arr[j+1] then begin
				y:=arr[j];arr[j]:=arr[j+1];arr[j+1]:=y;
			end;
	if arr[1]<>1 then begin
		for i:=1 to n do begin
			fl:=true;
			for j:=1 to half do if i=arr[j] then begin fl:=false;break;end;
			if fl then begin Inc(t);an[t]:=i;end;
		end;
		for i:=1 to half do Write(an[i],' ');
		end else 
			for i:=1 to half do Write(arr[i],' ');
	halt;
End;

Begin
	st:=now;
	Assign(input,'half.in');
	Assign(output,'half.out');
	Reset(input);ReWrite(output);
	Read(n,m);
	half:=n shr 1;
	for i:=1 to n do num[i]:=i;
	for i:=1 to m do begin
		Read(a,b);
		Inc(g[a,0]);g[a,b]:=1;
		Inc(g[b,0]);g[b,a]:=1;
	end;
	Sort(1,n);
        for i:=1 to n do num1[num[i]]:=i;
        for i:=1 to n do
           for j:=1 to n do if g[i,j]=1 then g1[i,num1[j]]:=1;
        g:=g1;
        for i:=1 to half do sp[i]:=i;
	min:=30000;k:=1;
	while true do begin
		Check;if min=0 then print;
		k:=(k+1)and 1023;
		if (k=0)and(now-st>TL) then print;
		u:=half;
		while (u>0)and(sp[u]=u+half) do Dec(u);
		Inc(sp[u]);
		for i:=u+1 to half do sp[i]:=sp[u]+i-u;
		if u=1 then print;
	end;
End. 