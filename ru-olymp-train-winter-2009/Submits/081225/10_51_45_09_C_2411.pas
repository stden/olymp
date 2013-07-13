program Zc;

{$mode objfpc}{$H-,D-,L-,I-,Q-,R-,S-,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes;
const k=900;
type integer=longint;
     tarr=array[0..2000]of integer;
var m,ms,ps:array[0..3000]of tarr;
    n,mm,i,kl,aa,x,y,z,w:integer;
    kol,next:array[0..3000]of integer;
procedure Qsort(st,en:integer;var a,b:tarr);
procedure sort(l,r:integer);
var i,j,xx,yy:integer;
begin
     i:=l;
     j:=r;
     xx:=a[(l*7+r*13)div 20];
     repeat
           while (a[i]<xx) do inc(i);
           while (a[j]>xx) do dec(j);
           if i<=j then begin
              yy:=a[i];
              a[i]:=a[j];
              a[j]:=yy;
              yy:=b[i];
              b[i]:=b[j];
              b[j]:=yy;
              inc(i);
              dec(j);
           end;
     until j<i;
     if l<j then
     sort(l,j);
     if i<r then
     sort(i,r);
end;
begin
     sort(st,en);
end;
procedure op1(pos,zn:integer);
var bb,d,h,i,xx:integer;
begin
     bb:=1;
     d:=0;
     while bb<>0 do begin
           if d+kol[bb]<pos then inc(d,kol[bb])
                            else break;
           bb:=next[bb];
     end;
     h:=pos-d;
     m[bb,h]:=zn;
     ms[bb,ps[bb,h]]:=zn;
     for i:=ps[bb,h] to kol[bb]-1 do if ms[bb,i]>ms[bb,i+1] then begin
         xx:=ms[bb,i];
         ms[bb,i]:=ms[bb,i+1];
         ms[bb,i+1]:=xx;
         xx:=ps[bb,i];
         ps[bb,i]:=ps[bb,i+1];
         ps[bb,i+1]:=xx;
     end else break;
     for i:=ps[bb,h]-1 downto 1 do if ms[bb,i]>ms[bb,i+1] then begin
         xx:=ms[bb,i];
         ms[bb,i]:=ms[bb,i+1];
         ms[bb,i+1]:=xx;
         xx:=ps[bb,i];
         ps[bb,i]:=ps[bb,i+1];
         ps[bb,i+1]:=xx;
     end else break;
end;
procedure op2(pos,zn:integer);
var bb,d,h,i,xx:integer;
begin
     bb:=1;
     d:=0;
     while bb<>0 do begin
           if d+kol[bb]<pos then inc(d,kol[bb])
                            else break;
           bb:=next[bb];
     end;
     h:=pos-d;
     h:=h+1;
     inc(kol[bb]);
     for i:=kol[bb] downto h do m[bb,i]:=m[bb,i-1];
     ps[bb,h]:=kol[bb];
     m[bb,h]:=zn;
     ms[bb,ps[bb,h]]:=zn;
     for i:=ps[bb,h]-1 downto 1 do if ms[bb,i]>ms[bb,i+1] then begin
         xx:=ms[bb,i];
         ms[bb,i]:=ms[bb,i+1];
         ms[bb,i+1]:=xx;
         xx:=ps[bb,i];
         ps[bb,i]:=ps[bb,i+1];
         ps[bb,i+1]:=xx;
     end else break;
     if kol[bb]=2*k then begin
        inc(kl);
        next[kl]:=next[bb];
        next[bb]:=kl;
        kol[kl]:=k;
        kol[bb]:=k;
        for i:=k+1 to 2*k do m[kl][i-k]:=m[bb,i];
        fillchar(ms[bb],sizeof(ms[bb]),0);
        for i:=1 to k do begin
            ps[kl,i]:=i;
            ps[bb,i]:=i;
            ms[kl,i]:=m[kl,i];
            ms[bb,i]:=m[bb,i];
        end;
        Qsort(1,k,ms[bb],ps[bb]);
        Qsort(1,k,ms[kl],ps[kl]);
     end;
end;
function op3(l,r,zn:integer):integer;
var bb,d,h,i,xx,ll,rr,h1,h2,s:integer;
begin
     result:=0;
     bb:=1;
     d:=0;
     while bb<>0 do begin
           if d+kol[bb]<l then inc(d,kol[bb])
                            else break;
           bb:=next[bb];
     end;
     h1:=l-d;
     ll:=bb;
     bb:=1;
     d:=0;
     while bb<>0 do begin
           if d+kol[bb]<r then inc(d,kol[bb])
                            else break;
           bb:=next[bb];
     end;
     h2:=r-d;
     rr:=bb;
     if ll=rr then begin
        for i:=h1 to h2 do if m[ll,i]<=zn then inc(result);
        exit;
     end;
     for i:=h1 to kol[ll] do if m[ll,i]<=zn then inc(result);
     for i:=1 to h2 do if m[rr,i]<=zn then inc(result);
     ll:=next[ll];
     bb:=ll;
     while bb<>rr do begin
           l:=1;
           r:=kol[bb];
           while l<r do begin
                 s:=(l+r+1) shr 1;
                 if ms[bb,s]<=zn then l:=s else r:=s-1;
           end;
           if ms[bb,l]>zn then dec(l);
           inc(result,l);
           bb:=next[bb];
     end;
end;
begin
     assign(input,'dynarray.in');
     reset(input);
     assign(output,'dynarray.out');
     rewrite(output);
     readln(n,mm);
     fillchar(m,sizeof(m),0);
     fillchar(ms,sizeof(ms),0);
     fillchar(ps,sizeof(ps),0);
     fillchar(next,sizeof(next),0);
     kl:=1;
     kol[1]:=0;
     for i:=1 to n do begin
         read(aa);
         if kol[kl]=k then begin
            next[kl]:=kl+1;
            inc(kl);
            kol[kl]:=0;
         end;
         inc(kol[kl]);
         m[kl,kol[kl]]:=aa;
         ms[kl,kol[kl]]:=aa;
         ps[kl,kol[kl]]:=kol[kl];
     end;
     for i:=1 to kl do Qsort(1,kol[i],ms[i],ps[i]);
     readln;
     for i:=1 to mm do begin
         read(x);
         case x of
              1:begin
                     readln(y,z);
                     op1(y,z);
                end;
              2:begin
                     readln(y,z);
                     op2(y,z);
                end;
              3:begin
                     readln(y,z,w);
                     writeln(op3(y,z,w));
                end;
         end;
     end;
end.

