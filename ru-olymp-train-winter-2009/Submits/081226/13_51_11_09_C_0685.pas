program Zc;

{$mode objfpc}{$H+,D+,I+,L+,Q+,R+,S+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type integer=longint;
var a:array[0..20000]of integer;
    s:string;
    n,i,j,k0,ii,kk,kl:integer;
begin
     assign(input,'next.in');
     reset(input);
     assign(output,'next.out');
     rewrite(output);
     readln(s);
     n:=length(s);
     for i:=1 to n do a[i]:=ord(s[i])-ord('0');
     for i:=n downto 1 do if a[i]=0 then begin
         a[i]:=1;
         ii:=i-1;
         break;
     end;
     for i:=1 to n do if a[i]<>0 then begin
         k0:=i-1;
         break;
     end;
     if (k0=1)and(ii+1<=n div 2)and(ii=2) then begin
        for i:=ii to n do a[i]:=1;
        for i:=1 to n do write(a[i]);
        writeln;
        halt;
     end;
     kk:=0;
     for i:=ii+2 to n-1 do begin
         inc(kk);
         a[i]:=a[kk];
         if kk=ii+1 then kk:=0;
     end;
     kl:=0;
     for i:=ii downto kk+1 do inc(kl,a[i]);
     if (((kl>=1)and(k0<=n-1-(ii+2)+1))or(kk=ii))and(a[kk+1]=1) then begin
        for i:=n downto 1 do if a[i]=0 then begin
         a[i]:=1;
         for j:=i+1 to n-1 do a[j]:=0;
         if k0=n-1-(i+1)+1 then a[n-1]:=1;
         break;
        end;
     end;
     for i:=1 to n do write(a[i]);
     writeln;
end.

