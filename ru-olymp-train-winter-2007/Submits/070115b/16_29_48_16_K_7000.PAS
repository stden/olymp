var
 i,j,m,x,n:longint;
 a,b:array[0..120000] of longint;

procedure qsort(l,r:longint);
var
 i,j,m,t:longint;
begin
 if (l >= r) then exit;
 i:=l;
 j:=r;
 m:=l+random(r - l + 1);

 while i<=j do begin
  while (a[i]<a[m])or((a[i]=a[m]) and (b[i] > b[m])) do inc(i);
  while (a[j]>a[m])or((a[j]=a[m]) and (b[j] < b[m])) do dec(j);
  if (i <= j) then begin
   t:=a[i];
   a[i]:=a[j];
   a[j]:=t;
   t:=b[i];
   b[i]:=b[j];
   b[j]:=t;
   inc(i);
   dec(j);
  end;
 end;
 qsort(l,j);
 qsort(i,r);
end;

begin
 randomize;
 assign(input,'segments.in');
 reset(input);
 assign(output,'segments.out');
 rewrite(output);
 readln(n);
 for i:=1 to n do begin
  read(a[2*i-1],a[2*i]);
  if a[2*i - 1]<a[2*i] then begin
   b[2*i-1]:=-1;
   b[2*i]:=1;
  end else begin
   b[2*i]:=-1;
   b[2*i-1]:=1;
  end;
 end;
 qsort(1,2*n);
 j:=0;
 x:=0;
 m:=0;
 for i:=1 to 2*n do begin
  j:=j+b[i];
  if j < m then begin
   m:=j;
   x:=a[i];
  end;
 end;
 writeln(-m,' ',x);
 close(input);
 close(output);
end.
