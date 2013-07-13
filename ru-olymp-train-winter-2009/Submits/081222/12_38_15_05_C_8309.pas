type
    integer=longint;
    TLong=array[0..300]of integer;
var a,aDiv3,b,l,c,d,e,f:TLong;
    aMod3,q,i:integer;
function max(a,b:integer):integer;
begin
     if a>b then max:=a else max:=b;
end;
procedure ReadLong(var A:TLong);
var
   s:string;
   i:integer;
begin
    readln(s);
    a[0]:=length(s);
    for i:=1 to a[0]do a[i]:=ord(s[a[0]-i+1])-ord('0');
end;
procedure WriteLong(var A:Tlong);
var i:integer;
begin
     for i:=a[0]downto 1 do write(a[i]);
     writeln;
end;
function LongMod3(var a:TLong):integer;
var b,i:integer;
begin
     for i:=1 to a[0]do b:=b+a[i];
     LongMod3:=b mod 3;
end;
Procedure LongMulLong(var a,b,c:TLong);
var i,j,o:integer;
begin
     o:=0;
     for i:=1 to a[0]do begin
         for j:=1 to b[0]+1 do begin
             c[i+j-1]:=c[i+j-1]+a[i]*b[j]+o;
             o:=c[i+j-1]div 10;
             c[i+j-1]:=c[i+j-1]mod 10;
         end;
         o:=0;
     end;
     i:=a[0]+b[0]+10;
     while c[i]=0 do dec(i);
     c[0]:=i;
end;
procedure LongDivShort(var a:TLong;b:integer;var c:TLong);
var o,i:integer;
begin
     o:=0;
     for i:=a[0] downto 1 do begin
         c[i]:=(10*o+a[i])div b;
         o:=(10*o+a[i])mod b;
     end;
     i:=a[0]+10;
     while c[i]=0 do dec(i);
     c[0]:=i;
end;
Procedure ShortToLong(a:integer;var b:TLong);
begin
     b[0]:=0;
     while a<>0 do begin
           inc(b[0]);
           b[b[0]]:=a mod 10;
           a:=a div 10;
     end;
end;
Procedure LongPlusLong(var a,b,c:TLong);
var i,o:integer;
begin
     o:=0;
     for i:=1 to max(a[0],b[0])+1 do begin
         c[i]:=a[i]+b[i]+o;
         o:=c[i]div 10;
         c[i]:=c[i]mod 10;
     end;
     i:=max(a[0],b[0])+10;
     while c[i]=0 do dec(i);
     c[0]:=i;
end;
begin
     assign(input,'room.in');
     reset(input);
     assign(output,'room.out');
     rewrite(output);
     ReadLong(a);
     LongDivShort(a,3,aDiv3);
     ShortToLong(3,l);
     LongMulLong(aDiv3,l,b);
     ShortToLong(1,l);
     LongPlusLong(l,b,c);
     LongMulLong(c,aDiv3,d);
     aMod3:=LongMod3(a);
     ShortToLong(2,l);
     LongMulLong(aDiv3,l,f);
     For i:=1 to aMod3 do begin
         LongPlusLong(d,f,e);
         d:=e;
     end;
     ShortToLong(aMod3,l);
     LongPlusLong(d,l,e);
     WriteLong(e);
end.
