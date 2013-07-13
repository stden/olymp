var

 i,j,n,f:longint;
 a:array[0..300000] of int64;
 b:array[0..300000] of longint;
 p:array[0..300000] of longint;
 u:array[0..300000] of boolean;

function bsearch(i,j,v:longint):longint;
 var
  l,r,m:longint;
 begin
  l:=i;
  r:=j+1;
  while(r-l>1) do begin
   m:=(r+l) div 2;
   if a[b[l]] >= a[b[m]] then
    l:=m
   else
    r:=m;
  end;
  bsearch:=l;
 end;

begin
 fillchar(u,sizeof(u),0);
 assign(input,'subseq.in');
 reset(input);
 assign(output,'subseq.out');
 rewrite(output);
 read(n);
 for i:=1 to n do begin
  read(a[i]);
 end;

 a[0]:=1000000000000000;
 b[0]:=0;
 j:=0;
 for i:=1 to n do begin
  f:=bsearch(0,j,a[i]);
  writeln(f);
  if (f=j)or(a[b[f+1]]<a[i]) then begin
   p[i]:=b[f];
   b[f+1]:=a[i];
   inc(j);
  end;
 end;

 i:=b[j];
 while i>0 do begin
  u[i]:=true;
  i:=p[i];
 end;

 writeln(j);
 for i:=1 to n do begin
  if u[i] then
   writeln(i);
 end;

 close(input);
 close(output);
end.
