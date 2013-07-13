var s:array[1..3000000]of char;
    k:array[1..3000000]of boolean;
    n,i,j,l,r,kol1,kol0:longint;
function palind(l,r:longint):boolean;
begin
 for i:= 0 to (r-l) div 2 do if s[l+i]<>s[r-i] then begin palind:=false; exit; end;
 palind:=true;
end;

begin
 fillchar(k,sizeof(k),true);
 assign(input,'palin.in');
 assign(output,'palin.out');
 reset(input); rewrite(output);
 n:=0;
 while not eoln(input) do begin inc(n); read(s[n]); end;
 if palind(1,n) then begin
  writeln(1);
  for i:=1 to n do write(s[i]);
 end
 else begin
  writeln(2);
  i:=1;
  j:=n;
  kol0:=0;
  while i<j do begin
   if s[i]=s[j] then begin inc(i); dec(j); end
   else if s[i]='0' then begin k[i]:=false; inc(i); inc(kol0); end
   else if s[j]='0' then begin k[j]:=false; dec(j); inc(kol0); end;
  end;
  for i:=1 to kol0 do write('0');
  writeln;
  for i:=1 to n do if k[i] then write(s[i]);
 end;
 close(input); close(output);
end.
