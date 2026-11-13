// PLEASE, CORRECT DIRECTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}
uses Math;
const StreamIn='rooks.in';
      StreamOut='rooks.out';
      Base=10000;
      Inf=-1;
type
 integer=longint;

var d:array [0..110,0..111,0..110] of integer;
    cnk:array [0..110,0..110] of integer;
    a,b,v,i,j,n,m,kk,ll,k:integer;

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

begin
 OpenFiles;
 Cnk[0,0]:=1;
 for i:=1 to 110 do begin
   Cnk[i,0]:=1;
   for j:=1 to 110 do Cnk[i,j]:=(Cnk[i-1,j]+Cnk[i-1,j-1]) mod Base
  end;
 read(n,m,kk,ll);
 fillchar(d,sizeof(d),0);
 d[0,0,0]:=1;
 for a:=1 to n do
  for b:=1 to m do
   for k:=1 to kk do
    for i:=1 to k do
     for j:=0 to min(i,a) do
 D[a,b,k]:=(D[a,b,k]+(D[a-j,b-1,k-i]*Cnk[a,j]*Cnk[a-j,i-j]) mod Base) mod Base;
 a:=0;
 for i:=1 to n do
  for j:=1 to m do begin
    v:=d[i,j,kk]*Cnk[(n-i)*(m-j),ll] mod Base;
    v:=v*Cnk[n,i] mod Base;
    v:=v*Cnk[m,j] mod Base;
    a:=(a+v) mod  Base
   end;
 writeln(a);
 CloseFiles
end.
