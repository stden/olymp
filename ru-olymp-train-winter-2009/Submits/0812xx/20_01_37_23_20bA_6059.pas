{$+h}
type
    int32=longint;
    bool=boolean;

var
   a,b,c:array [0..100000] of int32;
   p,i:int32;

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

    function srav(var a,b:array of int32):int32;
    var
       p,i:int32;
    begin
         if (b[0]>a[0]) then srav:=1;
         if a[0]=b[0] then
         begin
              i:=1;
              while a[i]=b[i] do i:=i+1;
              if b[i]>a[i] then srav:=1;
         end;
    end;

begin
    assign(input,'aplusminusb.in');
    reset(input);
    assign(output,'aplusminusb.out');
    rewrite(output);
    readlong(a);
    readlong(b);
    p:=srav(a,b);
    if p=1 then
         begin
              write('-');
              c:=a;
              a:=b;
              b:=c;
         end;
    for i:=1 to a[0] do
    begin
         if a[i]>=b[i] then c[i]:=a[i]-b[i]
                       else
         begin
              a[i+1]:=a[i+1]-1;
              a[i]:=a[i]+10;
              c[i]:=a[i]-b[i];
         end;
    end;
    p:=0;
    for i:=a[0] downto 1 do
        if (p=1)or(c[i]<>0)or(i=1) then
        begin
             p:=1;
             write(c[i]);
        end;
end.


