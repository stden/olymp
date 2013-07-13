{$MODE DELPHI}

var
 n,k,i,j:integer;
 a,b,p,u,f:array[0..100001] of integer;
 s:array[1..100000] of string;
 sum1,sum2:integer;

function RandomRange(L,R:integer):integer;
begin
 result:=L+Random(R-L);
end;


procedure Swap(var a,b:integer);
var
 c:integer;
begin
 c:=a; a:=b; b:=c;
end;

procedure QSort(L,R:integer);
var
 x,i,j:integer;
begin
 x:=A[RandomRange(L,R)];
 i:=L; j:=R;
 repeat
  while a[i]<x do inc(i);
  while a[j]>x do dec(j);
  if i<=j then begin
   Swap(a[i], a[j]);
   Swap(p[i], p[j]);
   f[p[i]]:=j; f[p[j]]:=i;
   inc(i); dec(j);
  end;
 until i>j;
 if i<R then QSort(i,R);
 if L<j then QSort(L,j);
end;

begin
 randomize;

 assign(input, 'code.in'); reset(input);
 assign(output, 'code.out'); rewrite(output);

 readln(n);
 for i:=1 to n do begin
  read(a[i]);
  p[i]:=i;
  b[i]:=a[i];
 end;

 QSort(1,n);
 fillchar(u, sizeof(u), 0);
 u[0]:=1; u[n+1]:=1;

 for i:=n downto 1 do begin
  k:=p[i];
  u[k]:=1;
  if (u[k-1] = 1) and (u[k+1]=1) then continue;

  if (u[k-1] = 1) then begin
   s[k]:=s[k]+'0';
   j:=k+1;
   while (u[j]<>1) do begin
    s[j]:=s[j]+'1';
    inc(j);
   end;
   continue;
  end;

  if (u[k+1] = 1) then begin
   s[k]:=s[k]+'1';
   j:=k-1;
   while (u[j]<>1) do begin
    s[j]:=s[j]+'0';
    dec(j);
   end;
   continue;
  end;


  sum1:=0; sum2:=0;
  j:=k-1;
  while u[j]<>1 do begin
   inc(sum1, b[j]);
   dec(j);
  end;
  j:=k+1;
  while u[j]<>1 do begin
   inc(sum2, b[j]);
   inc(j);
  end;

  if sum1>sum2 then begin
   j:=k-1;
   while u[j]<>1 do begin
    s[j]:=s[j]+'0';
    dec(j);
   end;
   s[k]:=s[k]+'10';
   j:=k+1;
   while u[j]<>1 do begin
    s[j]:=s[j]+'11';
    inc(j);
   end;
  end else begin
   j:=k-1;
   while u[j]<>1 do begin
    s[j]:=s[j]+'00';
    dec(j);
   end;
   s[k]:=s[k]+'01';
   j:=k+1;
   while u[j]<>1 do begin
    s[j]:=s[j]+'1';
    inc(j);
   end;
  end;
 end;

 for i:=1 to n do writeln(s[i]);
end.
