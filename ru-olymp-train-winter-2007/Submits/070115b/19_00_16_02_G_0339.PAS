{$R-,O-,o2-}

type integer=longint;
type
 IntList=array of integer;
var G:array [1..4100] of IntList;
    k,n,m,i,j,a,b:integer;
    Go:boolean;
    X,Y,Mat1,Mat2:array [0..4100] of integer;

procedure DFS(u:integer; f:boolean);
var i:integer;
begin
 if f then begin
   X[u]:=1;
   if length(G[u])>0 then
    for i:=0 to High(G[u]) do
     if Mat1[u]<>G[u,i] then
      if Y[G[u,i]]=0 then DFS(G[u,i],false)
  end
 else begin
   Y[u]:=1;
   if Mat2[u]<>0 then begin
     if X[Mat2[u]]=0 then DFS(Mat2[u],true)
    end
   else
    if not Go then begin
      Go:=True;
      for i:=1 to n do
       if (X[i]=0) and (Mat2[i]<>0) then DFS(i,false)
     end
  end
end;

begin
 assign(input,'minimal.in');
 assign(output,'minimal.out');
 reset(input);
 rewrite(output);
 read(m,n);
 for i:=1 to m do begin
   read(k);
   setlength(G[i],k);
   for j:=0 to k-1 do read(G[i,j])
  end;
 fillchar(Mat2,sizeof(Mat2),0);
 for i:=1 to m do begin
   read(Mat1[i]);
   if Mat1[i]<>0 then Mat2[Mat1[i]]:=i
  end;
 fillchar(X,sizeof(X),0);
 fillchar(Y,sizeof(Y),0);
 Go:=False;
 for i:=1 to m do
  if (Mat1[i]=0) and (X[i]=0) then DFS(i,true);
  a:=0; b:=0;
 for i:=1 to m do inc(a,1-X[i]);
 for i:=1 to n do inc(b,Y[i]);
 writeln(a+b);
 write(a,' ');
 for i:=1 to m do
  if X[i]=0 then write(i,' ');
 writeln;
 write(b,' ');
 for i:=1 to n  do
  if Y[i]=1 then write(i,' ');
 close(output);
 close(input)
end.
