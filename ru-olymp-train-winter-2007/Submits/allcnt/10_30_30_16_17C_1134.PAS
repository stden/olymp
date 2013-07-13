type
 mat = array[1..30,1..30] of int64;
var
 s,t,n,m,k,p,i,j,a,b,f,prev:longint;
 G:array[1..30,1..30] of boolean;
 TG,TM,TANS,TTG:mat;
 L:array[1..30,1..30] of longint;
 len:array[1..30] of longint;
 ans:array[1..30] of int64;
 VA:array[1..30] of longint;

procedure MUL_TM(var a:mat; var b:mat);
 var
  i,j,k:longint;
 begin
  fillchar(TM,sizeof(TM),0);
  for i:=1 to n do begin
   for j:=1 to n do begin
    for k:=1 to n do begin
     TM[i,j]:=TM[i,j]+a[i,k]*b[k,j];
     if TM[i,j]>=p then TM[i,j]:=TM[i,j] mod p;
    end;
   end;
  end;
 end;

procedure MUL_TANS(var a:mat; var b:mat);
 var
  i,j,k:longint;
 begin
  fillchar(TANS,sizeof(TANS),0);
  for i:=1 to n do begin
   for j:=1 to n do begin
    for k:=1 to n do begin
     TANS[i,j]:=TANS[i,j]+a[i,k]*b[k,j];
     if TANS[i,j]>=p then TANS[i,j]:=TANS[i,j] mod p;
    end;
   end;
  end;
 end;


procedure MUL_TTG(var a:mat; var b:mat);
 var
  i,j,k:longint;
 begin
  fillchar(TTG,sizeof(TTG),0);
  for i:=1 to n do begin
   for j:=1 to n do begin
    for k:=1 to n do begin
     TTG[i,j]:=TTG[i,j]+a[i,k]*b[k,j];
     if TTG[i,j]>=p then TTG[i,j]:=TTG[i,j] mod p;
    end;
   end;
  end;
 end;


procedure power(m:longint);
 var
  ff:int64;
 begin
  TTG:=TG;
  ff:=1;
  while ff<=m do
   ff:=ff*2;
  ff:=ff div 4;
  while ff>0 do begin
   if (ff and m)<>0 then begin
    MUL_TANS(TTG,TTG);
    MUL_TTG(TG,TANS);
   end else begin
    MUL_TM(TTG,TTG);
    TTG:=TM;
   end;
   ff:=ff div 2;
  end;
  TG:=TTG;
 end;

begin
 assign(input,'restore.in');
 reset(input);
 assign(output,'restore.out');
 rewrite(output);
 read(n,m,p);
 for i:=1 to n do
  for j:=1 to n do begin
   G[i,j]:=false;
   L[i,j]:=1000000000;
   if i=j then L[i,j]:=0;
  end;
 for i:=1 to m do begin
  read(a,b);
  G[a,b]:=true;
  G[b,a]:=true;
  L[a,b]:=1;
  L[b,a]:=1;
 end;
 for k:=1 to n do
  for i:=1 to n do
   for j:=1 to n do
    if L[i,k]+L[k,j]<L[i,j]  then
     L[i,j]:=L[i,k]+L[k,j];

 read(s);
 for i:=1 to n do
  len[i]:=L[s,i];

 read(t);
 fillchar(ans,sizeof(ans),0);
 prev:=-1;
 for f:=1 to t do begin
  read(a,b);
  fillchar(TG,sizeof(TG),0);
  fillchar(VA,sizeof(VA),0);

  if prev = -1 then begin
   for j:=1 to n do begin
    if len[j]=a then
     VA[j]:=1;
   end;
  end else begin
   for j:=1 to n do begin
    if len[j] = prev then begin
     for k:=1 to n do begin
      if (len[k] = a)and(G[j,k]) then
       VA[k]:=(VA[k]+ans[j]);
       if VA[k]>=p then VA[k]:=VA[k] mod p;
     end;
    end;
   end;
  end;

  if b = 1 then begin
   fillchar(ans,sizeof(ans),0);
   for i:=1 to n do begin
    if len[i]=a then
     ans[i]:=VA[i];
   end;
  end else begin

   for i:=1 to n do
    if len[i]=a then begin
     for j:=i+1 to n do begin
      if (len[j]=a)and(G[i,j]) then begin
       TG[i,j]:=1;
       TG[j,i]:=1;
      end;
     end;
    end;

   power(b-1);

   fillchar(ans,sizeof(ans),0);

   for i:=1 to n do begin
    for j:=1 to n do begin
     ans[j]:=(ans[j]+VA[i]*TG[i,j]);
     if ans[j]>=p then ans[j]:=ans[j] mod p;
    end;
   end;

  end;
  prev:=a;
 end;
 j:=0;
 for i:=1 to n do begin
  if len[i]=prev then
   j:=(j+ans[i])mod p;
 end;
 writeln(j);
 close(input);
 close(output);
end.
