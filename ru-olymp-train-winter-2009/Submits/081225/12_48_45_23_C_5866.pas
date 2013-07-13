type
     int32=longint;
     bool=boolean;
     plist=^tlist;
     tlist=record
         key:int32;
         next:plist;
         prev:plist;
     end;

var
    { a:array [0..200000] of int32;}
     i,u,v,p,n,m,c:int32;
     l:plist;

     procedure add(var l:plist; key:int32);
     var x:plist;
     begin
          new(x);
          x^.key:=key;
          x^.next:=l;
          if l<>nil then l^.prev:=x;
          l:=x;
     end;

     procedure update(var l:plist; u:int32; p:int32);
     var i:int32;
     begin
          while l^.next<>nil do l:=l^.next;
          for i:=1 to u-1 do l:=l^.prev;
          l^.key:=p;
          while l^.prev<>nil do l:=l^.prev;
     end;

     procedure insert(var l:plist; u:int32; p:int32);
     var i:int32;
         x:plist;
     begin
          while l^.next<>nil do l:=l^.next;
          for i:=1 to u-1 do l:=l^.prev;
          new(x);
          x^.key:=p;
          x^.next:=l;
          if l^.prev<>nil then
          begin
             x^.prev:=l^.prev;
             l^.prev^.next:=x;
          end;
          l^.prev:=x;
          {l^.prev^.next:=x;}
          {for i:=1 to u-1 do l:=l^.prev;}
          while l^.prev<>nil do l:=l^.prev;
     end;

     procedure less(l:plist; u:int32; v:int32; p:int32);
     var i,k:int32;
     begin
          k:=0;
          while l^.next<>nil do l:=l^.next;
          for i:=1 to u-1 do l:=l^.prev;
          for i:=1 to v-u do
          begin
               if l^.key<=p then k:=k+1;
               l:=l^.prev;
          end;
          if l^.key<=p then k:=k+1;
          writeln(k);
     end;


begin
     assign(input,'dynarray.in');
     reset(input);
     assign(output,'dynarray.out');
     rewrite(output);
     readln(n,m); l:=nil;
     {for i:=1 to n do
         read(a[i]);
     for i:=n downto 1 do
         add(l,a[i]);}
     for i:=1 to n do
     begin
         read(c);
         add(l,c);
     end;
     for i:=1 to m do
     begin
          read(c);
          if c=1 then
          begin
               readln(u,p);
               update(l,u,p);
          end;
          if c=2 then
          begin
               readln(u,p);
               insert(l,u,p);
          end;
          if c=3 then
          begin
               readln(u,v,p);
               less(l,u,v,p);
          end;
     end;
end.

