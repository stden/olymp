// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='bit.in';
      StreamOut='bit.out';
      NMax=110000;
      Answer:array [False..True] of string=('NO','YES');
type
 integer=longint;
 CharVect=array [0..NMax] of char;
 DpTable=array [0..NMax,'a'..'c'] of boolean;
var S:CharVect;
    Val:DpTable;
    CaseNum,n:integer;


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

procedure Process;
var i,v:integer;
    c,k,u:char;
begin
 read(CaseNum);
 for v:=1 to CaseNum do begin
   read(n);
   for i:=1 to n do begin
     read(S[i]);
     while not (S[i] in ['a','b','c']) do read(S[i])
    end;
   fillchar(Val,sizeof(Val),False);
   Val[0,'a']:=True;
   for i:=0 to n-1 do
    for c:='a' to 'c' do
     if Val[i,c] then begin
       if ((i+1)<n) and ((i=0) or (c=S[i])) then
        for k:='a' to 'c' do
         if k<>S[i+1] then Val[i+2,k]:=True;
       if (i>0) and (c<>S[i]) then
        for k:='a' to 'c' do
         if (k<>S[i]) and (k<>c) then Val[i+1,k]:=True;
       if (i+2)<n then
        for k:='a' to 'c' do
         for u:='a' to 'c' do
          if k<>u then
           if (u<>S[i+1]) and (u<>S[i+2]) and (S[i+1]<>S[i+2])
           then begin
             Val[i+3,k]:=True;
             Break
            end
      end;
   writeln(Answer[Val[n,S[n]]])
  end
end;

begin
 OpenFiles;
 Process;
 CloseFiles
end.
