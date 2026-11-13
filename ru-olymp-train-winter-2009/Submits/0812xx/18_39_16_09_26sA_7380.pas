program ZZa;

{$mode objfpc}{$H+,D+,I+,L+,Q+,R+,S+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
const eps=1e-8;
type integer=longint;
var i,j,k,n,ii,jj:integer;
    a:array[0..50,0..50]of extended;
    b,mi,mj:array[0..50]of integer;
    mx:extended;
    bol:boolean;
    x,a1:array[0..50]of extended;
begin
     assign(input,'linear.in');
     reset(input);
     assign(output,'linear.out');
     rewrite(output);
     readln(n);
     for i:=1 to n do begin
         for j:=1 to n+1 do read(a[i,j]);
         readln;
     end;
     fillchar(b,sizeof(b),0);
     for i:=1 to n-1 do begin
         mx:=-1;
         for j:=1 to n do if b[j]=0 then
             for k:=1 to n do if (abs(a[j,k])>mx) then begin
                 mx:=abs(a[j,k]);
                 mi[i]:=j;
                 mj[i]:=k;
             end;
         b[mi[i]]:=1;
         for ii:=1 to n do begin
           bol:=true;
           for jj:=1 to n do if abs(a[ii,jj])>eps then bol:=false;
           if (bol)and(abs(a[ii,n+1])>=eps) then begin
              writeln('impossible');
              halt;
           end;
         end;
         for ii:=1 to n do begin
         bol:=true;
           for jj:=1 to n do if abs(a[ii,jj])>eps then bol:=false;
             if (bol)and(abs(a[ii,n+1])<eps) then begin
                writeln('infinity');
                halt;
             end;
         end;
         for j:=1 to n+1 do if j<>mj[i] then a[mi[i],j]:=a[mi[i],j]/a[mi[i],mj[i]];
         a[mi[i],mj[i]]:=1;
         for j:=1 to n do if b[j]=0 then begin
             for k:=1 to n+1 do begin
                 a1[k]:=a[j,k]-a[j,mj[i]]*a[mi[i],k];
                 if abs(a1[k])<eps then a1[k]:=0;
             end;
             for k:=1 to n+1 do begin
                 a[j,k]:=a1[k];
             end;
         end;
     end;
     for ii:=1 to n do begin
           bol:=true;
           for jj:=1 to n do if abs(a[ii,jj])>eps then bol:=false;
           if (bol)and(abs(a[ii,n+1])>=eps) then begin
              writeln('impossible');
              halt;
           end;
         end;
         for ii:=1 to n do begin
         bol:=true;
           for jj:=1 to n do if abs(a[ii,jj])>eps then bol:=false;
             if (bol)and(abs(a[ii,n+1])<eps) then begin
                writeln('infinity');
                halt;
             end;
         end;
     for i:=1 to n do if b[i]=0 then begin
         for j:=1 to n do if abs(a[i,j])>eps then begin
             mi[n]:=i;
             mj[n]:=j;
         end;
     end;
     writeln('single');
     for i:=n downto 1 do begin
         for j:=1 to n+1 do if j<>mj[i] then a[mi[i],j]:=a[mi[i],j]/a[mi[i],mj[i]];
         a[mi[i],mj[i]]:=1;
         x[mj[i]]:=a[mi[i],n+1];
         for j:=1 to n do if j<>mi[i] then begin
             for k:=1 to n+1 do begin
                 a1[k]:=a[j,k]-a[j,mj[i]]*a[mi[i],k];
                 if abs(a1[k])<eps then a1[k]:=0;
             end;
             for k:=1 to n+1 do begin
                 a[j,k]:=a1[k];
             end;
         end;
     end;
     for i:=1 to n do write(x[i]:0:15,' ');
end.

