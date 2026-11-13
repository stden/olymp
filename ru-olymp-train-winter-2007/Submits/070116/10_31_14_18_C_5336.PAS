type
 plist=^tlist;
 tlist=record 
       n:longint;
       next:plist;
       end;

var
 mas,d,q,list:array[1..50000]of longint;
 tab:array[1..50000]of plist;
 k,n,i,x,y,nlists:longint;

procedure add(x,y:longint);
var
 p:plist;
begin
 p:=new(plist);
 p^.n:=y;
 p^.next:=tab[x];
 tab[x]:=p;
end;

procedure dfs(i:longint);
var
 p:plist;
begin
 k:=k+1;
 d[i]:=k;
 q[k]:=i;
 p:=tab[i];
 while p<>nil do
  begin
  mas[i]:=mas[i]+1;
  if d[p^.n]=-1 then
   dfs(p^.n);
  p:=p^.next;
  end;
end;

begin
 assign(input,'biconn.in');
 assign(output,'biconn.out');
 reset(input);
 rewrite(output);
 read(n);
 if n=1 then
  begin
  write(0);
  close(input);
  close(output);
  halt;
  end;
 for i:=1 to n do
  begin
  tab[i]:=nil;
  mas[i]:=0;
  d[i]:=-1;
  q[i]:=-1;
  end;
 for i:=1 to n-1 do
  begin
  read(x,y);
  add(x,y);
  add(y,x);
  end;
 k:=0;
 nlists:=0;
 dfs(1);
 for i:=1 to k do
  if mas[q[i]]=1 then
   begin
   nlists:=nlists+1;
   list[nlists]:=q[i];
   end;
 writeln((nlists+1)div 2);
 for i:=1 to nlists div 2 do
  begin
  writeln(list[i],' ',list[nlists-i+1]);
  end;
 if nlists mod 2=1 then
  writeln(list[(nlists+1)div 2],' ',list[1]);
 close(input);
 close(output);
end.