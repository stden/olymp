program Zb;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type integer=longint;
var x,y:array[0..1000000]of int64;
    b:array[0..100]of integer;
    aa,bb,cc,head,next,e,f,c,ob:array[0..1000]of int64;
    n,m,kl,i,j,k:integer;
    st2:int64;
procedure sort(l,r:integer);
var i,j,xx,yy:integer;
begin
     i:=l;
     j:=r;
     xx:=x[(l*7+r*13)div 20];
     repeat
           while (x[i]<xx) do inc(i);
           while (x[j]>xx) do dec(j);
           if i<=j then begin
              yy:=x[i];
              x[i]:=x[j];
              x[j]:=yy;
              yy:=y[i];
              y[i]:=y[j];
              y[j]:=yy;
              inc(i);
              dec(j);
           end;
     until j<i;
     if l<j then
     sort(l,j);
     if i<r then
     sort(i,r);
end;
function dfs(v:integer):boolean;
var b1:integer;
begin
     b[v]:=1;
     if v=n then begin
        result:=true;
        exit;
     end;
     b1:=head[v];
     while b1<>0 do begin
           if (b[e[b1]]=0)and(c[b1]-f[b1]>=st2) then
              if dfs(e[b1]) then begin
                 inc(f[b1],st2);
                 dec(f[ob[b1]],st2);
                 result:=true;
                 exit;
              end;
           b1:=next[b1];
     end;
     result:=false;
end;
procedure dfs2(v:integer);
var b1:integer;
begin
     b[v]:=1;
     b1:=head[v];
     while b1<>0 do begin
           if (b[e[b1]]=0)and(c[b1]-f[b1]>0) then
              dfs2(e[b1]);
           b1:=next[b1];
     end;
end;
begin
     assign(input,'cuts.in');
     reset(input);
     assign(output,'cuts.out');
     rewrite(output);
     readln(n,m);
     for i:=1 to m do
         readln(aa[i],bb[i],cc[i]);
     readln(k);
     if k=1 then begin
        kl:=0;
        for i:=1 to m do begin
            inc(kl);
            next[kl]:=head[aa[i]];
            head[aa[i]]:=kl;
            e[kl]:=bb[i];
            f[kl]:=0;
            c[kl]:=cc[i];
            ob[kl]:=kl+1;
            inc(kl);
            next[kl]:=head[bb[i]];
            head[bb[i]]:=kl;
            e[kl]:=aa[i];
            f[kl]:=0;
            c[kl]:=0;
            ob[kl]:=kl-1;
        end;
        st2:=1 shl 60;
        while st2>1 do begin
              st2:=st2 div 2;
              repeat
                    fillchar(b,sizeof(b),0);
              until not(dfs(1));
        end;
        fillchar(b,sizeof(b),0);
        dfs2(1);
        for i:=1 to n do write(1-b[i]);
        writeln;
        halt;
     end;
     for i:=0 to (1 shl (n-2))-1 do begin
         x[i]:=0;
         y[i]:=i;
         for j:=1 to m do begin
             if (aa[j]=1)and(bb[j]=n) then inc(x[i],cc[j]) else
             if (aa[j]=1)and((i shr (bb[j]-2))mod 2=1) then inc(x[i],cc[j]) else
             if (bb[j]=n)and((i shr (aa[j]-2))mod 2=0) then inc(x[i],cc[j]) else
             if (bb[j]=1)or(aa[j]=n) then else
             if ((i shr (aa[j]-2))mod 2=0)and((i shr (bb[j]-2))mod 2=1) then
                inc(x[i],cc[j]);
         end;
     end;
     sort(0,(1 shl (n-2))-1);
     for i:=0 to k-1 do begin
         write(0);
         for j:=0 to n-3 do write((y[i] shr j)mod 2);
         writeln(1);
     end;
end.

