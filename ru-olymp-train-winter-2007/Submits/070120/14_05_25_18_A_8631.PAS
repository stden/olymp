{$M 160000000}
{$H+}
uses
 SysUtils;
type
 tver=record
      next:array['a'..'z']of longint;
      par,p:longint;
      cost:longint;
      ch:char;
      end;
var
 next:array[0..10000,0..100]of longint;
 tab:array[0..10000,0..100]of int64;
 vers:array[0..10000]of tver;
 bch:array[0..10000,0..100]of char;
 cc:array[0..10000]of int64;
 q:array[0..10000]of longint;
 k,n,nver,i,x,be,en,j:longint;
 tt:int64;
 ch:char;
 s:string;

procedure add(s:string;c:longint);
var
 pos,i,j:longint;
 ch:char;
begin
 i:=1;
 pos:=0;
 while (i<>length(s))and(vers[pos].next[s[i]]<>-1)do
  begin
  pos:=vers[pos].next[s[i]];
  i:=i+1;
  end;
 for j:=i to length(s) do
  begin
  nver:=nver+1;
  for ch:='a' to 'z' do
   vers[nver].next[ch]:=-1;
  vers[nver].cost:=0;
  vers[nver].par:=pos;
  vers[nver].ch:=s[j];
  vers[pos].next[s[j]]:=nver;
  pos:=nver;
  end;
 vers[pos].cost:=vers[pos].cost+c;
end;

function dfs(i:longint;deep:longint):int64;
var
 j:longint;
 t,max:int64;
 ch:char;
begin
 if deep=0 then
  begin
  dfs:=cc[i];
  exit;
  end;
 if tab[i,deep]<>-1 then
  begin
  dfs:=tab[i,deep];
  exit;
  end;
 max:=0;
 for ch:='a' to 'z' do
  begin
  j:=i;
  while (j<>0)and(vers[j].next[ch]=-1) do
   j:=vers[j].p;
  if vers[j].next[ch]<>-1 then
   begin
   t:=dfs(vers[j].next[ch],deep-1)+cc[i];
   if t>max then
    begin
    max:=t;
    next[i,deep]:=vers[j].next[ch];
    bch[i,deep]:=ch;
    end;
   end;
  end;
 tab[i,deep]:=max;
 dfs:=max;
end;


begin
 assign(input,'beauty.in');
 assign(output,'beauty.out');
 reset(input);
 rewrite(output);
 readln(k);
 nver:=0;
 vers[0].p:=0;
 vers[0].cost:=0;
 vers[0].par:=0;
{ for i:=0 to 10000 do}
  for ch:='a' to 'z' do
   vers[0].next[ch]:=-1;

 for i:=1 to k do
  begin
  readln(s);
  j:=length(s);
  while s[j] in ['0'..'9'] do
   j:=j-1;
  add(copy(s,1,j-1),StrToInt(copy(s,j+1,length(s)-j)));
//  ss[i]:=copy(s,1,j-1);
  end;
 for i:=0 to nver do
  cc[i]:=0;

 en:=1;
 be:=0;
 q[1]:=0;
 while be<>en do
  begin
  be:=be+1;
  x:=q[be];
  if x<>0 then
   begin
   i:=vers[vers[x].par].p;
   while (i<>0) and (vers[i].next[vers[x].ch]=-1)do
    i:=vers[i].p;
   if (i=0) and ((vers[i].next[vers[x].ch]=-1)or(vers[i].next[vers[x].ch]=x)) then
    vers[x].p:=0
   else
    vers[x].p:=vers[i].next[vers[x].ch];
   end;
  for ch:='a' to 'z' do
   if vers[x].next[ch]<>-1 then
    begin
    en:=en+1;
    q[en]:=vers[x].next[ch];
    end;
  end;

 read(n);
 en:=1;
 be:=0;
 while be<>en do
  begin
  be:=be+1;
  x:=q[be];
  if x<>0 then
   begin
   cc[x]:=vers[x].cost+cc[vers[x].p];
   end;
  for ch:='a' to 'z' do
   if vers[x].next[ch]<>-1 then
    begin
    en:=en+1;
    q[en]:=vers[x].next[ch];
    end;
  end;

 for i:=0 to nver do
  for j:=0 to n do
   tab[i,j]:=-1;
 tt:=dfs(0,n);

 writeln(tt);
 if tt=0 then
  begin
  for i:=1 to n do
   write('a');
  close(input);
  close(output);
  halt;
  end;
 j:=0;
 for i:=1 to n do
  begin
  write(bch[j,n-i+1]);
  j:=next[j,n-i+1];
  end;

{ writeln;
 for i:=0 to nver do
  begin
  writeln('!!!!!!!!!!!!!num=',i);
  writeln('p=',vers[i].p);
  writeln('cost=',vers[i].cost);
  writeln('par=',vers[i].par);
  writeln('lastcost=',lastcost[i]);
  writeln('cc=',cc[i]);
  end;}
 close(input);
 close(output);
end.
