program Zc;

{$mode objfpc}{$H+,D+,I+,L+,Q+,R+,S+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type integer=longint;
var i,j,x,bs,jj,ii,kl:integer;
    s,ss:string;
    n,k0,kk:integer;
    a:array[0..20000]of integer;
function prime(s:string):boolean;
var i:integer;
    ss:string;
begin
     result:=false;
     for i:=bs downto 2 do begin
         ss:=copy(s,i,bs-i+1);
         if ss<s then exit;
     end;
     result:=true;
end;
function bl(s:string):boolean;
var ss:string;
    i:integer;
begin
     result:=false;
     for i:=1 to length(s) do
     if s[i]<>'0' then begin
         ss:=copy(s,1,i-1)+'0';
         delete(s,1,i-1);
         if pos(ss,s)<>0 then begin
            result:=false;
            exit;
         end;
         delete(ss,1,1);
         result:=pos(ss,s)<>0;
         exit;
     end;
end;
begin
     assign(input,'next.in');
     reset(input);
     assign(output,'next.out');
     rewrite(output);
     readln(s);
     n:=length(s);
     //s:='0000000001';
     //writeln(s);
     //n:=10;
     for i:=1 to n do a[i]:=ord(s[i])-ord('0');
     //for jj:=1 to 99 do begin
     for i:=n downto 1 do if a[i]=0 then begin
         a[i]:=1;
         ii:=i-1;
         break;
     end;
     for i:=1 to n do if a[i]<>0 then begin
         k0:=i-1;
         break;
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
         break;
        end;
     end;
     for i:=1 to n do write(a[i]);
     writeln;
     //end;
     {bs:=10;
     for i:=0 to (1 shl bs)-1 do begin
         s:='';
         x:=i;
         while x>0 do begin
               s:=s+chr(ord('0')+x mod 2);
               x:=x div 2;
         end;
         for j:=length(s)+1 to bs do s:=s+'0';
         ss:=s;
         for j:=1 to bs do ss[j]:=s[bs-j+1];
         if prime(ss) then writeln(ss);
     end;
     writeln; }
end.

