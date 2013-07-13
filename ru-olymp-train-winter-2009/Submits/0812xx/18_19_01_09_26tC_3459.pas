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
     j:=1;
     while j<n do begin
       for i:=n downto j do if s[i]='0' then begin
           s[i]:='1';
           j:=i+1;
           delete(s,i+1,n-i);
           break;
       end;
       while length(s)<n do begin
             s:=s+s;
       end;
       s:=copy(s,1,n);
     end;
     s[n]:='1';
     writeln(s);
end.

