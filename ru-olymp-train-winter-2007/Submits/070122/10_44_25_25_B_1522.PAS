program sh;
const tn='system';
var n,dcnt:longint;
    d,r,c,a,w:array[1..200]of longint;
    wt:array[1..201,0..500]of longint;
    ch:array[1..200,0..200]of longint;

procedure dfs(const v:longint);
var i:longint;
begin
 inc(dcnt);
 d[dcnt]:=v;
 for i:=1 to ch[v,0] do dfs(ch[v,i]);
end;
function max(const a,b:longint):longint;
begin
 if a>b then max:=a else max:=b;
end;
var md,t,tt,i,_suck:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 for i:=1 to n do read(r[i],c[i],a[i],w[i]);
 for i:=1 to n do
  if r[i]<>0 then
   begin
    inc(ch[r[i],0]);
    ch[r[i],ch[r[i],0]]:=i;
   end;
 dfs(1);
 n:=dcnt;
 for _suck:=n downto 1 do
  begin
    md:=d[_suck];
    for i:=1 to ch[md,0] do
    begin
     fillchar(wt[201],sizeof(wt[201]),0);
     for t:=0 to 500 do
      for tt:=0 to t do
       wt[201,t]:=max(wt[201,t],wt[md,tt]+wt[ch[md,i],t-tt]);
     wt[md]:=wt[201];
    end;
    for i:=0 to 500 do wt[md,i]:=wt[md,i]+a[i];
    for i:=0 to 500 do
     if wt[md,i]<c[i] then
     begin
      if i+w[i]<=500 then wt[md,i+w[i]]:=max(wt[md,i+w[i]],wt[md,i]);
      wt[md,i]:=0;
     end;
  end;
  _suck:=0;
  while wt[1,_suck]=0 do  inc(_suck);
  writeln(_suck);
 close(input);close(output);
end.
