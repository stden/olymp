// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Math;

const StreamIn='beauty.in';
      StreamOut='beauty.out';
      NMax=75;
      MMax=55;
      LMax=11000;
      Inf=-1;
type
 integer=longint;
var D:array [0..NMax,0..NMax,0..MMax] of int64;
    P:array [0..LMax] of integer;
    NextJ,NextK:array [0..NMax,0..NMax,0..MMax,'a'..'z'] of word;
    S:array [0..MMax] of string;
    Cost:array [0..MMax] of integer;
    Ans,V:string;
    n,m:integer;


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

procedure LoadData;
var i:integer;
    ch:char;
begin
 read(m);
 for i:=1 to m do begin
   read(ch);
   S[i]:='';
   while not (ch in ['a'..'z']) do read(ch);
   while ch in ['a'..'z'] do begin
     S[i]:=S[i]+ch;
     read(ch)
    end;
   read(Cost[i])
  end;
 m:=Min(m,MMax);
 read(n)
end;

function Kmp(const A,B:string):integer;
var i,k:integer;
    V:string;
begin
 V:=A+'$'+B;
 P[1]:=0;
 k:=0;
 for i:=2 to length(V) do begin
   while (k<>0) and (V[i]<>V[k+1]) do k:=P[k];
   if V[i]=V[k+1] then inc(k);
   P[i]:=k;
   if P[i]=length(A) then k:=P[k]
  end;
 Result:=P[length(V)]
end;

procedure Solve;
var i,j,k,t,Temp,Add,Len,Num,Val,Ni,Nj,Nk,Vi,Vj,Vk:integer;
    c:char;
begin
 for i:=0 to n do
  for j:=0 to n do
   for k:=0 to m do D[i,j,k]:=Inf;
 D[0,0,0]:=0;
 for i:=0 to n-1 do
  for j:=0 to i do
   for k:=0 to m do
    if D[i,j,k]<>Inf then
     for c:='a' to 'z' do begin
       if k=0 then V:=c
       else V:=Copy(S[k],1,j)+c;
       Len:=0;
       Num:=0;
       Add:=0;
       for t:=1 to m do begin
         Temp:=Kmp(S[t],V);
         if Temp<>0 then begin
           if Temp=length(S[t]) then Add:=Add+Cost[t];
           if Len<Temp then begin
             Len:=Temp;
             Num:=t
            end
          end
        end;
       D[i+1,Len,Num]:=Max(D[i+1,Len,Num],D[i,j,k]+Add);
       NextJ[i,j,k,c]:=Len;
       NextK[i,j,k,c]:=Num
      end;
 for i:=n-1 downto 0 do
  for j:=0 to i do
   for k:=0 to m do
    if D[i,j,k]<>Inf then begin
      D[i,j,k]:=Inf;
      for c:='a' to 'z' do
       D[i,j,k]:=Max(D[i,j,k],D[i+1,NextJ[i,j,k,c],NextK[i,j,k,c]])
     end;
 Ni:=0;
 Nj:=0;
 Nk:=0;
 Ans:='';
 for i:=1 to n do begin
   Val:=Inf;
   for c:='a' to 'z' do
    Val:=Max(Val,D[i,NextJ[Ni,Nj,Nk,c],NextK[Ni,Nj,Nk,c]]);
   for c:='a' to 'z' do
    if D[i,NextJ[Ni,Nj,Nk,c],NextK[Ni,Nj,Nk,c]]=Val then begin
      Ans:=Ans+c;
      Vi:=i;
      Vj:=NextJ[Ni,Nj,Nk,c];
      Vk:=NextK[Ni,Nj,Nk,c];
      Break
     end;
   Ni:=Vi;
   Nj:=Vj;
   Nk:=Vk
  end;
 writeln(D[Ni,Nj,Nk]);
 writeln(Ans)
end;

begin
 OpenFiles;
 LoadData;
 Solve;
 CloseFiles
end.
