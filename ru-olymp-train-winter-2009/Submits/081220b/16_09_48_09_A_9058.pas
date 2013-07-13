program temp;

{$mode objfpc}{$H+,D+,I+,L+,Q+,R+,S+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math;
type int=longint;
var a,b,c,d:array[0..20000]of int;
    sa,sb:string;
    i:integer;
    bolshe:boolean;
begin
     assign(input,'aplusminusb.in');
     reset(input);
     assign(output,'aplusminusb.out');
     rewrite(output);
     readln(sa);
     readln(sb);
     a[0]:=length(sa);
     for i:=length(sa) downto 1 do a[i]:=ord(sa[i])-ord('0');
     b[0]:=length(sb);
     for i:=length(sb) downto 1 do b[i]:=ord(sb[i])-ord('0');
     bolshe:=b[0]>=a[0];
     if a[0]=b[0] then begin
        for i:=a[0] downto 1 do begin
            if a[i]>b[i] then bolshe:=false;
            if a[i]<b[i] then break;
        end;
     end;
     if bolshe then begin
        d:=a;
        a:=b;
        b:=d;
     end;
     c[0]:=max(a[0],b[0]);
     for i:=1 to c[0] do begin
         c[i]:=a[i]-b[i];
         if c[i]<0 then begin
            dec(a[i+1]);
            inc(c[i],10);
         end;
     end;
     while (c[0]>0)and(c[c[0]]=0) do begin
           dec(c[0]);
     end;
     if c[0]=0 then write(0) else
     if bolshe then begin
        write('-');
     end;
     for i:=c[0] downto 1 do
         write(chr(c[i]+ord('0')));
     writeln;
     close(output);
     close(input);
end.

