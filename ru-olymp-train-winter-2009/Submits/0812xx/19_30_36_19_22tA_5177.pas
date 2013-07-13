{$H+,I+,Q+,R+,S+}
Const m2=131072;

Type Integer=LongInt;
     TRoomFill=array[0..4]of Integer;
		 TTreeNode=record
			l,r:Integer;
			rm:TRoomFill;
                        add:Integer;
		 end;

Var i,j,ans,n,k,m,a,b,c:Integer;
    EmptyRoom,t:TRoomFill;
    h:Array[1..2*m2-1]of TTreeNode;

Procedure InitTree;
Var i:Integer;
Begin
	for i:=m2 to 2*m2-1 do begin
		h[i].l:=i-m2+1;
		h[i].r:=h[i].l;
		h[i].rm[0]:=1;
	end;
	for i:=m2-1 downto 1 do begin
		h[i].l:=h[2*i].l;
		h[i].r:=h[2*i+1].r;
		h[i].rm[0]:=2*h[2*i].rm[0];
	end;
End;

Procedure Cycle(var t:TRoomFill);
Var i,x:Integer;
Begin
	x:=t[k-1];
	for i:=k-2 downto 0 do t[i+1]:=t[i];
	t[0]:=x;
End;

Procedure Add(v,l,r:Integer);
Var i:Integer;
Begin
	if (h[v].l>r)or(h[v].r<l) then exit;
	if (h[v].l>=l)and(h[v].r<=r) then begin
		Inc(h[v].add);
		Cycle(h[v].rm);exit;
	end;
	Add(2*v,l,r);Add(2*v+1,l,r);
	for i:=0 to k-1 do h[v].rm[i]:=h[2*v].rm[i]+h[2*v+1].rm[i];
	for i:=1 to h[v].add mod k do Cycle(h[v].rm);
End;

Function query(v,l,r:Integer):TRoomFill;
Var t1,t2,rez:TRoomFill;
    i:Integer;
Begin
	if (h[v].l>r)or(h[v].r<l) then begin
		query:=EmptyRoom;
		exit;
	end;
	if (h[v].l>=l)and(h[v].r<=r) then begin
		query:=h[v].rm;
		exit;
	end;
	t1:=query(2*v,b,c);t2:=query(2*v+1,b,c);
	for i:=0 to k-1 do rez[i]:=t1[i]+t2[i];
        for i:=1 to h[v].add mod k do Cycle(rez);
        query:=rez;
End;

Begin
	Assign(input,'sum.in');
	Assign(output,'sum.out');
        Reset(input);ReWrite(output);
	Read(n,k,m);
        for i:=0 to k-1 do EmptyRoom[i]:=0;
	InitTree;
	for i:=1 to m do begin
		Read(a,b,c);
		if a=1 then Add(1,b,c) else begin 
			t:=query(1,b,c);
			ans:=0;
			for j:=0 to k-1 do ans:=ans+j*t[j];
			WriteLn(ans);
		end;
	end;
End.