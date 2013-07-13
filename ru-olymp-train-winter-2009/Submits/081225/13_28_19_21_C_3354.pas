var a,yk:array[1..400005] of longint;
    n,m,u,p,v,i,j,k,z,ch,y,po:longint;
    bu,bu2:text;
begin
   assign(bu,'dynarray.in');
   reset(bu);
   assign(bu2,'dynarray.out');
   rewrite(bu2);
   readln(bu,n,m);
   for i:=1 to n do
     read(bu,a[i]);

   for i:=1 to n-1 do
      yk[i]:=i+1;
   yk[n]:=0;

   readln(bu);

   for j:=1 to m do begin
       ch:=0;
       po:=0;
       read(bu,z);
          if z=1 then begin
             readln(bu,u,p);
             y:=1;
             for i:=1 to (u-1) do
                 y:=yk[y];
             if u=1 then y:=1;
             a[{u}y]:=p;
             continue;
          end;

          if z=2 then begin
             readln(bu,u,p);
             inc(n);

             y:=1;
             for i:=1 to (u-1) do
                 y:=yk[y];

             if u=n-1 then
                for i:=1 to n do
                   if yk[i]=0 then begin
                       y:=i;
                       break;
                   end;

             if u=1 then y:=1;

             {for i:=1 to n do
                 if yk[i]=(u+1) then break;    }

               a[n]:=p;

               if u=n-1 then yk[n]:=0 else yk[n]:=yk[{i}y];
               yk[{i}y]:=n;


            { if u=n-1 then yk[n]:=0 else yk[n]:=yk[i]; }
             {if u=(n-1) then begin
                    yk[u]:=n;
                    yk[n]:=0;
                    a[n]:=p;
             end
             else begin
               yk[u]:=n;
               yk[n]:=u+1;
               a[n]:=p;
             end;       }
             continue;
          end;

          if z=3 then begin
             readln(bu,u,v,p);

               for i:=1 to n do
                   if yk[i]=u then begin
                       z:=yk[i];
                       break;
                   end;
               {i:=yk[u-1];  }

               i:=z;

               if u=1 then i:=1;

               if u=v then begin
                   if a[i]<=p then inc(ch);
                   writeln(bu2,ch);
                   continue;
               end;

               if v=n then begin
                 while i<>0 do begin
                  if a[i]<=p then inc(ch);
                  i:=yk[{u}i];
                {  inc(u);   }
                 end;
                 writeln(bu2,ch);
                 continue;
               end;


               while i<>v{+1} do begin
                     if a[i]<=p then inc(ch);
                     i:=yk[{u}i];
                     inc(po);
                    { inc(u);}
               end;
               if po<(v-u+1) then
                  if a[i]<=p then inc(ch);
               writeln(bu2,ch);
               continue;
          end;

   end;
   close(bu);
   close(bu2);
end.

