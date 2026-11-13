{$GOTO ON}
{$UNDEF DEBUG}
{$R-,Q-,S-,I-}
{$MODE DELPHI}
label no;
const
	MAXN = 1000;
type
	integer = longint;
  long = array[1..MAXN] of integer;
procedure mul(var r,a,b:long);
var
	i,j:integer;
	carry:int64;
begin
  fillchar(r,sizeof(r),0);
  for i:=1 to MAXN do begin
  	carry := 0;
		for j:=1 to MAXN  do begin
			if(i+j>MAXN) then break;
			carry := carry + r[i+j-1] + a[i]*b[j];
			r[i+j-1] := carry mod 10;
			carry := carry div 10;
		end;
  end;
end;
procedure add(var a,b:long);
var
	i,j:integer;
	carry:int64;
begin
  carry := 0;

  for i:=1 to MAXN do begin
    carry := carry + a[i]+b[i];
    a[i] := (carry+100000000000) mod 10;
    if carry>=0 then carry := carry div 10
    else carry := carry div 10 -1;
  end;
end;
var
	s:ansistring;
	r:double;
	n,k,l,i,j,maxp,p:integer;
	a,b,c,tmp:long;
  print:boolean;
begin
	assign(input,'wordgame.in');
	reset(input);
	assign(output,'wordgame.out');
	rewrite(output);
	readln(k,n);
	readln(s);
	l:=length(s);
	for i:=1 to l-1 do begin
		for j:=1 to i do begin
			if (s[j]<>s[l-i+j]) then begin
				goto no;
			end;
		end;
		maxp := i;
		no:
	end;
	r:=1.0;
	fillchar(a,sizeof(a),0);
	a[1] := k;
	fillchar(b,sizeof(b),0);
	b[1] := 1;
	fillchar(c,sizeof(c),0);
	c[1] := 1;
  p := l;
  while (p>0) do begin
		if (p and 1 = 1) then begin
			mul(tmp,c,a);
			c := tmp;
		end;
		mul(tmp,a,a);
		a := tmp;
		p := p div 2;
  end;
  {$IFDEF DEBUG}
  r:=1;
	for i:=1 to l do begin
		r:= r*k
	end;
  {$ENDIF}
  fillchar(tmp,sizeof(tmp),0);
  tmp[1] := (l-1);
  add(c,tmp);
  {$IFDEF DEBUG}  r:= (r+l-1);  {$ENDIF}

  fillchar(tmp,sizeof(tmp),0);
  tmp[1] := n;
  mul(b,c,tmp);
  c:= b;
  {$IFDEF DEBUG}  r:= r*n;      {$ENDIF}

//c := (c+l-1) * n
  fillchar(tmp,sizeof(tmp),0);
  tmp[1] := (n-1);
  fillchar(b,sizeof(b),0);
  b[1] := (maxp);
  mul(a,b,tmp);
  for i:=1 to MAXN do begin
    a[i] := -a[i];
  end;

// a =  maxp*(n-1);
  {$IFDEF DEBUG}  r:= r - maxp*(n-1);      {$ENDIF}

//	c = c-a
  {$IFDEF DEBUG}  writeln(r);  {$ENDIF}
  add(c,a);
  print:=false;
  for i:= MAXN downto 1 do begin
    if (c[i]<>0) then print:= true;
    if (print) then write(c[i]);
  end;
  writeln('.000000');
  close(input);
	close(output);
end.
