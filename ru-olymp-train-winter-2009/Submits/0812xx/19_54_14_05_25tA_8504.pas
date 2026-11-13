{$H+}
var s,ans0,ans1:string;
    l,r,n,i:longint;
begin
     assign(input,'palin.in');
     assign(output,'palin.out');
     reset(input);
     rewrite(output);
     readln(s);
     n:=length(s);
     l:=1;
     r:=n;
     ans0:='';
     ans1:='';
     while l<r do begin
           if (s[l]=s[r])then begin
              ans1:=ans1+s[l];
              inc(l);
              dec(r);
           end;
           if (s[l]='0')and(s[r]='1')then begin
              ans0:=ans0+'0';
              inc(l);
           end;
           if (s[l]='1')and(s[r]='0')then begin
              ans0:=ans0+'0';
              dec(r);
           end;
     end;
     if ans0=''then writeln(1)else begin
          writeln(2);
          writeln(ans0);
     end;
     write(ans1);
     if l=r then write(s[l]);
     for i:=length(ans1)downto 1 do write(ans1[i]);
end.
