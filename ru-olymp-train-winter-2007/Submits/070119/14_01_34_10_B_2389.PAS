uses math;

const
 MaxBit=20;

 type
  integer=longint;

var
 n,m,i, j,p:integer;
 A:array[1..65536] of longint;
 St:array[1..MaxBit] of longint;
 x,y:array[1..10000] of integer;

begin
 assign(input,'optimum.in'); reset(input);
 assign(output,'optimum.out'); rewrite(output);
 St[1]:=1;
 for i:=2 to MaxBit do
  St[i]:=St[i-1]*2;
 readln(n, m,p);
 if n>=16 then begin
  writeln('0');
  close(input); close(output);
  halt;
 end;
 for i:=1 to m do begin
  readln(x[i],y[i]);
  x[i]:=St[x[i]]; y[i]:=St[y[i]];
 end;

 A[0]:=1;
 for j:=1 to m do  begin
  for i:=0 to 65536 do
   if (i<>i or x[j] or y[j]) and ((i=0) or (i and (x[j] or y[j])>0)) then
    inc(A[i or x[j] or y[j]],A[i]);
 end;

 i:=65536;
 while A[i]=0 do dec(i);
 writeln(a[i] mod p);
 close(input);
 close(output);
end.
