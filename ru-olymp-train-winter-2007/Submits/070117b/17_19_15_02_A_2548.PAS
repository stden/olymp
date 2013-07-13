// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='badsubstr.in';
      StreamOut='badsubstr.out';
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

var i,n:integer;
    D:array [0..55,'a'..'c','a'..'c'] of int64;
    Sol:int64;
    c1,c2,k:char;


begin
 OpenFiles;
 read(n);
 if n=0 then writeln(1)
 else
  if n=1 then writeln(3)
  else begin
    fillchar(D,sizeof(D),0);
 D[0,'c','c']:=1;
 for i:=0 to n do
  for c1:='a' to 'c' do
   for c2:='a' to 'c' do
    for k:='a' to 'c' do
     if (c2<>'a') or (k<>'b') then inc(D[i+1,c2,k],D[i,c1,c2]);
 Sol:=0;
 for c1:='a' to 'c' do
  for c2:='a' to 'c' do inc(Sol,D[n,c1,c2]);
 writeln(Sol)
 end;
 CloseFiles
end.
