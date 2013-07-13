program sh;
const tn='reverse';
var a:array[0..10001]of byte;
    b:string;
function rec(const l,r,pre,p:longint):boolean;
var sum,supza:longint;
begin
 rec:=false;
 if l>r then
 begin
  if (pre=p) then rec:=true;
  exit;
 end;
 if pre>1 then exit;
 if pre<0 then exit;
 if a[r]<p then supza:=1 else supza:=0;
 a[r]:=(a[r]+10-p) mod 10;
 if l=r then
 begin
  if a[l] mod 2=0 then rec:=true else rec:=false;
  exit;
 end;
 sum:=a[r]+pre*10;
 supza:=supza+pre;
 if sum=19 then
 begin
  if a[l]<>0 then
  begin
   rec:=false;
   exit;
  end;
  sum:=9;
  dec(supza);
 end;
 rec:=rec(l+1,r-1,pre*10+a[l]-sum,supza);
end;
var ch:char;
    l,t:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 while true do
 begin
  read(ch);
  while not (ch in ['0'..'9']) do read(ch);
  fillchar(a,sizeof(a),0);
  l:=0;
  while ch in ['0'..'9'] do
  begin
   inc(l);
   a[l]:=ord(ch)-ord('0');
   read(ch);
  end;
  if (l=1)and(a[1]=0) then break;
  t:=1;
  while a[t]=0 do inc(t);
  if rec(t,l,0,0) or rec(t+1,l,a[t],0) then writeln('YES') else writeln('NO');
 end;
 close(input);close(output);
end.
