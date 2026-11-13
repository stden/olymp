
{$H+}
Const eps=1e-9;

Type Integer=LongInt;
		TXZ=record
			row,col:Integer;
    end;

Procedure quit(s:String);
Begin
  Write(s);halt;
End;
Var kol,nvar,nm,i,j,k,n:Integer;
	a_given,a:Array[0..20,0..21]of Extended;
	x,b,b_given:Array[0..21]of Extended;
    rez,max,koef:Extended;
    use_var,use_col:Array[1..20]of Boolean;
		arr:Array[1..20]of TXZ;
    fl,fl_inf:Boolean;

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
  a_given:=a;b_given:=b;fl_inf:=false;kol:=n;
  fillchar(use_var,sizeof(use_var),false);
  fillchar(use_col,sizeof(use_col),false);
  for i:=1 to n do begin
	max:=-1;nm:=-1;
        for j:=1 to n do
          for k:=1 to n do if (not use_var[j])and(not use_col[k])and(not eq0(a[j,k]))and(abs(a[j,k])>max) then begin
            nm:=j;nvar:=k;max:=abs(a[j,k]);
          end;
          if nm=-1 then break;
	for j:=1 to n do if (not use_var[j])and(j<>nm)and(not eq0(a[j,nvar])) then begin
	  koef:=a[nm,nvar]/a[j,nvar];
	  for k:=1 to n do a[j,k]:=a[nm,k]-a[j,k]*koef;a[j,nvar]:=0;
	  b[j]:=b[nm]-b[j]*koef;
	end;
	use_var[nm]:=true;use_col[nvar]:=true;Dec(kol);
	arr[i].row:=nm;arr[i].col:=nvar;
  end;
  if kol<>0 then begin
    for i:=1 to n do begin
      fl:=false; for j:=1 to n do if not eq0(a[i,j]) then begin fl:=true;break;end;
      if not fl then
        if eq0(b[i]) then fl_inf:=true else quit('impossible');
    end;
  end;
  if fl_inf then quit('infinity');
  for i:=n downto 1 do begin
		rez:=b[arr[i].row];
		for j:=n downto i+1 do rez:=rez-a[arr[i].row,arr[j].col]*x[arr[j].col];
		x[arr[i].col]:=rez/a[arr[i].row,arr[i].col];
  end;

  WriteLn('single');
  for i:=1 to n do if eq0(x[i]) then Write('0.000 ') else Write(x[i]:6:6,' ');
  for i:=1 to n do begin
    rez:=0;
    for j:=1 to n do rez:=rez+a_given[i,j]*x[j];
    if not eq0(rez-b_given[i]) then while true do;
  end;
End. 
