type
        integer=longint;
const KolN=300;
var
        a:array[1..100000]of integer;
        b:array[1..100000]of integer;
        kol:array[1..100000,0..5]of integer;
        i,f,l,r,n,m,k:integer;
procedure swap(var a,b:integer);
var c:integer;
begin
     c:=a;a:=b;b:=c;
end;
procedure add(l,r:integer);
var
        st,en,i,ll,rr,j:integer;
begin
        if (r-l)<=KolN then begin
           for i:=l to r do begin
               dec(kol[(i-1)div KolN+1,(b[i]+a[(i-1)div KolN+1])mod k]);
               inc(b[i]);
               b[i]:=b[i]mod k;
               inc(kol[(i-1)div KolN+1,(b[i]+a[(i-1)div KolN+1])mod k]);
           end;
           exit;
        end;
        st:=(l+KolN-2) div KolN+1;
        en:=r div KolN;
        for i:=st to en do begin
                inc(a[i]);
                a[i]:=a[i]mod k;
                for j:=k-2 downto 0 do
                    swap(kol[i,j],kol[i,j+1]);
        end;
        ll:=(st-1)*KolN+1;
        rr:=en*KolN;
        for i:=l to ll-1 do begin
                dec(kol[st-1,(b[i]+a[st-1])mod k]);
                inc(b[i]);
                b[i]:=b[i]mod k;
                inc(kol[st-1,(b[i]+a[st-1])mod k]);
        end;
        for i:=rr+1 to r do begin
                dec(kol[en+1,(b[i]+a[en+1])mod k]);
                inc(b[i]);
                b[i]:=b[i]mod k;
                inc(kol[en+1,(b[i]+a[en+1])mod k]);
        end;
end;
procedure get(l,r:integer);
var
   ll,rr,st,en,an,i,j:integer;
begin
        if (r-l+1)<=KolN then begin
        an:=0;
        for i:=l to r do
           an:=an+(b[i]+a[(i-1)div KolN+1])mod K;
           writeln(an);
           exit;
        end;
        st:=(l+KolN-2) div KolN+1;
        en:=r div KolN;
        ll:=(st-1)*KolN+1;
        rr:=en*KolN;
        an:=0;
        for i:=st to en do begin
            for j:=1 to k-1 do
                an:=an+j*kol[i,j];
        end;
        for i:=l to ll-1 do
            inc(an,(b[i]+a[st-1])mod k);
        for i:=rr+1 to r do
            inc(an,(b[i]+a[en+1])mod k);
        writeln(an);
end;
begin
        assign(input,'sum.in');
        assign(output,'sum.out');
        reset(input);
        rewrite(output);
        read(n,k,m);
        for i:=1 to 1000 do kol[i,0]:=KolN;
        for i:=1 to m do begin
                read(f,l,r);
                if f=1 then add(l,r);
                if f=2 then get(l,r);
        end;
end.
