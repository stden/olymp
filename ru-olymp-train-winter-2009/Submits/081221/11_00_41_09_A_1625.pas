program Za;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math;
type integer=longint;
const inf=maxint div 2;
var n,k,v,ansG,m,i,j,x,y,z:integer;
    ans,c,s:array[0..51,0..8]of integer;
    skid:array[0..51,0..8,0..51]of integer;
    a:array[0..51,0..51]of integer;
    l,b:array[0..10]of integer;
procedure calc;
var i,j,h,xx,x:integer;
begin
   for i:=1 to n do
       for j:=0 to k do ans[i,j]:=inf;
   for i:=1 to n do
       for j:=0 to k do
           for h:=0 to n do skid[i,j,k]:=0;
   ans[v,0]:=0;
   for j:=1 to k do begin
       for i:=1 to n do if c[i,l[j]]<>0 then begin
           xx:=0;
           for h:=1 to n do if (ans[h,j-1]<>inf)and(a[h,i]<>inf) then begin
               x:=ans[h,j-1]+a[h,i]+(c[i,l[j]])*(100-skid[h,j-1,i]);
               if x<ans[i,j] then begin
                  ans[i,j]:=x;
                  xx:=h;
               end;
           end;
           if xx<>0 then begin
              for h:=1 to n do skid[i,j,h]:=skid[xx,j-1,h];
              inc(skid[i,j,i],s[i,l[j]]);
           end;
       end;
   end;
   for i:=1 to n do inc(ans[i,k],a[i,v]);
   for i:=1 to n do ansG:=min(ansG,ans[i,k]);
end;
procedure bct(kk:integer);
var i:integer;
begin
     if kk=k+1 then begin
        calc;
     end else begin
         for i:=1 to k do if b[i]=0 then begin
             b[i]:=1;
             l[kk]:=i;
             bct(kk+1);
             l[kk]:=0;
             b[i]:=0;
         end;
     end;
end;
begin
     assign(input,'armor.in');
     assign(output,'armor.out');
     reset(input);
     rewrite(output);
     readln(n,m,k,v);
     for i:=1 to n do begin
         for j:=1 to k do begin
             read(c[i,j],s[i,j]);
             c[i,j]:=c[i,j] div 100;
         end;
         readln;
     end;
     for i:=1 to n do
         for j:=1 to n do
             if i<>j then a[i,j]:=inf
                     else a[i,j]:=0;

     for i:=1 to m do begin
         readln(x,y,z);
         a[x,y]:=min(a[x,y],z);
         a[y,x]:=min(a[y,x],z);
     end;
     for k:=1 to n do
         for i:=1 to n do
             for j:=1 to n do
                 if a[i,j]>a[i,k]+a[k,j] then
                    a[i,j]:=a[i,k]+a[k,j];
     for i:=1 to k do b[i]:=0;
     ansG:=inf;
     bct(1);
     if ansG=inf then ansG:=-1;
     writeln(ansG);
end.

