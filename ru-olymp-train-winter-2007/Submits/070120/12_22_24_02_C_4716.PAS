// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Math, SysUtils;

const StreamIn='rle.in';
      StreamOut='rle.out';
      NMax=210000;
      SafeSimb='$';
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
 Int64Vect=array [0..NMax] of int64;
 ChrVect=array [0..NMax] of char;
var A,Av:ChrVect;
    P,Z,Val,List:IntVect;
    B,Bv:Int64Vect;
    n,m:integer;
    S:string;

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
var c:char;
    State,i,k:integer;
    Num:string;
begin
 n:=0;
 State:=0;
 while not seekeoln do begin
   read(c);
   if c in ['a'..'z'] then begin
     inc(n);
     A[n]:=c;
     if State=0 then B[n]:=1
     else B[n]:=StrToInt(Num);
     State:=0
    end
   else
    if State=0 then begin
      Num:=c;
      State:=1
     end
    else Num:=Num+c
  end;
 for i:=n downto 2 do
  if A[i]=A[i-1] then B[i-1]:=B[i-1]+B[i];
 k:=1;
 for i:=2 to n do
  if A[i]<>A[i-1] then begin
    inc(k);
    A[k]:=A[i];
    B[k]:=B[i]
   end;
 n:=k;
 read(m)
end;

procedure SimpleKmp;
var i,j,k:integer;
begin
 S:='';
 for i:=1 to n do
  for j:=1 to B[i] do S:=S+A[i];
 P[1]:=0;
 k:=0;
 for i:=2 to length(S) do begin
   while (k>0) and (S[i]<>S[k+1]) do k:=P[k];
   if S[i]=S[k+1] then inc(k);
   P[i]:=k
  end;
 for i:=1 to m do begin
   read(k);
   writeln(P[k])
  end
end;

function Eq(const i,j:integer):boolean;
begin
 Result:=(Av[i]=Av[j]) and (Bv[i]=Bv[j])
end;

procedure SmartKmp;
var i,j,k,l,r,v,q,Ans:integer;
begin
 for i:=2 to n do begin
   Av[i-1]:=A[i];
   Bv[i-1]:=B[i]
  end;
 Av[n]:=SafeSimb;
 Bv[n]:=0;
 for i:=1 to n do begin
   Av[n+i]:=A[i];
   Bv[n+i]:=B[i]
  end;
 l:=0;
 r:=0;
 Z[1]:=0;
 for i:=2 to 2*n do
  if i>r then begin
    j:=1;
    while ((i+j-1)<=2*n) and Eq(j,i+j-1) do inc(j);
    Z[i]:=j-1;
    l:=i;
    r:=i+Z[i]-1
   end
  else begin
    k:=i-l+1;
    if (i+Z[k]-1)<r then Z[i]:=Z[k]
    else begin
      l:=i;
      j:=r-i;
      while ((i+j+1)<=2*n) and Eq(j+1,i+j+1) do inc(j);
      Z[i]:=j;
      r:=i+Z[i]-1
     end
   end;
 List[0]:=0;
 Val[0]:=0;
 for i:=1 to n do begin
   if (i<>1) and (A[i]=A[1]) and (B[i]>=B[1]) then begin
     inc(List[0]);
     List[List[0]]:=i
    end;
   Val[i]:=Val[i-1]+B[i]
  end;
 for v:=1 to m do begin
   read(k);
   l:=0; r:=n;
   while (l+1)<r do begin
     q:=(l+r) div 2;
     if Val[q]<k then l:=q else r:=q
    end;
   if A[1]=A[r] then begin
     q:=k-Val[r-1];
     if r<>1 then Ans:=Min(q,B[1])
     else Ans:=q-1
    end
   else Ans:=0;
   i:=1;
   while (i<=List[0]) and (List[i]<r) do begin
     if Z[n+List[i]+1]>=(r-List[i]-1) then begin
       q:=r-List[i]+1;
       if (A[q]=A[r]) and (B[q]>=(k-Val[r-1]))
       then Ans:=Max(Ans,Val[r-1]-Val[List[i]]+B[1]+(k-Val[r-1]))
      end;
     inc(i)
    end;
   writeln(Ans)
  end
end;

procedure Analize;
var i:integer;
    k:int64;
begin
 k:=0;
 for i:=1 to n do k:=k+B[i];
 if k<(NMax-1) then SimpleKmp
 else SmartKmp
end;

begin
 OpenFiles;
 LoadData;
 Analize;
 CloseFiles
end.
