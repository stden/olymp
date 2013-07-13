{$M 16000000}

type
 plist=^tlist;
 tlist=record
       n:longint;
       next:plist;
       end;
var
 tab:array[1..100000]of plist;
 rin,col,beg,en:array[1..100000]of longint;
 doans:array[1..100000]of boolean;
 tt,x,y,i,ncol,ans2,m,n:longint;

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

procedure dfs(i,c:longint);
var
 p:plist;
 count:longint;
begin
 col[i]:=c;
 p:=tab[i];
 count:=0;
 while p<>nil do
  begin
  if col[p^.n]=0 then
   begin
   dfs(p^.n,c);
   count:=count+1;
   end;
  p:=p^.next;
  end;
 if (count=0) then
  if (en[c]=0) then
   en[c]:=i
  else
   begin
   ans2:=ans2+1;
   doans[i]:=true;
   end;
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
  add(x,y);
  end;
 ncol:=0;
 ans2:=0;
 for i:=1 to n do
  if (col[i]=0)and(rin[i]=0) then
   begin
   ncol:=ncol+1;
   beg[ncol]:=i;
   dfs(i,ncol);
   end;
 tt:=ncol;
 for i:=1 to n do
  if (col[i]=0) then
   begin
   ncol:=ncol+1;
   beg[ncol]:=i;
   dfs(i,ncol);
   end;
 if (tt=0)and(ncol=1) then
  begin
  writeln(0);
  close(input);
  close(output);
  halt;
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