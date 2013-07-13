{$M 16000000}
const
 MaxN = 262144;
 faq = 262143;
type
 pnode = ^node;
 node = record
         j:longint;
         n:pnode;
        end;

var

 G:array[0..MaxN] of pnode;
 D:array[0..MaxN] of longint;
 u:array[0..MaxN] of boolean;
 q:array[0..MaxN] of longint;
 p:array[0..MaxN] of longint;
 k:array[0..MaxN] of longint;
 i,j,m,n,a,h,t:longint;
 tp:pnode;

 procedure NO;
 begin
  writeln('NO');
  close(input);
  close(output);
  halt(0);
 end;

 procedure addv(i,j:longint);
 var
  tp:pnode;
 begin
  inc(D[i]);
  inc(D[j]);
  new(tp);
  tp^.j:=j;
  tp^.n:=G[i];
  G[i]:=tp;
  new(tp);
  tp^.j:=i;
  tp^.n:=G[j];
  G[j]:=tp;
 end;



begin
 fillchar(D,sizeof(D),0);
 fillchar(u,sizeof(u),0);
 fillchar(P,sizeof(P),255);
 assign(input,'omax.in');
 reset(input);
 assign(output,'omax.out');
 rewrite(output);
 read(n);
 for i:=1 to n do begin
  read(k[i]);
  if k[i]=0 then begin
   NO;
  end;
  for j:=1 to k[i] do begin
   read(a);
   addv(i,a+n);
  end;
 end;
 h:=0;
 t:=0;
 for i:=1 to 2*n do begin
  if D[i]=1 then begin
   Q[t]:=i;
   u[i]:=true;
   t:=(t+1)and faq;
  end;
  if D[i]=0 then NO;
 end;

 m:=0;

 while h<>t do begin
  i:=Q[h];
  h:=(h+1)and faq;
  if (P[i]>0) then continue;
  tp:=G[i];
  while (p[tp^.j]>0)and(tp<>nil) do
   tp:=tp^.n;
  if tp=nil then no;
  p[i]:=tp^.j;
  p[tp^.j]:=i;
  tp:=G[tp^.j];
  while tp<>nil do begin
   if (p[tp^.j] < 0) then begin
    dec(D[tp^.j]);
    if D[tp^.j]=0 then NO;
    if D[tp^.j]=1 then begin
     Q[t]:=tp^.j;
     t:=(t+1)and faq;
    end;
   end;
   tp:=tp^.n;
  end;
  inc(m);
 end;

 if m<>n then NO;

 writeln('YES');

 for i:=1 to n do begin
  write(p[i] - n,' ');
 end;

 close(input);
 close(output);
end.
