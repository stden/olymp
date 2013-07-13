// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='nextperm.in';
      StreamOut='nextperm.out';


procedure OpenFiles;
begin
 assign(input,StreamIn);
 reset(input);
 assign(output,StreamOut);
 rewrite(output)
end;

procedure CloseFiles;
begin
 close(input);
 close(output)
end;

var A:array [0..55000] of integer;
    n,i,t,k,j:integer;


procedure Sort(l,r:integer);
var k,i,j,q:integer;
begin
 i:=l;
 j:=r;
 q:=A[l+random(r-l+1)];
 repeat
  while A[i]<q do inc(i);
  while A[j]>q do dec(j);
  if i<=j then begin
    k:=A[i];
    A[i]:=A[j];
    A[j]:=k;
    inc(i); dec(j)
   end
 until i>j;
 if i<r then Sort(i,r);
 if l<j then Sort(l,j)
end;

begin
 randomize;
 OpenFiles;
 read(n);
 for i:=1 to n do read(A[i]);
 i:=n-1;
 while (i>0) and (A[i]>A[i+1]) do dec(i);
 if i=0 then writeln('IMPOSSIBLE')
 else begin
   t:=i+1;
   for j:=i+2 to n do
    if (A[j]>A[i]) and (A[j]<A[t]) then t:=j;
   k:=A[t];
   A[t]:=A[i];
   A[i]:=k;
   Sort(i+1,n);
   for i:=1 to n do write(A[i],' ')
  end;
 CloseFiles
end.
