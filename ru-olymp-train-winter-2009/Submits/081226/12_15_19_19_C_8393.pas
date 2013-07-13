{$H+}

Var s:String;
		n:Integer;
		c:Char;
Procedure next;
Var i,u:Integer;
Begin
	u:=n-1;
	while s[u]='1' do Dec(u);
	s[u]:='1';
	for i:=u+1 to n-1 do s[i]:='0';
End;

Function less(a:Integer):Boolean;
Var i:integer;
Begin
  for i:=a to n do begin
	if s[i-a+1]<s[i] then begin
	  less:=true;exit;
	end;
	if s[i-a+1]>s[i] then begin
	  less:=false;exit;
	end;
  end;
  less:=false;
End;

Function Prime:Boolean;
Var i:Integer;
Begin
  Prime:=false;
  for i:=2 to n do if not less(i) then exit;
  Prime:=true;
End;

Begin
	Assign(input,'next.in');
	Assign(output,'next.out');
	Reset(input);ReWrite(output);
	s:='';n:=0;
	while not EoLn do begin
		Read(c);s:=s+c;Inc(n);
	end;
	Next;
	while not Prime do next;
	Write(s);
End. 
 