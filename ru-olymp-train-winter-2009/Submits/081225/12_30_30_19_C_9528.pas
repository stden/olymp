{$H+}

Type Integer=LongInt;
Var ans,i,j,n,m,x,u,v,p:Integer;
		a:Array[1..400000]of Integer;
Begin
	Assign(input,'dynarray.in');
	Assign(output,'dynarray.out');
	Reset(input);ReWrite(output);
	Read(n,m);
	for i:=1 to n do read(a[i]);
	for i:=1 to m do begin
		Read(x);
		case x of
			1:begin
					Read(u,p);
					a[u]:=p;
				end;
			2:begin
					Read(u,p);
					for j:=n downto u do a[j+1]:=a[j];
					a[u]:=p;
					Inc(n);
				end;
			3:begin
				ans:=0;
				Read(u,v,p);
				for j:=u to v do if a[j]<=p then Inc(ans);
				WriteLn(ans);
			end;
		end;
	end;
End. 
