{$M 16000000}
{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 maxN = 50;
 MUL  = 97;
 HMOD = 1 shl 18;
type
 int  = longint;
 Diagram = record k:int; s:array[1..maxN]of byte; end;
var
 hk:array[0..HMOD-1]of Diagram;
 hv:array[0..HMOD-1]of int64;
 a:Diagram;
 n,i,j:int;

function equals(const a,b:Diagram):boolean;
var i:int;
begin
 if (a.k<>b.k) then begin equals:=false; exit; end;
 for i:=1 to a.k do
  if (a.s[i]<>b.s[i]) then begin
   equals:=false; exit;
  end;
 equals:=true;
end;

function hash(const a:Diagram):int;
var res,i:int;
begin
 res:=0;
 for i:=1 to a.k do
  res := (MUL * res + a.s[i]) and (HMOD-1);
 hash:=res;
end;

procedure put(const a:Diagram;val:int64);
var h:int;
begin
 h:=hash(a);
 while (hk[h].k<>0) do
  h := (h+1) and (HMOD-1);
 hk[h]:=a;
 hv[h]:=val;
end;

function get(const a:Diagram):int64;
var h:int;
begin
 h:=hash(a);
 while (hk[h].k<>0)and(not equals(hk[h],a)) do
  h := (h+1) and (HMOD-1);
 if (hk[h].k=0)
  then get:=-1
  else get:=hv[h];
end;

procedure dfs(const a:Diagram);
var
 b:Diagram;
 i:int;
 res,cur:int64;
begin
 if (a.k=1)and(a.s[1]=1) then begin
  put(a,1);
  exit;
 end;
 res:=0;
 for i:=1 to a.k do if (i=a.k)or(a.s[i]>a.s[i+1]) then begin
  b:=a;
  dec(b.s[i]);
  if (b.s[b.k]=0) then dec(b.k);
  if (get(b)=-1)
   then dfs(b);
  res := res + get(b);
 end;
 put(a, res);
end;

Begin
 assign(input,'young.in');
 reset(input);
 assign(output,'young.out');
 rewrite(output);
 read(a.k);
 for i:=1 to a.k do
  read(a.s[i]);
 for i:=0 to HMOD-1 do
  hk[i].k:=0;
 fillchar(hv,sizeof(hv),0);
 dfs(a);
 writeln(get(a));
 close(output);
End.
