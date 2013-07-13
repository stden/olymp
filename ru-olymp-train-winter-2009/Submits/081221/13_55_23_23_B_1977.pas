uses treeunit;

type
    int32=longint;
    bool=boolean;
    plist=^tlist;
    tlist=record
        key:int32;
        next:plist;
    end;

var
    a,o:array [0..200000] of plist;
    us,b:array [0..200000] of int32;
    r:array [0..200000,0..2] of int32;
    n,i,kol,u,v,minraz,max,st,p1,p2,minp1,minp2,j,q,c,k,nn:int32;
    x,xx:plist;


    procedure insert(var l:plist; key:int32);
    var x:plist;
    begin
         new(x);
         x^.key:=key;
         x^.next:=l;
         l:=x;
    end;

    procedure dfs(k:int32);
    var x:plist;
    begin
         x:=a[k]; us[k]:=1; b[k]:=0;
         kol:=kol+1;
         while x<>nil do
         begin
             if (x^.key<>i)and(us[x^.key]=0) then dfs(x^.key);
             x:=x^.next;
         end;
    end;

begin
    init;
    n:=getN; nn:=n;
    for i:=1 to n-1 do
    begin
         u:=getA(i); v:=getB(i);
         insert(a[u],v); insert(a[v],u);
         r[i,1]:=u; r[i,2]:=v;
    end;
    fillchar(b,sizeof(b),0);
    while n>1 do
    begin
         minraz:=300000; k:=1; i:=1;
         while k<=n do
         begin
              if b[i]=0 then
              begin
                   x:=a[i]; max:=0;
                   while x<>nil do
                   begin
                        st:=x^.key;
                        fillchar(us,sizeof(us),0);
                        kol:=0;
                        dfs(st);
                        if kol>max then
                        begin
                             p1:=i; p2:=st;
                             max:=kol;
                        end;
                        x:=x^.next;
                   end;
                   k:=k+1;
                   if abs(n-max-max)<minraz then
                   begin
                        minp1:=p1; minp2:=p2;
                        minraz:=abs(n-max-max);
                   end;
              end;
              i:=i+1;
         end;

    for j:=1 to nn do
        if (r[j,1]=minp1)and(r[j,2]=minp2) then
        begin
            q:=query(j);
            if q=0 then
            begin
                 x:=a[minp1];
                 if x^.key=minp2 then a[minp1]:=a[minp1]^.next
                                 else
                 begin
                      while (x^.next<>nil)and(x^.next^.key<>minp2) do x:=x^.next;
                      if x^.next<>nil then
                      begin
                           insert(xx,x^.key);
                           x:=x^.next^.next;
                           while x<>nil do
                           begin
                                insert(xx,x^.key);
                                x:=x^.next;
                           end;
                      end;
                      a[minp1]:=xx;
                 end;
                 c:=minp1;
            end
               else
            begin
                 x:=a[minp2];
                 if x^.key=minp1 then
                    a[minp2]:=a[minp2]^.next
                                 else
                 begin
                      while (x^.next<>nil)and(x^.next^.key<>minp1) do
                      begin
                           insert(xx,x^.key);
                           x:=x^.next;
                      end;
                      if x^.next<>nil then
                      begin
                           insert(xx,x^.key);
                           x:=x^.next^.next;
                           while x<>nil do
                           begin
                                insert(xx,x^.key);
                                x:=x^.next;
                           end;
                      end;
                       a[minp2]:=xx;
                 end;
                 c:=minp2;
            end;
            break;
        end
           else
        if (r[j,1]=minp2)and(r[j,2]=minp1) then
        begin
            q:=query(j);
            if q=0 then
            begin
                 x:=a[minp2];
                 if x^.key=minp1 then a[minp2]:=a[minp2]^.next
                                 else
                 begin
                      while (x^.next<>nil)and(x^.next^.key<>minp1) do x:=x^.next;
                      if x^.next<>nil then
                      begin
                           insert(xx,x^.key);
                           x:=x^.next^.next;
                           while x<>nil do
                           begin
                                insert(xx,x^.key);
                                x:=x^.next;
                           end;
                      end;
                      a[minp2]:=xx;
                 end;
                 c:=minp2;
            end
               else
            begin
                 x:=a[minp1];
                 if x^.key=minp2 then a[minp1]:=a[minp1]^.next
                                 else
                 begin
                      while (x^.next<>nil)and(x^.next^.key<>minp2) do x:=x^.next;
                      if x^.next<>nil then
                      begin
                           insert(xx,x^.key);
                           x:=x^.next^.next;
                           while x<>nil do
                           begin
                                insert(xx,x^.key);
                                x:=x^.next;
                           end;
                      end;
                      a[minp1]:=xx;
                 end;
                 c:=minp1;
            end;
            break;
        end;
    fillchar(b,sizeof(b),1);
    fillchar(us,sizeof(us),0); kol:=0; i:=0;
    dfs(c);
    n:=kol;
    end;
    report(c);
end.
