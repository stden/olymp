var
 d:array[-1..40,-1..40] of int64;
 n,i,j,p:integer;
 res:string;
 b:array[1..40] of char;
 s:string;
 k:int64;
begin
 assign(input,'parenth.in'); reset(input);
 assign(output,'parenth.out'); rewrite(output);
 read(n); read(k);
 d[0,0]:=1;
 for i:=1 to 2*n do
  for j:=0 to n do
   if j=0 then
    d[i,j]:=2*d[i-1,j+1]
   else
    d[i,j]:=2*d[i-1,j+1]+d[i-1,j-1];
 p:=0;
 j:=0;
 for i:=2*n downto 1 do begin
  if k<=d[i-1][j+1] then begin
   s:=s+'(';
   inc(p); b[p]:='(';
   inc(j);
  end else begin
   k:=k-d[i-1][j+1];
   if k<=d[i-1][j-1] then begin
    if b[p]='(' then
     s:=s+')'
    else
     s:=s+']';
    dec(p);
    dec(j);
   end else begin
    k:=k-d[i-1][j-1];
    s:=s+'[';
    inc(p); b[p]:='[';
    inc(j);
   end;
  end

 end;
 writeln(s);

 close(input); close(output);
end.
