{$M 16000000}

type
 plist=^tlist;
 tlist=record
       n:longint;
       next:plist;
       end;
var
 tab2,tab:array[1..100000]of plist;
 d,rin,col,beg,en:array[1..100000]of longint;
 q,doans:array[1..100000]of boolean;
 k,j,tt,x,y,i,ncol,ans2,m,n:longint;
 fl:boolean;
 p:plist;

procedure add(x,y:longint);
var
 p:plist;
begin
 rin[y]:=rin[y]+1;
 p:=new(plist);
 p^.next:=tab[x];
 p^.n:=y;
 tab[x]:=p;
end;

procedure add2(x,y:longint);
var
 p:plist;
begin
 p:=new(plist);
 p^.next:=tab2[x];
 p^.n:=y;
 tab2[x]:=p;
end;

function isroad(a,b:longint):boolean;
var
 p:plist;
begin
 p:=tab[a];
 while p<>nil do
  begin
  if p^.n=b then
   begin
   isroad:=true;
   exit;
   end;
  p:=p^.next;
  end;
 isroad:=false;
end;

procedure dfs(i,c:longint);
var
 p:plist;
 countall,count:longint;
begin
 col[i]:=c;
 p:=tab[i];
 count:=0;
 countall:=0;
 while p<>nil do
  begin
  if col[p^.n]=0 then
   begin
   dfs(p^.n,c);
   count:=count+1;
   end;
  if q[p^.n] then
   countall:=countall+1;
  p:=p^.next;
  end;
 if (count=0) then
  if (en[c]=0)or(isroad(en[c],beg[c])) then
   en[c]:=i
  else
   if (countall=0) then
    begin
    ans2:=ans2+1;
    doans[i]:=true;
    end;
 q[i]:=true;
end;

procedure sfd2(i:longint);
var
 p:plist;
begin
 q[i]:=true;
 p:=tab2[i];
 while p<>nil do
  begin
  if not(q[p^.n]) then
   sfd2(p^.n);
  p:=p^.next;
  end;
end;

procedure sfd(i:longint);
var
 p:plist;
begin
 q[i]:=true;
 p:=tab[i];
 while p<>nil do
  begin
  if not(q[p^.n]) then
   sfd(p^.n);
  p:=p^.next;
  end;
 k:=k+1;
 d[k]:=i;
end;

begin
 assign(input,'republic.in');
 assign(output,'republic.out');
 reset(input);
 rewrite(output);
 read(n,m);
 for i:=1 to n do
  begin
  col[i]:=0;
  beg[i]:=0;
  en[i]:=0;
  doans[i]:=false;
  rin[i]:=0;
  end;
 for i:=1 to m do
  begin
  read(x,y);
  if x<>y then
   begin
   add(x,y);
   add2(y,x);
   end;
  end;
 k:=0;
 for i:=1 to n do
  q[i]:=false;
 for i:=1 to n do
  if not(q[i]) then
   sfd(i);
 for i:=1 to n do
  q[i]:=false;
 sfd2(d[1]);
 fl:=true;
 for i:=1 to n do
  fl:=fl and q[i];
 if fl then
  begin
  writeln(0);
  close(input);
  close(output);
  halt;
  end;
 ncol:=0;
 ans2:=0;
 for i:=1 to n do
  q[i]:=false;
 for i:=1 to n do
  if (col[d[i]]=0)and(rin[d[i]]=0) then
   begin
   ncol:=ncol+1;
   beg[ncol]:=d[i];
   dfs(d[i],ncol);
   end;
 tt:=ncol;
 for i:=n downto 1 do
  if (col[d[i]]=0) then
   begin
   ncol:=ncol+1;
   beg[ncol]:=d[i];
   dfs(d[i],ncol);
   end;
 writeln(ans2+ncol);
 for i:=1 to ncol do
  begin
  writeln(en[i],' ',beg[i mod ncol+1]);
  end;
 for i:=1 to n do
  if doans[i] then
   writeln(i,' ',beg[col[i]]);
 close(input);
 close(output);
end.
