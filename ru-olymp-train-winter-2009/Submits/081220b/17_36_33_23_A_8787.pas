const
     r=100000;
type
     int32=longint;
     bool=boolean;
var
   a,b,c:array [0..200000] of int32;
   i,j,q,x,z,p:int32;
   ch:char;

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
       i:=r+a[0];
       j:=r+b[0];
       while (i>=1)and(a[i]=b[j]) do begin i:=i-1; j:=j-1; end;
       if a[i]<b[j] then sr:=2;
       if b[i]<a[j] then sr:=1;
       if i<1 then sr:=0;
   end;

begin
    assign(input,'aplusminusb.in');
    reset(input);
    assign(output,'aplusminusb.out');
    rewrite(output);
    i:=0;
    while not eoln do
    begin
        i:=i+1;
        read(ch);
        a[r+i]:=ord(ch)-48;
    end;
    a[0]:=i;
    readln;
    i:=0;
    while not eoln do
    begin
        i:=i+1;
        read(ch);
        b[r+i]:=ord(ch)-48;
    end;
    b[0]:=i;
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
    i:=r+a[0]; j:=r+b[0];
    while i>r do
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
    for i:=1 to r+a[0] do
        if (p<>0)or(c[i]<>0) then
        begin
             p:=1;
             write(c[i]);
        end;
   close(output);
end.
