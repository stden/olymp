// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}
uses math;
const StreamIn='linguae.in';
      StreamOut='linguae.out';
type
 integer=longint;

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


var D,a,b,c:array [0..11000] of integer;
    i,j,n:integer;

begin
 OpenFiles;
 read(n);
 for i:=0 to n-1 do read(a[i],b[i],c[i]);
 for i:=1 to n+4 do D[i]:=1000000000;
 D[0]:=0;
 for i:=0 to n-1 do
  for j:=max(i-5,0) to i do begin
    D[j+1]:=min(D[i]+a[j],D[j+1]);
    D[j+2]:=min(D[i]+b[j],D[j+2]);
    D[j+3]:=min(D[i]+c[j],D[j+3])
   end;
 writeln(Min(D[n],min(D[n+1],D[n+2])));
 CloseFiles
end.
