program Zb;

{$mode objfpc}{$H-,D-,I-,L-,Q-,R-,S-,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,SysUtils;
type integer=longint;
var n,tekans,i,ans,ll,rr,m,x,y,nn,j:integer;
    aa,b,l,r:array[0..30]of integer;
    a:array[0..30,0..30]of integer;
    time:extended;
procedure bct(k,o:integer);
var x,i,ta:integer;
begin
     if o=0 then begin
        ta:=tekans;
        for i:=k to n do begin
            for j:=1 to rr do inc(ta,a[i,r[j]]);
        end;
        if ta<ans then begin
           ans:=ta;
           for i:=1 to n do aa[i]:=b[i];
        end;
        exit;
     end;
     if k=n+1 then exit;
     if tekans>=ans then exit;
     b[k]:=1;
     x:=0;
     for i:=1 to ll do inc(x,a[k,l[i]]);
     inc(tekans,x);
     inc(rr);
     r[rr]:=k;
     bct(k+1,o-1);
     dec(tekans,x);
     dec(rr);
     b[k]:=0;
     x:=0;
     for i:=1 to rr do inc(x,a[k,r[i]]);
     inc(tekans,x);
     inc(ll);
     l[ll]:=k;
     bct(k+1,o);
     dec(tekans,x);
     dec(ll);
end;
procedure bct2(k,o:integer);
var x,i,ta:integer;
begin
     if (now-time)*24*3600>5.9 then begin
        for i:=1 to n do if aa[i]=1 then write(i,' ');
        writeln;
        halt;
     end;
     if o=0 then begin
        ta:=tekans;
        for i:=k to n do begin
            for j:=1 to rr do inc(ta,a[i,r[j]]);
        end;
        if ta<ans then begin
           ans:=ta;
           for i:=1 to n do aa[i]:=b[i];
        end;
        exit;
     end;
     if k=n+1 then exit;
     if tekans>=ans then exit;
     b[k]:=1;
     x:=0;
     for i:=1 to ll do inc(x,a[k,l[i]]);
     inc(tekans,x);
     inc(rr);
     r[rr]:=k;
     bct(k+1,o-1);
     dec(tekans,x);
     dec(rr);
     b[k]:=0;
     x:=0;
     for i:=1 to rr do inc(x,a[k,r[i]]);
     inc(tekans,x);
     inc(ll);
     l[ll]:=k;
     bct(k+1,o);
     dec(tekans,x);
     dec(ll);
end;
begin
     time:=now;
     assign(input,'half.in');
     reset(input);
     assign(output,'half.out');
     rewrite(output);
     randomize;
     //readln(n,m);
     n:=30;
     fillchar(a,sizeof(a),0);
     {for i:=1 to m do begin
         readln(x,y);
         a[x,y]:=1;
         a[y,x]:=1;
     end; }
     for i:=1 to n do
         for j:=i+1 to n do begin
             a[i,j]:=random(2);
             a[j,i]:=a[i,j];
         end;
     fillchar(b,sizeof(b),0);
     ans:=0;
     nn:=n div 2;
     for i:=1 to nn do
         for j:=nn+1 to n do inc(ans,a[i,j]);
     for i:=1 to nn do aa[i]:=0;
     for i:=nn+1 to n do aa[i]:=1;
     tekans:=0;
     ll:=0;
     rr:=0;
     fillchar(l,sizeof(l),0);
     fillchar(r,sizeof(r),0);
     if n<28 then
        bct(1,nn)
     else bct2(1,nn);
     for i:=1 to n do if aa[i]=1 then write(i,' ');
     writeln;
end.

