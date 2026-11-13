type
 Tlong=array[0..100] of integer;

var
 a,b,c,a1,b1,c1:TLong;
 n, i:integer;


function max(a,b:integer):integer;
begin
 if a>b then max:=a else max:=b;
end;

function Sum(a,b:TLong):TLong;
var
 i,m:integer;
 C:TLong;
begin
 fillchar(C,sizeof(C),0);
 m:=max(a[0],b[0]);
 for i:=1 to m do begin
  inc(C[i],A[i]+B[i]);
  C[i+1]:=C[i] div 10;
  C[i]:=C[i] mod 10;
 end;
 if C[m+1]<>0 then C[0]:=m+1 else C[0]:=m;
 Sum:=C;
end;

begin
 assign(input,'badsubstr.in'); reset(input);
 assign(output,'badsubstr.out'); rewrite(output);
 readln(n);
 if n=0 then begin
  writeln(1);
  halt;
 end;
 a[0]:=1; a[1]:=1;
 b[0]:=1; b[1]:=1;
 c[0]:=1; c[1]:=1;
 for i:=2 to N do begin
  a1:=Sum(Sum(a,b),c);
  b1:=Sum(b,c);
  c1:=Sum(Sum(a,b),c);
  a:=a1; b:=b1; c:=c1;
 end;

 a:=Sum(Sum(a,b),c);
 for i:=a[0] downto 1 do
  write(A[i]);

  close(input);
  close(output);
end.
