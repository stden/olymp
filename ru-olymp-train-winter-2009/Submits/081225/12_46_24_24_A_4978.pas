var s:array[1..3000000]of char;
    k:array[1..3000000]of char;
    n,i,j,l,r,kol1,kol0:longint;
function palind(l,r:longint):boolean;
begin
 for i:= 0 to (r-l) div 2 do if s[l+i]<>s[r-i] then begin palind:=false; exit; end;
 palind:=true;
end;

begin
 assign(input,'palind.in');
 assign(output,'palind.out');
 reset(input); rewrite(output);
 n:=0;
 while not eoln(input) do begin inc(n); read(s[n]); end;
 if palind(1,n) then begin
  writeln(1);
  for i:=1 to n do write(s[i]);
 end
 else begin
  kol1:=0;
  kol0:=0;
  for i:=1 to n do if s[i]='1' then inc(kol1) else inc(kol0);
  writeln(2);
  for i:=1 to kol0 do write('0');
  writeln;
  for i:=1 to kol1 do write('1');
 end;
 close(input); close(output);
end.