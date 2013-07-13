type
    int32=longint;
    bool=boolean;

var
    a,b,c,z:array [0..1000] of int32;
    i:int32;

     procedure readlong(var a:array of int32);
     var
       s:string;
       l,i:int32;
     begin
         readln(s);
         l:=length(s); a[0]:=0;
         for i:=1 to l do
         begin
             a[0]:=a[0]+1;
             a[i]:=byte(s[l-i+1])-48;
         end;
     end;

     procedure sum(var a:array of int32; b:array of int32);
     var i,x:int32;
     begin
          for i:=1 to a[0] do
          begin
               a[i+1]:=a[i+1]+((a[i]+b[i]) div 10);
               a[i]:=(a[i]+b[i]) mod 10;
          end;
          if a[a[0]+1]>0 then a[0]:=a[0]+1;
     end;

     procedure multiple(a:array of int32; b:array of int32; var c:array of int32);
     var i,j:int32;
     begin
          c[0]:=a[0]+b[0];
          for i:=1 to a[0] do
              for j:=1 to b[0] do
                  c[i+j-1]:=c[i+j-1]+(a[i]*b[j]);
          for i:=1 to c[0] do
          begin
               c[i+1]:=c[i+1]+(c[i] div 10);
               c[i]:=c[i] mod 10;
          end;
          while (c[0]>1)and(c[c[0]]=0) do c[0]:=c[0]-1;
     end;

     procedure division(a:array of int32; b:int32; var c:array of int32);
     var
        i,x:int32;
        bo:array [1..1000] of bool;
     begin
          i:=a[0]; x:=0;
          fillchar(bo,sizeof(bo),false);
          while x<b do
          begin
               x:=x*10+a[i];
               i:=i-1;
          end;
          while (i>=1) do
          begin
              if x>=b then
              begin
                   c[0]:=c[0]+1;
                   c[c[0]]:=x div 3;
                   x:=x mod 3;
                   bo[i+1]:=true;
                   x:=x*10+a[i];
                   i:=i-1;
              end
                 else
              begin
                   c[0]:=c[0]+1;
                   c[c[0]]:=0;
                   x:=x*10+a[i];
                   i:=i-1;
              end;
          end;
          if x>=b then
          begin
               c[0]:=c[0]+1;
               c[c[0]]:=x div 3;
               x:=x mod 10;
               bo[i+1]:=true;
          end;
          if bo[a[a[0]]]=false then
          begin
               c[0]:=c[0]+1;
               c[c[0]]:=0;
          end;
     end;

begin
     assign(input,'room.in');
     reset(input);
     assign(output,'room.out');
     rewrite(output);
     readlong(a);
     multiple(a,a,b);
     sum(b,a);
     z[0]:=1; z[1]:=1;
     sum(b,z);
     division(b,3,c);
     for i:=1 to c[0] do write(c[i])
end.

