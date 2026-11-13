Type Integer=LongInt;
     TLong=Array[0..100]of Integer;

Const MaxN=500;

Function Is0(var g:TLong):Boolean;
Begin
  is0:=(g[0]=0);
End;

Var mk,b1,b2,n,t,i,j,k:Integer;
		sp,ans,d:Array[0..MaxN]of TLong;
    k_ans,vsp:TLong;

Function Min(a,b:Integer):integer;
begin
	if a<b then min:=a else min:=b;
end;

Procedure WriteLong(var g:TLong);
Var i:Integer;
Begin
        if Is0(g) then Write('0') else begin
        while g[g[0]]=0 do Dec(g[0]);Write(g[g[0]]);
	for i:=g[0]-1 downto 1 do begin
           if g[i]<1000 then Write('0');
           if g[i]<100 then Write('0');
           if g[i]<10 then Write('0');
           Write(g[i]);end;
        end;
End;

Procedure MulLong(var g1,g2,g:TLong);
Var i,j,z,tec:Integer;
Begin
        if Is0(g1)or Is0(g2) then begin g[0]:=0;exit;end
        else begin
        g[0]:=g1[0]+g2[0];z:=0;
        for i:=1 to g[0] do g[i]:=0;
	for i:=1 to g1[0] do begin
		z:=0;
		for j:=1 to g2[0] do begin
			tec:=g1[i]*g2[j]+z+g[i+j-1];
			g[i+j-1]:=tec mod 10000;
			z:=tec div 10000;
		end;
		if z<>0 then g[i+g2[0]]:=z;
	end;
	if g[g[0]]=0 then Dec(g[0]);end;
End;

Procedure Add(var a,b:Tlong);
Var tec,x,i,z:Integer;
    f1,f2:Boolean;
Begin
        f1:=Is0(a);f2:=Is0(b);
        if f2 then exit;
        if f1 then begin
          a:=b;exit;
        end;
        z:=0;
	if a[0]>b[0] then x:=a[0] else x:=b[0];
	for i:=1 to x do begin
		tec:=a[i]+b[i]+z;
		a[i]:=tec mod 10000;
		z:=tec div 10000;
	end;
	a[0]:=x;
	if z<>0 then begin
		Inc(a[0]);
		a[a[0]]:=z;
	end;
End;

Begin
	Assign(input,'btrees.in');
	Assign(output,'btrees.out');
	Reset(input);ReWrite(output);
	Read(n,t);
	mk:=n div (t-1);
	b1:=min(t-1,n+1);b2:=min(2*t-1,n);
	d[0][0]:=1;
        d[0][1]:=1;
        for i:=1 to mk do begin
          for j:=n downto 1 do begin
            d[j][0]:=0;
            for k:=b1 to b2 do if j>=k then Add(d[j],d[j-k]);
          end;
          sp[i]:=d[n];
          d[0][0]:=0;d[0][1]:=0;
        end;
	fillchar(d,sizeof(d),0);
	d[0][0]:=1;
        d[0][1]:=1;
        fillchar(k_ans,sizeof(k_ans),0);
      	ans[1][0]:=1;ans[1][1]:=1;
        b1:=min(t,mk+1);b2:=min(2*t,mk);
	for i:=1 to mk do begin
		for j:=mk downto 1 do begin
                    d[j][0]:=0;
                    for k:=b1 to b2 do
				if j>=k then Add(d[j],d[j-k]);
                    MulLong(ans[i],d[j],vsp);
                   Add(ans[j],vsp);

                end;
             d[0][0]:=0;d[0][1]:=0;
        end;
        for i:=1 to mk do begin
        MulLong(ans[i],sp[i],vsp);
        Add(k_ans,vsp);
        end;
        WriteLong(k_ans);
End.

