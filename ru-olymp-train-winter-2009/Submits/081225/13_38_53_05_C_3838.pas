var u,v,p,i,j,n,m,kol,fl:longint;
        a:array[1..400000]of longint;
begin
        assign(input,'dynarray.in');
        assign(output,'dynarray.out');
        reset(input);
        rewrite(output);
        read(n,m);
        for i:=1 to n do read(a[i]);
        for i:=1 to m do begin
                read(fl);
                if fl=1 then begin
                        read(u,p);
                        a[u]:=p;
                end;
                if fl=2 then begin
                        read(u,p);
                        for j:=n downto u+1 do
                                a[j+1]:=a[j];
                        a[u+1]:=p;
                        n:=n+1;
                end;
                if fl=3 then begin
                        read(u,v,p);
                        kol:=0;
                        for j:=u to v do
                                if a[j]<=p then
                                        inc(kol);
                        writeln(kol);
                end;
        end;
end.