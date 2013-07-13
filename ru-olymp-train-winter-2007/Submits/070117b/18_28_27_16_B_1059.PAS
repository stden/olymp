{$M 16000000}
var
 A:array[0..200] of longint;
 D:array[0..200,0..200,0..200] of boolean;
 B:array[0..200,0..200,0..200,0..2] of byte;
 i,j,k,s,n,im,jm,km:longint;
 m,s3:extended;
 w:array[0..200] of byte;
 ff:array[0..2] of longint;
procedure DFS(i,j,k,p:byte);
 begin
  D[i,j,k]:=true;
  if p>n then exit;
  if not(D[i+A[p],j,k]) then begin
   B[i+A[p],j,k,0]:=i;
   B[i+A[p],j,k,1]:=j;
   B[i+A[p],j,k,2]:=k;
   DFS(i+A[p],j,k,p+1);
  end;
  if not(D[i,j+A[p],k]) then begin
   B[i,j+A[p],k,0]:=i;
   B[i,j+A[p],k,1]:=j;
   B[i,j+A[p],k,2]:=k;
   DFS(i,j+A[p],k,p+1);
  end;
  if not(D[i,j,k+A[p]]) then begin
   B[i,j,k+A[p],0]:=i;
   B[i,j,k+A[p],1]:=j;
   B[i,j,k+A[p],2]:=k;
   DFS(i,j,k+A[p],p+1);
  end;
 end;

 procedure FDS(i,j,k,p:byte);
 var
  q:byte;
 begin
  if (p=0) then exit;
  if B[i,j,k,0]<>i then w[p]:=0;
  if B[i,j,k,1]<>i then w[p]:=1;
  if B[i,j,k,2]<>i then w[p]:=2;
  FDS(B[i,j,k,0],B[i,j,k,1],B[i,j,k,2],p-1);
 end;

begin
 fillchar(D,sizeof(D),0);
 assign(input,'change.in');
 reset(input);
 assign(output,'change.out');
 rewrite(output);
 read(n);
 s:=0;
 for i:=1 to n do begin
  read(A[i]);
  s:=s+A[i];
 end;

 DFS(0,0,0,1);

 m:=3*s*s;
 s3:=s;
 s3:=s3/3;

 for i:=0 to s do begin
  for j:=0 to s do begin
   for k:=0 to s do begin
    if (i+j+k = s)and(D[i,j,k]) then begin
     if m>( (i-s3)*(i-s3)+(j-s3)*(j-s3)+(k-s3)*(k-s3) ) then begin
      m:=( (i-s3)*(i-s3)+(j-s3)*(j-s3)+(k-s3)*(k-s3) );
      im:=i;
      jm:=j;
      km:=k;
     end;
    end;
   end;
  end;
 end;

 FDS(im,jm,km,n);

 fillchar(ff,sizeof(ff),0);
 for i:=1 to n do begin
  inc(ff[w[i]]);
 end;

 for i:=0 to 2 do begin
  write(ff[i],' ');
  for j:=1 to n do begin
   if w[j]=i then write(A[j],' ');
  end;
  writeln;
 end;

 close(input);
 close(output);
end.
