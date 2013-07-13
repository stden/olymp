{$M 16000000}
{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
uses
 SysUtils;
const
 maxN = 50;
 MUL  = 97;
 HMOD = 1 shl 18;
 maxL = 10;
 BASE = 10000;
type
 int  = longint;
 TLong = array[0..maxL]of int;
 Diagram = record k:int; s:array[1..maxN]of shortint; end;
var
 hk:array[0..HMOD-1]of Diagram;
 hv:array[0..HMOD-1]of TLong;
 a:Diagram;
 n,i,j:int;

procedure writeLong(const a:TLong);
var
 i,k:int;
 s:string;
begin
 k:=length(IntToStr(BASE-1));
 write(a[a[0]]);
 for i:=a[0]-1 downto 1 do begin
  s:=IntToStr(a[i]);
  while (length(s)<k) do s:='0'+s;
  write(s);
 end;
 writeln;
end;

procedure add(var a:TLong;const b:TLong);
begin
 for i:=a[0]+1 to b[0]+2 do a[i]:=0;
 for i:=1 to b[0] do a[i]:=a[i]+b[i];
 if (a[0]<b[0]) then a[0]:=b[0];
 for i:=1 to a[0] do
  if (a[i]>=BASE) then begin
   inc(a[i+1],a[i] div BASE);
   a[i]:=a[i] mod BASE;
  end;
 if (a[a[0]+1]>0) then inc(a[0]);
end;

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

procedure put(const a:Diagram;const val:TLong);
var h:int;
begin
 h:=hash(a);
 while (hk[h].k<>0) do
  h := (h+1) and (HMOD-1);
 hk[h]:=a;
 hv[h]:=val;
end;

function get(const a:Diagram):TLong;
var h:int;
begin
 h:=hash(a);
 while (hk[h].k<>0)and(not equals(hk[h],a)) do
  h := (h+1) and (HMOD-1);
 if (hk[h].k=0)
  then get[0]:=-1
  else get:=hv[h];
end;

procedure dfs(const a:Diagram);
var
 b:Diagram;
 i:int;
 res,cur:TLong;
begin
 if (a.k=1)and(a.s[1]=1) then begin
  res[0]:=1; res[1]:=1;
  put(a,res);
  exit;
 end;
 res[0]:=1; res[1]:=0;
 for i:=1 to a.k do if (i=a.k)or(a.s[i]>a.s[i+1]) then begin
  b:=a;
  dec(b.s[i]);
  if (b.s[b.k]=0) then dec(b.k);
  cur:=get(b);
  if (cur[0]=-1) then dfs(b);
  cur:=get(b);
  add(res,get(b));
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
 writeLong(get(a));
 close(output);
End.
