type qq=array[1..50] of integer;
var a:array[1..50,1..50] of byte;
    c:array[1..50] of byte;
    stm:array[1..50,1..7] of integer;
    sk:array[1..50,1..7] of integer;
    std:array[1..500,1..500] of longint;
    stpr:array[1..50] of int64;
    p:array[1..50] of byte;
    skg:array[1..50] of integer;
    i,j,n,m,k,v,l,v1,v2,ch,u,upr,z,skpr,yk,spob,q:integer;
    s,sts,r:longint;
    bu:text;

procedure fpo(x:integer);
var i:integer;
begin
   c[x]:=1;
   for i:=1 to n do
     if (a[x,i]=1) and (c[i]=0) then fpo(i);
end;

procedure fpo2(x:integer);
var i:integer;
begin
  { c[x]:=1;   }
   p[x]:=1;
   for i:=1 to n do
   if (a[x,i]=1) and (c[i]=1) and (i<>u) and (i<>x) and (p[i]=0)then begin
      stpr[i]:=stpr[x]+std[x,i];
      fpo2(i);
      {stpr[i]:=stpr[i]-std[x,i]; }
   end;
end;


begin
   assign(bu,'armor.in');
   reset(bu);
   readln(bu,n,m,k,v);
   for i:=1 to n do begin
      for j:=1 to k do
         read(bu,stm[i,j],sk[i,j]);
      readln(bu);
   end;
   for i:=1 to m do begin
       readln(bu,v1,v2,r);
       if std[v1,v2]<>0 then
          if r<std[v1,v2] then begin
               std[v1,v2]:=r;
               std[v2,v1]:=r;
               continue;
          end
          else continue;
       std[v1,v2]:=r;
       std[v2,v1]:=r;
       a[v2,v1]:=1;
       a[v1,v2]:=1;
   end;
   close(bu);

   for i:=1 to m do
                a[i,i]:=1;

   fpo(v);

   ch:=0;
   for i:=1 to n do
       for j:=1 to k do
          if (stm[i,j]<>0) and (c[i]<>0)
               then p[j]:=1;

   for i:=1 to k do
      if p[i]=1 then inc(ch);

   if ch<k then begin
     assign(bu,'armor.out');
     rewrite(bu);
     write(bu,'-1');
     close(bu);
     halt;
   end;

   u:=v; upr:=v;yk:=1;


   for z:=1 to k do begin
     { for i:=1 to n do
          if (stm[i,z]<>0) and
             (stm[i,z]<=stm[i,u]) and
                (c[i]<>0) then begin     }
                       sts:=10000000000;
                       for j:=1 to n do
                         stpr[j]:=0;
                         for i:=1 to n do
                            p[i]:=0;
                       fpo2(u);
                        for j:=1 to n do {begin}
                            if ((stpr[j]+stm[j,z])<sts) and
                               (stm[j,z]<>0) and (c[j]=1) then  begin
                               ch:=j;
                              { upr:=u;
                               u:=j;}
                               sts:=stpr[j]+stm[j,z];
                            end;

                            if (stm[u,z]=sts) then ch:=u;

                            upr:=u;
                            u:=ch;

                        spob:=0;

                        if skg[u]=0 then begin
                          s:=s+stpr[u]+stm[u,z];
                          skpr:=0;
                        end
                        else
                        if u<>upr then begin
                          s:=s+stpr[u]+stm[u,z]-((stm[u,z] div 100)*skg[u]);
                          skpr:=skg[u];
                        end
                        else
                           s:=s+stm[u,z]-((stm[u,z] div 100)*skpr);

                {  if (skg[u]<>0) or (u=v) then begin
                        for q:=yk to z do
                            inc(spob,stm[u,q]);
                            if spob<s then begin
                               s:=spob;
                               for q:=yk to z-1 do
                                 inc(skg[u],sk[u,q]);
                               yk:=z+1;
                               upr:=v;
                               continue;
                            end;
                        end;    }

                           skg[u]:=skg[u]+sk[u,z];
                 { end;}
                end;



   assign(bu,'armor.out');
   rewrite(bu);

   write(bu,s);
{   for i:=1 to n do
     write(bu,c[i],' ');
     writeln(bu);
   writeln(bu,n,' ',m,' ',k,' ',v);
   for i:=1 to n do begin
      for j:=1 to k do
        write(bu,stm[i,j],' ');
        writeln(bu);
   end;
   for i:=1 to n do begin
      for j:=1 to k do
        write(bu,sk[i,j],' ');
        writeln(bu);
   end;

   for i:=1 to n do begin
      for j:=1 to n do
        write(bu,std[i,j],' ');
        writeln(bu);
   end;
   for i:=1 to n do begin
       for j:=1 to n do
        write(bu,a[i,j],' ');
        writeln(bu);
   end;    }


   close(bu);

end.