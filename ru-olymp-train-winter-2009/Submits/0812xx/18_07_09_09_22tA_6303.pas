program Za;

{$mode objfpc}{$H+,O+,D-,I-,L-,Q-,R-,S-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type integer=longint;
const sh=(1 shl 18)-1;
var f:array[0..1000000]of integer;
    kol:array[0..1000000,0..5]of integer;
    koll:array[0..5]of integer;
    k,n,m,i,z,x,y:integer;
procedure push(v:integer);
var gg,ff,i,j:integer;
begin
     f[v]:=f[v] mod k;
     for i:=0 to k-1 do begin
         koll[i]:=kol[v,i];
     end;
     for i:=0 to k-1 do begin
         kol[v,(i+f[v])mod k]:=koll[i];
     end;
     if v<=sh then begin
        inc(f[2*v],f[v]);
        inc(f[2*v+1],f[v]);
     end;
     f[v]:=0;
end;
procedure add(l,r,v,ll,rr:integer);
var s,i:integer;
begin
     s:=(ll+rr)div 2;
     if f[v]>0 then push(v);
     if (l<=ll)and(r>=rr) then begin
        f[v]:=1;
        push(v);
        exit;
     end;
     if (l>rr)or(r<ll) then exit;
     add(l,r,v*2,ll,s);
     add(l,r,v*2+1,s+1,rr);
     for i:=0 to k-1 do kol[v,i]:=kol[v*2,i]+kol[v*2+1,i];
end;
function get(l,r,v,ll,rr:integer):integer;
var s,i:integer;
begin
     s:=(ll+rr)div 2;
     result:=0;
     if f[v]>0 then push(v);
     if (l<=ll)and(r>=rr) then begin
        for i:=1 to k-1 do inc(result,i*kol[v,i]);
        exit;
     end;
     if (l>rr)or(r<ll) then exit;
     result:=get(l,r,v*2,ll,s)+get(l,r,v*2+1,s+1,rr);
end;
procedure zap(v,ll,rr:integer);
var s:integer;
begin
     s:=(ll+rr)div 2;
     kol[v,0]:=rr-ll+1;
     if v<=sh then begin
        zap(v*2,ll,s);
        zap(v*2+1,s+1,rr);
     end;
end;
begin
     assign(input,'sum.in');
     reset(input);
     assign(output,'sum.out');
     rewrite(output);
     readln(n,k,m);
     fillchar(f,sizeof(f),0);
     fillchar(kol,sizeof(kol),0);
     zap(1,1,sh+1);
     for i:=1 to m do begin
         readln(z,x,y);
         if z=1 then add(x,y,1,1,sh+1)
                else writeln(get(x,y,1,1,sh+1));
     end;
end.

