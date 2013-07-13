{$H+}
Type Integer=LongInt;
		 TEdge=record
			v1,v2,w:Integer;
		 end;

Var u,t,i,n,m,k:Integer;
		g:Array[1..300]of TEdge;
		num,ob:Array[1..1 shl 17]of Integer;
		s_arr:Array[1..1 shl 17]of String;
		s:String;

Procedure Sort(l,r:Integer);
Var i,j,x,y:Integer;
Begin
	i:=l;j:=r;
	x:=ob[(l+r)div 2];
	repeat
		while ob[i]<x do Inc(i);
		while x<ob[j] do dec(j);
		if i<=j then begin
			y:=ob[i];ob[i]:=ob[j];ob[j]:=y;
			y:=num[i];num[i]:=num[j];num[j]:=y;
		end;
		Inc(i);Dec(j);
	until i>j;
	if l<j then sort(l,j);
	if i<r then sort(i,r);
End;

Procedure Check;
Var tec,i:Integer;
Begin
	tec:=0;
	for i:=1 to m do
		if (s[g[i].v1]='0')and(s[g[i].v2]='1') then Inc(tec,g[i].w);
	Inc(t);
	s_arr[t]:=s;
	ob[t]:=tec;
	num[t]:=t;
End;

Begin
	Assign(input,'cuts.in');
	Assign(output,'cuts.out');
	Reset(input);ReWrite(output);
	Read(n,m);
	for i:=1 to m do Read(g[i].v1,g[i].v2,g[i].w);
	s:='';
	for i:=1 to n-1 do s:=s+'0';
	s:=s+'1';
	while true do begin
		Check;u:=n-1;
		while (s[u]='1')and(u>1) do Dec(u);
		if u=1 then break;s[u]:='1';
		for i:=u+1 to n-1 do s[i]:='0';
	end;
	Sort(1,1 shl(n-2));
	Read(k);
	for i:=1 to k do WriteLn(s_arr[num[i]]);
End.