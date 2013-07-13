// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='parenth.in';
      StreamOut='parenth.out';
      Inf=-1;
      NMax=42;
type
 integer=longint;

var D:array [0..NMax,0..NMax] of int64;
    St,V:array [0..NMax] of integer;
    i,j,n:integer;
    k:int64;

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

function Calc(a,b:integer):int64;
begin
 if D[a,b]=Inf then
  if (a=0) and (b=0) then D[a,b]:=1
  else
   if (a=0) and (b>0) then D[a,b]:=0
   else begin
     D[a,b]:=2*Calc(a-1,b+1);
     if b>0 then D[a,b]:=D[a,b]+Calc(a-1,b-1)
    end;
 Result:=D[a,b]
end;


begin
 OpenFiles;
 read(n,k);
 for i:=0 to 2*n do
  for j:=0 to 2*n do D[i,j]:=Inf;
 St[0]:=0;
 for i:=1 to 2*n do begin
   if Calc(2*n-i,St[0]+1)<k then dec(k,Calc(2*n-i,St[0]+1))
   else begin
     inc(St[0]);
     St[St[0]]:=1;
     V[i]:=1;
     Continue
    end;
   if (St[0]>0) and (St[St[0]]=1) then
    if Calc(2*n-i,St[0]-1)<k then dec(k,Calc(2*n-i,St[0]-1))
    else begin
      dec(St[0]);
      V[i]:=3;
      Continue
     end;
   if Calc(2*n-i,St[0]+1)<k then dec(k,Calc(2*n-i,St[0]+1))
   else begin
     inc(St[0]);
     St[St[0]]:=2;
     V[i]:=2;
     Continue
    end;
   if (St[0]>0) and (St[St[0]]=2) then
    if Calc(2*n-i,St[0]-1)<k then dec(k,Calc(2*n-i,St[0]-1))
    else begin
      dec(St[0]);
      V[i]:=4;
      Continue
     end;
  end;
 for i:=1 to 2*n do
  case V[i] of
    1:write('(');
    2:write('[');
    3:write(')');
    4:write(']')
   end;
 CloseFiles
end.
