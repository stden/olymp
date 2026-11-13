program Za;

{$mode objfpc}{$H+,D+,i+,l+,Q+,R+,S+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type integer=longint;
var i,kol1,kol2,x,y:integer;
    j,t,l,r:integer;
    a,kol11,kol12,kol13,kol21,kol22,kol23:array[0..14]of integer;
function ans(n:integer):integer;
var j,z,k,i,xx:integer;
begin
     result:=0;
     if n=0 then exit;
     j:=1;
     z:=1;
     while n>0 do begin
           k:=5;
           if z=2 then k:=7;
           for i:=1 to k do begin
                if a[i]=1 then x:=kol13[13-j+1]
                          else x:=kol23[13-j+1];
                if x>n then begin
                   inc(j);
                   if j=14 then exit;
                   z:=a[i];
                   break;
                end else begin
                    if a[i]=1 then xx:=kol11[13-j+1]+2*kol12[13-j+1]
                              else xx:=kol21[13-j+1]+2*kol22[13-j+1];
                    inc(result,xx);
                    dec(n,x);
                    if n=0 then break;
                end;
           end;
     end;
end;
begin
     assign(input,'digitsum.in');
     reset(input);
     assign(output,'digitsum.out');
     rewrite(output);
     kol11[1]:=1;
     kol12[1]:=0;
     kol13[1]:=1;
     a[1]:=1;
     a[2]:=1;
     a[3]:=2;
     a[4]:=1;
     a[5]:=2;
     a[6]:=1;
     a[7]:=2;
     for j:=2 to 13 do begin
         kol11[j]:=kol11[j-1]*3+kol12[j-1]*4;
         kol12[j]:=kol11[j-1]*2+kol12[j-1]*3;
         kol13[j]:=kol11[j]+kol12[j];
     end;
     kol21[1]:=0;
     kol22[1]:=1;
     kol23[1]:=1;
     for j:=2 to 13 do begin
         kol21[j]:=kol21[j-1]*3+kol22[j-1]*4;
         kol22[j]:=kol21[j-1]*2+kol22[j-1]*3;
         kol23[j]:=kol21[j]+kol22[j];
     end;
     readln(t);
     for i:=1 to t do begin
         readln(l,r);
         writeln(ans(r)-ans(l-1));
     end;
end.

