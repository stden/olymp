{$H+}

const maxq=5000;

type
 longint=integer;
 PList=^TList;
 Tlist= record
  v:integer;
  next:PList;
 end;



var
 St,En:array[0..4001] of PList;
 p,time,b,x,h,t,len,n,l,c,i,j,v,k:integer;
 s:string;
 Q:array[1..maxq] of integer;
 f,pa,PAth:array[0..4001] of integer;

procedure Add(v,u:integer);
var
 p:PList;
begin
 if St[v]=nil then begin
  new(St[v]);
  St[v]^.v:=u;
  St[v]^.next:=nil;
  En[v]:=St[v];
 end else begin
  new(p);
  p^.v:=u;
  p^.next:=nil;
  En[v]^.next:=p;
  En[v]:=p;
 end;
end;


procedure Push(x:integer);
begin
 inc(len);
 t:=t mod maxq + 1;
 Q[t]:=x;
end;

function pop:integer;
begin
 dec(len);
 pop:=Q[h];
 h:=h mod maxq + 1;
end;

function GetInt(c:char):integer;
var
 p:integer;
begin
 if c in ['0'..'9'] then p:=ord(c)-ord('0');
 if c in ['A'..'Z'] then p:=ord(c)-ord('A')+10;
 if c in ['a'..'z'] then p:=ord(c)-ord('a')+36;
 if c='!' then p:=62;
 if c='?' then p:=63;
 GetInt:=p;
end;

procedure AddBin(x:integer);
var
 i:integer;
begin
 for i:=1 to 6 do begin
  Push(x and 1);
  x:=x shr 1;
 end;
end;

procedure PrintPath(x,y:integer);
var i:Integer;
begin
 inc(len);
 path[len]:=x;
 if x<>y then
  PrintPath(pa[x],y)
 else begin
  for i:=len downto 1 do
   write(path[i],' ');
 end;
end;

function Search(b,v:integer):boolean;
var
 p:PList;
begin
 inc(time);
 f[v]:=time;
 Search:=false;
 p:=St[v];
 while p<>nil do begin
  if (f[p^.v]>0) and (f[v]-f[p^.v]+1=b) then begin
   len:=0;
   PrintPath(v,p^.v);
   Search:=true;
   exit;
  end;
  if (f[p^.v]=0) then begin
   pa[p^.v]:=v;
   if Search(b,p^.v) then begin
    Search:=true;
    exit;
   end;
  end;
  p:=p^.next;
 end;
 f[v]:=0;
 dec(time);
end;

begin
 assign(input,'tourism.in'); reset(input);
 assign(output,'tourism.out'); rewrite(output);
 h:=1;
 t:=0;
 len:=0;
 readln(n);
 readln(s);
 l:=length(s);
 v:=0;
 for i:=1 to l do begin
  p:=GetInt(S[i]);
  AddBin(p);
  while len>n-v-1 do begin
   for j:=v+1 to n-1 do begin
    x:=pop;
    if x=1 then Add(v,j) else Add(j,v);
   end;
   inc(v);
   if v>n then break;
  end;
  if v>n then break;
 end;

 readln(k);
 for i:=1 to k do begin
  time:=0;
  fillchar(f,sizeof(f),0);
  read(b);
  if not Search(b,0) then write('-1');
  writeln;
 end;

 close(output);
end.
