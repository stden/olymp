var
  n,m,i,j,u,p,v,fl,kol,k : longint;
  a : array [1..400000] of longint; 
begin
  assign(input,'dynarray.in');
  reset(input);
  assign(output,'dynarray.out');
  rewrite(output);
  read(n,m);
  for i:=1 to n do
    read(a[i]);
  kol:=n;
  for i:=1 to m do
  begin
    read(fl);
    case fl of
      1 :
        begin
          read(u,p); 
          a[u]:=p;
        end;
      2 :
        begin
          read(u,p); 
          for j:=kol+1 downto u+2 do
            a[j]:=a[j-1];
          a[u+1]:=p;
          inc(kol);
        end;
      3 :
        begin
          read(u,v,p);
          k:=0; 
          for j:=u to v do
            if a[j]<=p then inc(k);
          writeln(k); 
        end;
    end; 
  end;
end.