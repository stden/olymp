program Zc;

{$mode objfpc}{$H+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes;
type integer=longint;
var r1,r2:array[0..1000000]of integer;
    a,nado:array[0..100001]of integer;
    sum,ans,ans1:array[0..100001]of int64;
    bc:array[0..100001,0..51]of integer;
    i,n,mt,j,mn:longint;
    s:string;
    tek,kl,rt:int64;
procedure dfs(v:integer);
begin
  if r1[v]+r2[v]=0 then writeln(s) else begin
     if r1[v]<>0 then begin
        s:=s+'0';
        dfs(r1[v]);
        delete(s,length(s),1);
     end;
     if r2[v]<>0 then begin
        s:=s+'1';
        dfs(r2[v]);
        delete(s,length(s),1);
     end;
  end;
end;
procedure bct(a,b:integer);
begin
     if b=1 then exit;
     if a=1 then nado[b]:=0 else
        nado[b]:=1;
     bct(bc[b,a],b-1);
end;
begin
     assign(input,'code.in');
     assign(output,'code.out');
     reset(input);
     rewrite(output);
     readln(n);
     sum[0]:=0;
     a[0]:=0;
     for i:=1 to n do begin
         read(a[i]);
         sum[i]:=sum[i-1]+a[i];
     end;
     fillchar(r1,sizeof(r1),0);
     fillchar(r2,sizeof(r2),0);
     mt:=50;
     for i:=1 to mt do ans[i]:=-1;
     ans[1]:=0;
     for i:=2 to n do begin
         for j:=1 to mt do ans1[j]:=-1;
         for j:=1 to mt do
           if ans[j]<>-1 then begin
              if (ans[j]+sum[i-1]+a[i]<ans1[1])or(ans1[1]=-1) then begin
                 ans1[1]:=ans[j]+sum[i-1]+a[i];
                 bc[i,1]:=j;
              end;
              if j<>mt then
              if (ans[j]+a[i-1]+a[i]*(j+1)<ans1[j+1])or(ans1[j+1]=-1) then begin
                 ans1[j+1]:=ans[j]+a[i-1]+a[i]*(j+1);
                 bc[i,j+1]:=j;
              end;
           end;
         for j:=1 to mt do ans[j]:=ans1[j];
     end;
     rt:=1;
     kl:=1;
     mn:=1;
     for i:=2 to mt do if (ans[i]<>-1)and(ans[i]<ans[mn]) then mn:=i;
     bct(mn,n);
     tek:=1;
     for i:=2 to n do begin
       if nado[i]=0 then begin
          inc(kl);
          r1[kl]:=rt;
          r2[kl]:=kl+1;
          rt:=kl;
          inc(kl);
          tek:=1;
       end else begin
          r1[kl]:=kl+1;
          r2[kl]:=kl+2;
          inc(kl,2);
          inc(tek);
       end;
     end;
     s:='';
     dfs(rt);
end.

