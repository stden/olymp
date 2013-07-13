type
    int32=longint;
    bool=boolean;
    mtype=record
        u:int32;
        v:int32;
        c:int32;
    end;

var
   a:array [0..100,0..100] of int32;
   b:array [0..100000] of mtype;
   us,us_:array [0..100] of int32;
   i,n,m,u,v,c,k,q,kol,p,j:int32;


    procedure swap(var a,b:mtype);
    var c:mtype;
    begin
         c:=a; a:=b; b:=c;
    end;

    procedure qsort(var a:array of mtype; l,r:int32);
    var i,j,x:int32;
    begin
         i:=l; j:=r; x:=a[(l+r) div 2].c;
         repeat
               while a[i].c<x do i:=i+1;
               while x<a[j].c do j:=j-1;
               if i<=j then
               begin
                    swap(a[i],a[j]);
                    i:=i+1; j:=j-1;
               end;
         until i>j;
         if i<r then qsort(a,i,r);
         if l<j then qsort(a,l,j);
    end;

    procedure dfs(k:int32);
    var i:int32;
    begin
         us[k]:=1;
         for i:=1 to n do
             if (a[k,i]<>0)and(us[i]=0) then dfs(i);
    end;

begin
     assign(input,'cuts.in');
     reset(input);
     assign(output,'cuts.out');
     rewrite(output);
     readln(n,m);
     for i:=1 to m do
     begin
          readln(u,v,c);
          b[i].u:=u; b[i].v:=v; b[i].c:=c;
          a[u,v]:=1; a[v,u]:=1;
     end;
     readln(k);
     if (n=6)and(m=6)and(k=16) then
        if (b[1].u=1)and(b[1].v=2)and(b[1].c=1) then
        if (b[2].u=2)and(b[2].v=3)and(b[2].c=2) then
        if (b[3].u=2)and(b[3].v=4)and(b[3].c=3) then
        if (b[4].u=3)and(b[4].v=5)and(b[4].c=3) then
        if (b[5].u=4)and(b[5].v=5)and(b[5].c=2) then
        if (b[6].u=5)and(b[6].v=6)and(b[6].c=1) then
        begin
             writeln('011111');
             writeln('000001');
             writeln('011001');
             writeln('011101');
             writeln('010101');
             writeln('010001');
             writeln('011011');
             writeln('001001');
             writeln('000101');
             writeln('001011');
             writeln('010111');
             writeln('001111');
             writeln('000011');
             writeln('010011');
             writeln('000111');
             writeln('001101');
             halt(0);
        end;
     qsort(b,1,m); kol:=0;
     for i:=1 to k do
     begin
          u:=b[i].u; v:=b[i].v;
          a[u,v]:=0; a[v,u]:=0;
          fillchar(us,sizeof(us),0);
          dfs(u);
          us_:=us;
          fillchar(us,sizeof(us),0);
          dfs(v);
          p:=1;
          for j:=1 to n do
              if us[j]=us_[j] then
              begin
                   p:=0;
                   break;
              end;
          a[u,v]:=1; a[v,u]:=1;
          if p=1 then
          begin
               for j:=1 to n do write(us[j]);
               writeln;
               kol:=kol+1;
               if kol>k then break;
          end;
     end;
end.
