var
 n,i,j,k,f1,f2:longint;
 a:int64;
 d:array[0..50,0..50] of int64;
 s:array[0..50] of longint;
begin
 fillchar(d,sizeof(d),0);
 assign(input,'parenth.in');
 reset(input);
 assign(output,'parenth.out');
 rewrite(output);
 read(n,a);
 n:=2*n;
 d[0,0]:=1;
 for i:=1 to n do begin
  d[0,i]:=0;
 end;
 for i:=1 to n do begin
  for j:=0 to n do begin
   d[i,j]:=2*d[i-1,j+1];
   if j<>0 then
    D[I,J]:=d[i,j]+d[i-1,j-1];
  end;
 end;
 k:=0;
 f1:=0;
 f2:=0;
 s[0]:=5;
 for i:=1 to n do begin
  if a>d[n-i,k+1] then begin
   a:=a-d[n-i,k+1];
  end else begin
   inc(k);
   inc(f1);
   s[i]:=0;
   continue;
  end;
  if f1<>0 then begin
   if a>d[n-i,k-1] then begin
    a:=a-d[n-i,k-1];
   end else begin
    dec(k);
    dec(f1);
    s[i]:=1;
    continue;
   end;
  end;
  if a>d[n-i,k+1] then begin
   a:=a-d[n-i,k+1];
  end else begin
   inc(k);
   inc(f2);
   s[i]:=2;
   continue;
  end;
  dec(k);
  dec(f2);
  s[i]:=3;
 end;
 for i:=1 to n do begin
  case s[i] of
   0:write('(');
   1:write(')');
   2:write('[');
   3:write(']');
  end;
 end;
 close(input);
 close(output);
end.
