Type Integer=LongInt;

Const MaxN=500;

Var mk,b1,b2,n,t,i,j,k:Integer;
		d:Array[0..MaxN,0..MaxN]of Int64;
		sp,ans:Array[1..MaxN]of Int64;
    k_ans:Int64;
	
Function Min(a,b:Integer):integer;
begin
	if a<b then min:=a else min:=b;
end;

Begin
	Assign(input,'btrees.in');
	Assign(output,'btrees.out');
	Reset(input);ReWrite(output);
	Read(n,t);
	mk:=n div (t-1);
	b1:=min(t-1,n);b2:=min(2*t-1,n);
	d[0,0]:=1;
	for i:=1 to n do
		for j:=1 to mk do
			for k:=b1 to b2 do
				if i>=k then d[i,j]:=d[i,j]+d[i-k,j-1];
	
	for i:=1 to mk do sp[i]:=d[n,i];
	
	fillchar(d,sizeof(d),0);
	d[0,0]:=1;k_ans:=0;
	
	b1:=min(t,mk);b2:=min(2*t,mk);
	for i:=1 to mk do
		for j:=1 to i do
			for k:=b1 to b2 do
				if i>=k then d[i,j]:=d[i,j]+d[i-k,j-1];
	
	ans[1]:=1;
	for i:=2 to mk do
		for j:=1 to i-1 do begin
			ans[i]:=ans[i]+d[i,j]*ans[j];
		end;
	for i:=1 to mk do k_ans:=k_ans+ans[i]*sp[i];
	Write(k_ans);
End. 