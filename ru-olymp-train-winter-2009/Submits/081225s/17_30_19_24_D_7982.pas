{$Q+, R+, S+}
var a:array[0..18] of longint;
    b:array[0..10000000] of int64;
    n,i,j,k,l,q,w,e:longint;
    s:int64;
begin
 assign(input,'modsum2.in');
 assign(output,'modsum2.out');
 reset(input); rewrite(output);
 readln(n);
 s:=0;
 for i:=0 to n-1 do read(a[i]);
 for i:=0 to (1 shl n) - 1 do begin
  s:=0;
  for j:=0 to n-1 do begin
   if (i and (1 shl j))>0 then s:=s+a[j];
  end;
  b[i]:=s;
 end;
 s:=0;
 for i:=1 to (1 shl n) - 1 do begin
  j:=(1 shl n)-(i+1);
  while j>0 do begin
{   writeln('* ',i,' ',j);}
   if b[j]<>0 then s:=s+b[i] mod b[j];
   j:=(j-1) and (not i);
  end;
 end;
 write(s);
 close(input);
 close(output);
end.
