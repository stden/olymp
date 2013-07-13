{$H+,I+,Q+,R+,S+}

Const eps=1e-9;

Type Integer=LongInt;

Procedure quit(s:String);
Begin
  Write(s);halt;
End;
Var nm,i,j,k,n:Integer;
	a:Array[1..20,1..20]of Extended;
	x,b:Array[1..20]of Extended;
    max,koef:Extended;
    use:Array[1..20]of Boolean;
    fl:Boolean;

Function eq0(a:Extended):Boolean;
Begin
  if abs(a)<eps then eq0:=true else eq0:=false;
End;

Begin
  Assign(input,'linear.in');
  Assign(output,'linear.out');
  Reset(input);ReWrite(output);
  Read(n);
  for i:=1 to n do begin
	for j:=1 to n do Read(a[i,j]);
	Read(b[i]);
  end;
  fillchar(use,sizeof(use),false);
  for i:=1 to n do begin
//	max:=-1;
         nm:=-1;
	for j:=1 to n do if (not eq0(a[j,i])){and(abs(a[j,i])>max)}and(not use[j]) then begin
	  {max:=abs(a[j,i]);}nm:=j;break;
	end;if nm=-1 then continue;
	for j:=1 to n do if (j<>nm)and(not eq0(a[j,i])) then begin
	  koef:=a[nm,i]/a[j,i];
	  for k:=1 to n do a[j,k]:=a[nm,k]-a[j,k]*koef;a[j,i]:=0;
	  b[j]:=b[nm]-b[j]*koef;
	end;
	use[nm]:=true;
  end;
  for i:=1 to n do begin
	fl:=false;
	for j:=1 to n do if not eq0(a[i,j]) then begin
	  x[j]:=b[i]/a[i,j];fl:=true;break;
	end;
	if not fl then begin
	  if eq0(b[i]) then quit('infinity') else quit('impossible');
	end;
  end;
  WriteLn('single');
  for i:=1 to n do Write(x[i]:6:6,' ');
End. 