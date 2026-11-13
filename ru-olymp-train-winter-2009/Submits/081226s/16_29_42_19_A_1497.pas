{$H+,I+,Q+,R+,S+}

Const eps=1e-5;

Type Integer=LongInt;

Procedure quit(s:String);
Begin
  WriteLn(s);halt;
End;
Var nvar,nm,i,j,k,n:Integer;
	a_given,a:Array[1..20,1..20]of Extended;
	x,b,b_given:Array[1..20]of Extended;
    rez,max,koef:Extended;
    use_var,use_col:Array[1..20]of Boolean;
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
  a_given:=a;b_given:=b;
  fillchar(use_var,sizeof(use_var),false);
  fillchar(use_col,sizeof(use_col),false);
  for i:=1 to n do begin
	max:=-1;nm:=-1;
        for j:=1 to n do
          for k:=1 to n do if (not use_var[j])and(not use_col[k])and(not eq0(a[j,k]))and(abs(a[j,k])>max) then begin
            nm:=j;nvar:=k;max:=abs(a[j,k]);
          end;
          if nm=-1 then break;
	for j:=1 to n do if (j<>nm)and(not eq0(a[j,nvar])) then begin
	  koef:=a[nm,nvar]/a[j,nvar];
	  for k:=1 to n do a[j,k]:=a[nm,k]-a[j,k]*koef;a[j,nvar]:=0;
	  b[j]:=b[nm]-b[j]*koef;
	end;
	use_var[nm]:=true;use_col[nvar]:=true;
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
  for i:=1 to n do begin
    rez:=0;
    for j:=1 to n do rez:=rez+a_given[i,j]*x[j];
    if not eq0(rez-b_given[i]) then while true do;
  end;
End. 