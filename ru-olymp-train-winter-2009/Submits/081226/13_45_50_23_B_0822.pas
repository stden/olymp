{$o+}

type
    int32=longint;
    bool=boolean;


var
   u,v:array [0..1000] of int32;
   b,minb:array [0..1000] of bool;
   min,s,i,n,m,q,k,j,kol,mini:int32;

begin
     assign(input,'half.in');
     reset(input);
     assign(output,'half.out');
     rewrite(output);
     readln(n,m); q:=1 shl n;
     for i:=0 to m-1 do
     begin
          readln(u[i],v[i]);
          u[i]:=u[i]-1;
          v[i]:=v[i]-1;
     end;
     min:=maxlongint;
     for s:=0 to q-1 do
     begin
         fillchar(b,sizeof(b),false); k:=0; kol:=0;
         for i:=0 to n-1 do
             if (s and (1 shl i))>0 then
             begin
                  b[i]:=true;
                  k:=k+1;
             end;
         if k=n div 2 then
         begin
              j:=0;
              for j:=0 to m-1 do
                  if b[u[j]]<>b[v[j]] then
                                          kol:=kol+1;
              if kol<min then
              begin
                   min:=kol;
                   mini:=s;
                   minb:=b;
              end;
         end;
     end;
     for i:=0 to n-1 do
         if minb[i]=true then write(i+1,' ');
end.
