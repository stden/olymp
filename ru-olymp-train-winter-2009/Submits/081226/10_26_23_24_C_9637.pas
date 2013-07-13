var s:array[1..100000] of char;
    n,i,j,u:longint;
    bool:boolean;
begin
 assign(input,'next.in');
 assign(output,'next.out');
 reset(input); rewrite(output);
 n:=0;
 while not eoln(input) do begin inc(n); read(s[n]); end;
 i:=n;
 while s[i]='1' do begin s[i]:='0'; dec(i); end;
 s[i]:='1';
 for i:=2 to n do begin
  bool:=true;
  for j:=i to n do begin
   u:=j-i+1;
   if (s[u]='0') and (s[j]='1') then begin bool:=false; break; end;
   if (s[u]='1') and (s[j]='0') then s[j]:='1';
  end;
  if bool then begin
   u:=n;
   while s[u]='1' do begin s[u]:='0'; dec(u); end;
   s[u]:='1';
  end;
 end;
 for i:=1 to n do write(s[i]);
 close(input); close(output);
end.
