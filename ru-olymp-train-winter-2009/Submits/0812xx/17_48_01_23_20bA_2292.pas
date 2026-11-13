{$h+}
uses SysUtils;
type
    int32=longint;
    bool=boolean;

var
   j,i:int32;

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
         if (b[0]>a[0]) then srav:=1
            else
         if a[0]=b[0] then
         begin
              i:=a[0];
              while (a[i]=b[i])and(i<=a[0]) do i:=i-1;
                    if b[i]>a[i] then srav:=1
                                 else srav:=0;
         end
            else srav:=0;
    end;

    procedure readlong_(x:int32; var a:array of int32);
    var
        s:string;
        l,i:int32;
    begin
         s:=inttostr(x);
         l:=length(s); a[0]:=0;
         for i:=1 to l do
         begin
             a[0]:=a[0]+1;
             a[i]:=byte(s[l-i+1])-48;
         end;
    end;

    procedure run{(x,y:int32)};
    var
        a,b,c:array [0..1000] of int32;
        p,i:int32;
    begin
        fillchar(a,sizeof(a),0);
        fillchar(b,sizeof(b),0);
        readlong({x,}a);
        readlong({y,}b);
        p:=srav(a,b);
        if p=1 then
         begin
              write('-');
              c:=a;
              a:=b;
              b:=c;
         end;
        fillchar(c,sizeof(c),0);
        for i:=1 to a[0] do
        begin
         if a[i]>=b[i] then
                           c[i]:=a[i]-b[i]
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
    end;

begin
    assign(input,'aplusminusb.in');
    reset(input);
    assign(output,'aplusminusb.out');
    rewrite(output); {i:=13; j:=0;}
    {for i:=0 to 100 do
        for j:=0 to 100 do
        begin
            write(i,' - ',j,' = ');}
            run{(i,j)};
    {        writeln;
        end;}
end.




