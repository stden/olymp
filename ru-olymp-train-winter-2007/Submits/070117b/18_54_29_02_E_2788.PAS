// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='patterns.in';
      StreamOut='patterns.out';
type
 integer=longint;
 IntVect=array [0..11000] of boolean;
var D,W:IntVect;
    A,B:string;
    i,j:integer;

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

var f:boolean;

begin
 OpenFiles;
 readln(A);
 readln(B);
 if length(B)=0 then begin
   f:=true;
   for i:=1 to length(A) do begin
     if A[i]<>'*' then begin
       writeln('NO');
       f:=false;
       Break
      end;
    end;
   if f then writeln('YES')
  end
 else begin
 fillchar(D,sizeof(D),False);
 D[0]:=True;
 for i:=1 to length(B) do begin
   fillchar(W,sizeof(W),False);
   for j:=0 to length(A) do
    if D[j] then begin
      if (j>0) and (A[j]='*') then begin
        W[j]:=True;
       // D[j+1]:=True
       end;
      if j<length(A) then
       if (A[j+1]=B[i]) or (A[j+1]='?') or (A[j+1]='*') then W[j+1]:=True
     end;
   D:=W
  end;
 if D[length(A)] then writeln('YES')
 else writeln('NO')
 end;
 CloseFiles
end.
