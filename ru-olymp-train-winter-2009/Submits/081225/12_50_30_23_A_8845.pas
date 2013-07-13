{$q-,r-,i-,o+,s-}
{$h+}

type
    int32=longint;
    bool=boolean;

var
    z,z_:array [0..100000] of string;
    i,sz,sz_,l:int32;
    s:string;

    function palin(s:string):bool;
    var i,l,p:int32;
    begin
         l:=length(s); p:=1;
         for i:=1 to (l div 2) do
             if s[i]<>s[l-i+1] then
             begin
                  p:=0;
                  break;
             end;
         if p=1 then palin:=true
                else palin:=false;
    end;

    function find(s:string; var p:string):int32;
    var
       p1,p2:string;
       k1,k2,l:int32;
    begin
         l:=length(s);
         if palin(s) then
         begin
              p:=s;
              find:=l;
         end
            else
         begin
              p1:=''; p2:='';
              k1:=find(copy(s,2,l-1),p1);
              k2:=find(copy(s,1,l-1),p2);
              if k1>k2 then
              begin
                   p:=p1;
                   find:=k1;
              end
                 else
              begin
                   p:=p2;
                   find:=k2;
              end;
         end;
    end;

    procedure split(s:string);
    var
       p:string;
       x,ps,l:int32;
    begin
        x:=find(s,p);
        sz:=sz+1; ps:=pos(p,s); l:=length(s);
        z[sz]:=p;
        if ps>1 then split(copy(s,1,ps-1));
        if (ps+x-1)<l then split(copy(s,ps+x,l-(ps+x-1)));
    end;

    procedure from_begin(s:string);
    var
        i,l,j:int32;
        c:string;
    begin
         l:=length(s);
         i:=1;
         while i<=l do
         begin
              j:=l;
              while j>=i do
              begin
                   c:=copy(s,i,j-i+1);
                   if palin(c) then
                   begin
                        i:=j+1;
                        sz:=sz+1;
                        z[sz]:=c;
                        j:=0;
                   end;
                   j:=j-1;
              end;
         end;
    end;

    procedure swap(var a,b:string);
    var c:string;
    begin
         c:=a; a:=b; b:=c;
    end;

    procedure qsort(var a:array of string; l,r:int32);
    var i,j:int32;
        x:string;
    begin
         i:=l; j:=r; x:=a[(l+r) div 2];
         repeat
               while a[i]<x do i:=i+1;
               while x<a[j] do j:=j-1;
               if i<=j then
               begin
                    swap(a[i],a[j]);
                    i:=i+1; j:=j-1;
               end;
         until i>j;
         if i<r then qsort(a,i,r);
         if l<j then qsort(a,l,j);
    end;


begin
     assign(input,'palin.in');
     reset(input);
     assign(output,'palin.out');
     rewrite(output);
     readln(s);
     l:=length(s);
     if l<=23 then
     begin
     sz:=0; fillchar(z,sizeof(z),0);
     split(s);
     sz_:=sz; z_:=z;
     sz:=0; fillchar(z,sizeof(z),0);
     from_begin(s);
     qsort(z,1,sz);
     qsort(z_,1,sz_);
     if sz<sz_ then
     begin
          writeln(sz);
          for i:=1 to sz do
              writeln(z[i]);
     end
        else
     if sz_<sz then
     begin
          writeln(sz_);
          for i:=1 to sz_ do
              writeln(z_[i]);
     end
        else
     if sz=sz_ then
     begin
          i:=1;
          while (i<=sz)and(z[i]=z_[i]) do i:=i+1;
          if z[i]<z_[i] then
          begin
              writeln(sz);
              for i:=1 to sz do
                  writeln(z[i]);
          end
             else
          begin
              writeln(sz_);
              for i:=1 to sz_ do
                  writeln(z_[i]);
          end;
     end;
     end
        else
     begin
          sz:=0; fillchar(z,sizeof(z),0);
          from_begin(s);
          qsort(z,1,sz);
          writeln(sz);
          for i:=1 to sz do
              writeln(z[i]);
     end;
end.
