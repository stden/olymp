// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Math, SysUtils;

const StreamIn='tourism.in';
      StreamOut='tourism.out';
      NMax=2505;
type
 integer=smallint;
var P:array [0..Sqr(NMax)] of boolean;
    G:array [0..NMax,0..NMax] of boolean;
    Q,F:array [0..NMax] of integer;
    Use:array [0..NMax] of boolean;
    S:string;
    D:array [0..NMax,0..NMax] of integer;
    n,m,MaxQ:integer;

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

procedure Load;
var i:integer;
begin
 readln(n);
 readln(S);
 read(m);
 MaxQ:=0;
 for i:=1 to m do begin
   read(Q[i]);
   MaxQ:=Max(MaxQ,Q[i])
  end
end;

procedure Solve;
var i,j,k,Uk,v,t:integer;
    Found:boolean;
begin
 Uk:=0;
 for i:=1 to length(S) do begin
   if S[i] in ['0'..'9'] then t:=StrToInt(S[i])
   else
    if S[i] in ['A'..'Z'] then t:=10+ord(S[i])-ord('A')
    else
     if S[i] in ['a'..'z'] then t:=36+ord(S[i])-ord('a')
     else
      if S[i]='!' then t:=62
      else t:=63;
   for j:=1 to 6 do begin
     inc(Uk);
     P[Uk]:=(t mod 2)=1;
     t:=t div 2
    end
  end;
 Uk:=0;
 for i:=1 to n do begin
   G[i,i]:=False;
   for j:=i+1 to n do begin
     inc(Uk);
     if P[Uk] then begin
       G[i,j]:=True;
       G[j,i]:=False
      end
     else begin
       G[i,j]:=False;
       G[j,i]:=True
      end
    end
  end;
 fillchar(Use,sizeof(Use),False);
 Found:=False;
 for i:=1 to n do
  if Found then Break else
   for j:=1 to n do
    if Found then Break else
     for k:=1 to n do
      if Found then Break else
       if (i<>j) and (i<>k) and (j<>k) then
        if G[i,j] and (G[j,k]) and (G[k,i])
        then begin
          Found:=True;
          Use[i]:=True;
          Use[j]:=True;
          Use[k]:=True;
          F[0]:=i;
          F[1]:=j;
          F[2]:=k
         end;
 for i:=0 to 2 do D[3,i]:=F[i];
 for i:=4 to min(n,MaxQ) do begin
   Found:=False;
   for j:=1 to n do
    if Found then Break else
     if not Use[j] then
      for k:=0 to i-2 do
       if Found then Break else
        if G[F[k],j] and G[j,F[(k+1) mod (i-1)]]
        then begin
          Found:=True;
          Use[j]:=True;
          for v:=i-1 downto k+1 do F[v+1]:=F[v];
          F[k+1]:=j
         end;
   for j:=0 to i-1 do D[i,j]:=F[j]
  end;
 for i:=1 to m do
  if (Q[i]<3) or (Q[i]>n) then writeln(-1)
  else begin
    for j:=0 to Q[i]-1 do write(D[Q[i],j]-1,' ');
    writeln
   end
end;

begin
 OpenFiles;
 Load;
 Solve;
 CloseFiles
end.
