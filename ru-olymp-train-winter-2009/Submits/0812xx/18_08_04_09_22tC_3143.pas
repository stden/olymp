program zcfast;

{$mode objfpc}{$H+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
type integer=longint;
     tarr=array[0..100000]of integer;
var s:string;
    n,n1,one,two,three,ans,ans1:tarr;
    i,ost:integer;
function minus1(a:tarr):tarr;
var c:tarr;
    i,j:integer;
begin
     fillchar(c,sizeof(c),0);
     c[0]:=a[0];
     for i:=1 to c[0] do begin
         c[i]:=(a[i]-1);
         if c[i]<0 then begin
            inc(c[i],10);
         end else begin
             for j:=i+1 to c[0] do c[j]:=a[j];
             break;
         end;
     end;
     while (c[0]>0)and(c[c[0]]=0) do begin
           dec(c[0]);
     end;
     result:=c;
end;
function plus(a,b:tarr):tarr;
var c:tarr;
    i,ost:integer;
begin
     fillchar(c,sizeof(c),0);
     c[0]:=max(a[0],b[0]);
     ost:=0;
     for i:=1 to c[0] do begin
         c[i]:=(a[i]+b[i]+ost);
         ost:=c[i] div 10;
         c[i]:=c[i] mod 10;
     end;
     while ost>0 do begin
           inc(c[0]);
           c[c[0]]:=ost mod 10;
           ost:=ost div 10;
     end;
     result:=c;
end;
function mnog1(a:tarr;b:integer):tarr;
var c:tarr;
    i,ost:integer;
begin
     fillchar(c,sizeof(c),0);
     if b=0 then begin
        result:=c;
        exit;
     end;
     c[0]:=a[0];
     ost:=0;
     for i:=1 to c[0] do begin
         c[i]:=(a[i]*b+ost);
         ost:=c[i] div 10;
         c[i]:=c[i] mod 10;
     end;
     while ost>0 do begin
           inc(c[0]);
           c[c[0]]:=ost mod 10;
           ost:=ost div 10;
     end;
     result:=c;
end;
function reverse(a:tarr):tarr;
begin
     result:=a;
     for i:=1 to a[0] do result[a[0]-i+1]:=a[i];
end;
function mnog(a,b:tarr):tarr;
var c,x:tarr;
    i,j:integer;
begin
     fillchar(c,sizeof(c),0);
     if a[0]<b[0] then
       for i:=1 to a[0] do begin
           x:=mnog1(b,a[i]);
           x:=reverse(x);
           inc(x[0],i-1);
           x:=reverse(x);
           c:=plus(c,x);
       end
     else
       for i:=1 to b[0] do begin
           x:=mnog1(a,b[i]);
           x:=reverse(x);
           inc(x[0],i-1);
           x:=reverse(x);
           c:=plus(c,x);
       end;
     result:=c;
end;
function del3(a:tarr):tarr;
var c:tarr;
    i,j:integer;
begin
     fillchar(c,sizeof(c),0);
     for i:=a[0] downto 1 do begin
         inc(c[0]);
         for j:=0 to 9 do if 3*j<=a[i] then c[c[0]]:=j;
         dec(a[i],c[c[0]]*3);
         a[i-1]:=a[i-1]+a[i]*10;
     end;
     result:=c;
     for i:=1 to c[0] do result[c[0]-i+1]:=c[i];
     while (result[0]>0)and(result[result[0]]=0) do begin
           dec(result[0]);
     end;
end;
function ravn(a,b:tarr):boolean;
begin
     result:=true;
     for i:=0 to a[0] do if a[i]<>b[i] then result:=false;
end;
begin
     assign(input,'room.in');
     reset(input);
     assign(output,'room.out');
     rewrite(output);
     readln(s);
     n[0]:=length(s);
     for i:=1 to n[0] do n[i]:=ord(s[n[0]-i+1])-ord('0');
     ost:=0;
     for i:=1 to n[0] do ost:=ost+n[i];
     ost:=ost mod 3;
     for i:=1 to ost do
         n:=minus1(n);
     one[0]:=1;
     one[1]:=1;
     two[0]:=1;
     two[1]:=2;
     three[0]:=1;
     three[1]:=3;
     if ravn(n,one) then begin
        writeln(1);
        halt;
     end;
     if ravn(n,two) then begin
        writeln(2);
        halt;
     end;
     n1:=plus(n,one);
     ans:=del3(mnog(n,n1));
     ans1:=plus(mnog(del3(n),two),one);
     if ost>=1 then ans:=plus(ans,ans1);
     if ost=2 then ans:=plus(ans,ans1);
     for i:=ans[0] downto 1 do write(ans[i]);
     writeln;
end.

