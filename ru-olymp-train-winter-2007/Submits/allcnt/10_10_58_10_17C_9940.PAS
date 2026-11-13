type
 Matrix=array[1..30,1..30] of int64;
 bb=array[1..60] of int64;
 integer=longint;
var
 A,B:Matrix;
 N,M,P:integer;
 Q,Bi,D,G:array[1..60] of int64;
 i,j,u,v,s,k,res , pp:integer;
 BAG:array[0..30] of Matrix;
 ResM:Matrix;
 gg2:bb;
function xz2(A,B:Matrix):Matrix;
var
 M:Matrix;
 i,j,k:integer;
begin
 fillchar(M,sizeof(M),0);
 for k:=1 to n do
  for i:=1 to n do
   for j:=1 to n do
{    if (D[i]=u) and (D[j]=u) and (D[k]=u) then}
     M[i,j]:=(M[i,j]+(A[i,k]*B[k,j]) mod p) mod p;

 xz2:=M;
end;


procedure xz(var Gg:bb;{ B:Matrix;} v:integer);
var
 pP:Matrix;
 bbc,bbc2:boolean;
 i,j:integer;
begin
 bbc:=true;
 bbc2:=true;
 fillchar(ResM,sizeof(ResM),0);
 while v<>0 do begin
  if bbc then begin
   pP:=BAG[u];
   bbc:=false;
  end else
   Pp:=xz2(pP,pP);
  if v mod 2 = 1 then begin
   if bbc2 then begin
    ResM:=pp;
    bbc2:=false;
   end else
    ResM:=xz2(ResM,pp);
  end;
  v:=v div 2;
 end;
end;



procedure BFS(s:integer);
var
 h,t,x:INTEGER;

procedure Add(x:integer);
begin
 inc(t);
 Q[t]:=x;
end;

function Get:integer;
begin
 Get:=Q[h];
 inc(h);
end;


begin
 fillchar(Bi,sizeof(Bi),0);
 t:=0;
 h:=1;
 add(s);
 D[s]:=0;
 Bi[s]:=1;
 while h-t<>1 do begin
  x:=get;
  for i:=1 to n do
   if (A[x,i]<>0) and (Bi[i]=0) then begin
    add(i);
    Bi[i]:=1;
    D[i]:=D[x]+1;
   end;
 end;
end;


begin
  assign(input,'restore.in'); reset(input);
  assign(output,'restore.out'); rewrite(output);
  readln(N,M,P);
  for i:=1 to M do begin
   readln(u,v);
   A[u,v]:=1; A[v,u]:=1;
  end;

  readln(s);
  readln(k);

  BFS(s);

  for pp:=0 to n do
   for i:=1 to N do
    for j:=1 to N do
     if (A[i,j]=1) and (D[j]=pp) then
      BAG[pp][i,j]:=1
     else
      BAG[pp][i,j]:=0;

  for pp:=1 to k do begin
   readln(u,v);
   if pp=1 then begin
    for i:=1 to N do
      if D[i]=u then G[i]:=1;
     dec(v);
     if v=0 then continue;
    end;

   xz(G,v);
   fillchar(gg2,sizeof(gg2),0);
   for i:=1 to N do
    for j:=1 to N do
     if ResM[i,j]<>0 then
      gg2[j]:=(gg2[j]+g[i]*ResM[i,j]) mod p;
   g:=gg2;
  end;

  for i:=1 to N do
   res:=(res + G[i]) mod p;
  writeln(res);

  close(input);
  close(output);
end.
