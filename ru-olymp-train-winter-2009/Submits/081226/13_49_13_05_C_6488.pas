var s:string;
    i,n,q,j,k:integer;
begin
     assign(input,'next.in');
     assign(output,'next.out');
     reset(input);
     rewrite(output);
     readln(s);
     n:=length(s);
     i:=n;
     while s[i]='1'do dec(i);
     for j:=1 to i-1 do write(s[j]);
     if i=n-1 then begin
        write('11');halt;
     end;
     write(1);
     k:=1;
     while s[k]='0' do inc(k);
     q:=1+1;
     for j:=i+1 to n-2 do begin
         write(s[q]);
         q:=q mod (i+1)+1;
     end;
     if q<=k-1 then write('01')else
     write('11');
end.
