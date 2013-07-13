program Project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes , treeunit;
type integer=longint;
var h,i,nw,n,kl,z,xx,yy,j:integer;
    b,kol,head,next,c,e,r,num,x,y:array[0..200000]of integer;
procedure dfs(v:integer);
var bb:integer;
begin
  inc(h);
  b[v]:=h;
  kol[v]:=1;
  bb:=head[v];
  while bb<>0 do begin
        if (b[e[bb]]=0)and(c[e[bb]]=0) then begin
           dfs(e[bb]);
           kol[v]:=kol[v]+kol[e[bb]];
        end;
        bb:=next[bb];
  end;
end;
procedure dfs1(v:integer);
var bb:integer;
begin
  dec(nw);
  c[v]:=1;
  kol[v]:=0;
  bb:=head[v];
  while bb<>0 do begin
        if c[e[bb]]=0 then begin
           dfs1(e[bb]);
           r[num[bb]]:=1000000;
        end;
        bb:=next[bb];
  end;
end;
procedure dfsdel(v,vv:integer);
var z,i:integer;
begin
     c[vv]:=1;
     dfs1(v);
     c[vv]:=0;
     fillchar(b,sizeof(b),0);
     h:=0;
     dfs(vv);
     for i:=1 to n-1 do if r[i]<>1000000 then begin
         if b[x[i]]<b[y[i]] then z:=kol[y[i]]
                            else z:=kol[x[i]];
         z:=abs(z-(n-z));
         r[i]:=z;
     end;
end;
begin
     init;
     n:=getn;
     kl:=0;
     fillchar(head,sizeof(head),0);
     fillchar(next,sizeof(next),0);
     for i:=1 to n-1 do begin
         x[i]:=getA(i);
         y[i]:=getB(i);
         inc(kl);
         next[kl]:=head[x[i]];
         head[x[i]]:=kl;
         num[kl]:=i;
         e[kl]:=y[i];
         inc(kl);
         next[kl]:=head[y[i]];
         head[y[i]]:=kl;
         num[kl]:=i;
         e[kl]:=x[i];
     end;
     fillchar(b,sizeof(b),0);
     fillchar(c,sizeof(c),0);
     h:=0;
     dfs(1);
     for i:=1 to n-1 do begin
         if b[x[i]]<b[y[i]] then z:=kol[y[i]]
                            else z:=kol[x[i]];
         z:=abs(z-(n-z));
         r[i]:=z;
     end;
     nw:=n;
     for j:=1 to 100 do begin
       xx:=-1;
       for i:=1 to n-1 do if (r[i]<1000000)and((xx=-1)or(r[xx]>r[i])) then xx:=i;
       yy:=query(xx);
       r[xx]:=1000000;
       if yy=0 then begin
          dfsdel(y[xx],x[xx]);
       end else begin
          dfsdel(x[xx],y[xx]);
       end;
       if nw=1 then begin
          for i:=1 to n do if c[i]=0 then begin
              report(i);
              halt;
          end;
       end;
     end;
end.


