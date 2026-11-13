{$Q+,R+,S+,I+}
const
        inf=1000000000;
        maxn=50;
        maxk=7;
        AddItem:array[1..maxk+1]of integer=(1,2,4,8,16,32,64,128);
type integer=longint;
var
        a:array[1..maxn,1..maxn]of integer;
        Price,Disco:array[1..maxn,1..maxk]of integer;
        Alldisco:array[1..maxn,-1..255]of integer;
        d,Tek:array[-1..255]of integer;
        use:array[-1..255]of boolean;
        n,m,k,v,i,j,l:integer;
        v1,v2,w:integer;
        nn,min:integer;
begin
        assign(input,'armor.in');
        reseT(input);
        assign(output,'armor.out');
        rewrite(output);
        read(n,m,k,v);
        for i:=1 to n do
                for j:=1 to k do begin
                        read(price[i,j],disco[i,j]);
                        if price[i,j]=0 then price[i,j]:=inf;
                end;
        for i:=1 to n do
                for j:=1 to n do
                        a[i,j]:=inf;
        for i:=1 to n do a[i,i]:=0;
        for i:=1 to m do begin
                read(v1,v2,w);
                if a[v1,v2]>w then begin
                        a[v1,v2]:=w;
                        a[v2,v1]:=w;
                end;
        end;
        for l:=1 to n do
                for i:=1 to n do
                        for j:=1 to n do
                                if a[i,j]>a[i,l]+a[l,j]then a[i,j]:=a[i,l]+a[l,j];
        nn:=AddItem[k+1]-1;
        for i:=1 to nn do begin
            d[i]:=inf;
            use[i]:=false;
        end;
        d[0]:=0;
        tek[0]:=v;
        d[-1]:=inf;
        for i:=1 to nn do begin
                min:=-1;
                for j:=0 to nn do
                        if (not use[j])and(d[j]<d[min])then min:=j;
                for l:=1 to n do begin
                        for j:=1 to k do
                                if d[min or Additem[j]]>
                                        d[min]+a[tek[min],l]+
                                        (Price[l,j]div 100*(100-AllDisco[l,min]))then
                                begin
                                        //AllDisco[min or AddItem[j]]:=AllDisco[min];
                                        AllDisco[l,min or AddItem[j]]:=AllDisco[l,min]+Disco[l,j];
                                        D[min or AddItem[j]]:=
                                                d[min]+a[tek[min],l]+
                                                (Price[l,j]div 100*(100-AllDisco[l,min]));
                                        Tek[min or AddItem[j]]:=l;
                                end;
                end;
                use[min]:=true;

        end;
        if (d[nn]+a[tek[nn],v]>=inf)or(tek[nn]=0) then
                write(-1)
        else
                write(d[nn]+a[tek[nn],v]);
end.
