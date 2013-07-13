type qq=^ss;
     ss=record
        z:longint;
        next:qq;
        end;
var a,b,first,pred,last:qq;
    bu,bu1:text;
    k,m,u,p,i,v,p1,zz,g,j,no:longint;
    s:byte;

begin

     assign(bu,'dynarray.in');
     reset(bu);
     readln(bu,k,m);
     assign(bu1,'dynarray.out');
     rewrite(bu1);
     read(bu,zz);
     New(a);
     a^.z:=zz;
     first:=a;
     for i:=2 to k do
     begin
          pred:=a;
          read(bu,zz);
          New(a);
          a^.z:=zz;
          pred^.next:=a;
     end;
     last:=a;
     {while not eof(bu) do}
     for j:=1 to m do
     begin
          read(bu,s);
          case s of
              1:begin
                     read(bu,u,p);
                     a:=first;
                     for i:=2 to u do
                         a:=a^.next;
                     a^.z:=p;
                end;
              2:begin
                     read(bu,u,p);
                     if u=0 then
                     begin
                          New(a);
                          a^.z:=p;
                          a^.next:=first;
                          first:=a;
                     end;
                     if u=k then
                     begin
                          New(a);
                          a^.z:=p;
                          last^.next:=a;
                          last:=a;
                     end;
                     if (u>0) and (u<k) then
                     begin
                          a:=first;
                          for i:=2 to u do
                              a:=a^.next;
                          pred:=a;
                          New(a);
                          a^.z:=p;
                          a^.next:=pred^.next;
                          pred^.next:=a;
                     end;
                   inc(k);
                end;
              3:begin
                     g:=0;
                     read(bu,u,v,p);
                     a:=first;
                     for i:=2 to u do
                     begin
                          a:=a^.next;
                     end;
                   {  write(bu1,a^.z,' '); }
                     for i:=u to v do
                     begin
                          no:=a^.z;
                          if no<=p then inc(g);
                          a:=a^.next;
                     end;
                    { writeln(bu1,g,' ',a^.z); }
                     writeln(bu1,g);
                end;
           end;
    { a:=first;
     for i:=1 to k do
     begin
          write(bu1,a^.z,' ');
          a:=a^.next;
     end;
     writeln(bu1); }
     end;
     a:=first;
     dispose(a);
     close(bu);
     close(bu1);
end.



