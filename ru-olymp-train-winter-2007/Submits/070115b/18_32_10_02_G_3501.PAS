{$R-,O-,o2-}

type integer=longint;
var G:array [0..4100,0..4100] of byte;
    X,Y,H,S:array [0..4100] of integer;
    a,b,i,j,n,m,k:integer;
    Go:boolean;

procedure DFS(v:integer; f:boolean);
var i:integer;
begin
 if f then begin
   X[v]:=1;
   for i:=1 to n do
    if G[v,i]=1 then
     if Y[i]=0 then DFS(i,false);

  end
 else begin
   Y[v]:=1;
   for i:=1 to m do
    if G[i,v]=2 then
     if X[i]=0 then DFS(i,true);
   if (not Go) and (S[v]=0) then begin
     Go:=True;
     for i:=1 to n do
      if S[i]=1 then
       if Y[i]=0 then DFS(i,false)
    end
  end
end;


begin
 assign(input,'minimal.in');
 assign(output,'minimal.out');
 reset(input);
 rewrite(output);
 read(m,n);
 fillchar(G,sizeof(G),0);
 for i:=1 to m do begin
   read(k);
   for j:=1 to k do begin
     read(a);
     G[i,a]:=1
    end
  end;
 fillchar(S,sizeof(S),0);
 for i:=1 to m do begin
   read(H[i]);
   if H[i]<>0 then begin
     G[i,H[i]]:=2;
     S[H[i]]:=1
    end
  end;
 fillchar(X,sizeof(X),0);
 fillchar(Y,sizeof(Y),0);
 Go:=False;
 for i:=1 to m do
  if (X[i]=0) and (H[i]=0) then DFS(i,True);
 a:=0;
 for i:=1 to m do
  if X[i]=0 then inc(a);
 b:=0;
 for i:=1 to n do
  if Y[i]<>0 then inc(b);
 writeln(a+b);
 write(a,' ');
 for i:=1 to m do
  if X[i]=0 then write(i,' ');
 writeln;
 write(b,' ');
 for i:=1 to n do
  if Y[i]<>0 then write(i,' ');
 close(output);
 close(input)
end.