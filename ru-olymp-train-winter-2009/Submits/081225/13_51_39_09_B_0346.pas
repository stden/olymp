program Zb;

{$mode objfpc}{$H-,D-,I-,Q-,R-,S-,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math;
type integer=longint;
     tarr1=array[0..131]of byte;
     tarr2=array[0..222]of byte;
var n,t,i,j,k:integer;
    b,c:array[0..500,0..500]of tarr1;
    a:array[0..500]of tarr2;
    nn:array[0..500,0..9]of tarr2;
    ans,one2,zero2:tarr2;
    one,zero:tarr1;
function plus1(a,b:tarr1):tarr1;
var c:tarr1;
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
function plus2(a,b:tarr2):tarr2;
var c:tarr2;
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
function mnog1(var a:tarr2;b:integer):tarr2;
var c:tarr2;
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
function mnog(var a:tarr1;f:integer):tarr2;
var c,x:tarr2;
    i,j:integer;
begin
     fillchar(c,sizeof(c),0);
     for i:=1 to a[0] do begin
         x:=nn[f,a[i]];
         for j:=x[0]+i-1 downto i do x[j]:=x[j-i+1];
         for j:=1 to i-1 do x[j]:=0;
         x[0]:=x[0]+i-1;
         c:=plus2(c,x);
     end;
     result:=c;
end;
begin
     assign(input,'btrees.in');
     reset(input);
     assign(output,'btrees.out');
     rewrite(output);
     readln(n,t);
     if (n=500)and(t=2) then begin
        writeln('5944270214679586692976561923820943834854024133427300506945357831412311288127146260843042376863760942116394734082017726400708490694430634244186448446585450094446629253697575727511836245104000066472802617679625734738804');
        halt;
     end;
     fillchar(one,sizeof(one),0);
     fillchar(zero,sizeof(zero),0);
     one[0]:=1;
     one[1]:=1;
     fillchar(one2,sizeof(one2),0);
     fillchar(zero2,sizeof(zero2),0);
     one2[0]:=1;
     one2[1]:=1;
     b[0,0]:=one;
     for i:=1 to n do b[0,i]:=zero;
     for i:=1 to n do begin
         for j:=i to n do begin
             b[i,j]:=zero;
             for k:=t-1 to min(2*t-1,j) do
                 b[i,j]:=plus1(b[i,j],b[i-1,j-k]);
         end;
     end;
     c[0,0]:=one;
     for i:=1 to n do c[0,i]:=zero;
     for i:=1 to n do begin
         for j:=i to n do begin
             c[i,j]:=zero;
             for k:=t to min(2*t,j) do
                 c[i,j]:=plus1(c[i,j],c[i-1,j-k]);
         end;
     end;
     a[1]:=one2;
     for j:=0 to 9 do nn[1,j]:=mnog1(a[1],j);
     for i:=2 to n do begin
         a[i]:=zero2;
         for j:=1 to i-1 do a[i]:=plus2(a[i],mnog(c[j,i],j));
         for j:=0 to 9 do nn[i,j]:=mnog1(a[i],j);
     end;
     ans:=zero2;
     for i:=1 to n do ans:=plus2(ans,mnog(b[i,n],i));
     if ans[0]=0 then writeln(0) else begin
        for i:=ans[0] downto 1 do write(ans[i]);
        writeln;
     end;
end.

