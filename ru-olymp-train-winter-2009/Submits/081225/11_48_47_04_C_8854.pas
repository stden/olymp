program dinamyc;

var a:array[1..400000]of longint;
    u,v,p,n,m,i,def,ans:longint;
    k:longint;

begin
 assign(input,'dynarray.in');
 reset(input);
 assign(output,'dynarray.out');
 rewrite(output);

  read(n,m);

  for i:=1 to n do
   read(a[i]);

  for k:=1 to m do
   begin
    read(def);
    case def of
     1:begin
        read(u,p);
        a[u]:=p;
       end;
     2:begin
        read(u,p);
        inc(n);
        for i:=n downto u+2 do
         a[i]:=a[i-1];
        a[u+1]:=p;
       end;
     3:begin
        read(u,v,p);
        ans:=0;
        for i:=u to v do
         if a[i]<=p then
                        inc(ans);
         writeln(ans);
       end;
    end;
  end;

 close(input);
 close(output);
end.