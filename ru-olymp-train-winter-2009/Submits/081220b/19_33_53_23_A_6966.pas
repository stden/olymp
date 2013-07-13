const
     maxn=200000;

type
    int32=longint;
    bool=boolean;

var
   a,b,c:array [0..maxn] of int32;
   i,j,l,q,x,z,p:int32;
   s1,s2:string;

   function sr(a,b:array of int32):int32;
   var i,j:int32;
   begin
       if a[0]>b[0] then
       begin
           sr:=1;
           exit;
       end;
       if b[0]>a[0] then
       begin
            sr:=2;
            exit;
       end;
       i:=maxn; j:=maxn;
       while (i>=maxn-a[0])and(a[i]=b[j]) do begin i:=i-1; j:=j-1; end;
       if a[i]<b[j] then sr:=2;
       if b[i]<a[j] then sr:=1;
       if i<maxn-a[0] then sr:=0;
   end;

begin
     assign(input,'aplusminusb.in');
     reset(input);
     assign(output,'aplusminusb.out');
     rewrite(output);
     readln(s1);
     l:=length(s1);
     a[0]:=l;
     q:=0;
     for i:=maxn-l+1 to maxn do
     begin
         q:=q+1;
         a[i]:=byte(s1[q])-48;
     end;
     readln(s2);
     l:=length(s2);
     b[0]:=l;
     q:=0;
     for i:=maxn-l+1 to maxn do
     begin
         q:=q+1;
         b[i]:=byte(s2[q])-48;
     end;
     x:=sr(a,b);
     if x=0 then
     begin
          writeln('0');
          halt(0);
     end;
     if x=2 then
     begin
          write('-');
          c:=a; a:=b; b:=c;
     end;
     fillchar(c,sizeof(c),0);
     i:=maxn; j:=maxn;
     while i>maxn-a[0] do
     begin
        if a[i]>=b[j] then
        begin
             c[0]:=c[0]+1;
             c[i]:=a[i]-b[j];
             i:=i-1;
             j:=j-1;
        end
        else
        begin
             z:=i-1;
             while a[z]=0 do
             begin
                  a[z]:=9;
                  z:=z-1;
             end;
             a[z]:=a[z]-1;
             a[i]:=a[i]+10;
        end;
     end;
     p:=0;
     for i:=50000 to maxn do
         if (p<>0)or(c[i]<>0) then
         begin
              p:=1;
              write(c[i]);
         end;
     close(output);
end.
