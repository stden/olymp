{$H+}
type Tlong=array[0..10011]of longint;
var a,b,c:Tlong;
procedure ReadLong(var a:Tlong);
var
        s,s1:string;
        i,j,n,k:longint;
begin
        readln(s);
        s1:='';
        n:=length(s);
        k:=(n+3)div 4;
        for i:=1 to 4-((n-1) mod 4+1)do s1:=s1+'0';
        s1:=s1+s;
        for i:=1 to k do
                for j:=1 to 4 do
                        a[k-i+1]:=a[k-i+1]*10+ord(s1[(i-1)*4+j])-ord('0');
        a[0]:=k;
end;
function GT(var a,b:Tlong):boolean;
var i:longint;
begin
  if a[0]>b[0]then begin
    GT:=true;exit;
  end;
  if a[0]<b[0]then begin
    GT:=false;exit;
  end;
  i:=a[0];
  while (a[i]=b[i])and(i<>0)do dec(i);
  if a[i]>=b[i]then GT:=true else GT:=false;
end;
Procedure LongMinusLong(var a,b,c:TLong);
var o,k,i:longint;
begin
        o:=0;
        for i:=1 to a[0] do begin
                c[i]:=-o+a[i]-b[i];
                o:=0;
                if c[i]<0 then begin
                        o:=1;
                        c[i]:=c[i]+10000;
                end;
        end;
        k:=10010;
        while c[k]=0 do
                dec(k);
        c[0]:=k;
end;
procedure WriteLong(var a:Tlong);
var i:integer;
begin
        write(a[a[0]]);
        for i:=a[0]-1 downto 1 do begin
                if a[i]<1000 then write(0);
                if a[i]<100 then write(0);
                if a[i]<10 then write(0);
                write(a[i]);
        end;
end;
begin
        assign(input,'aplusminusb.in');
        reset(input);
        assign(output,'aplusminusb.out');
        rewrite(output);
        Readlong(a);
        Readlong(b);
        if GT(a,b)then begin
                LongMinusLong(a,b,c);
                Writelong(c);
        end else begin
                LongMinusLong(b,a,c);
                Write('-');
                WriteLong(c);
        end;

end.
