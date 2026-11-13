{$Q+,R+}
program sh;
const tn='aplusb';
type TDrb=record
             cnt:longint;
             d:array[0..250]of longint;
          end;
var sp,i,per,q,apl,tpos,pbeg,apbeg,bpbeg:longint;
    a,b,s,p,t:TDrb;
    st:array[1..1000]of TDrb;
    ch:char;
    pr,ws:boolean;
    c_p,a_p,b_p:extended;
    (*
procedure mul(const f:longint); {a*b=p}
begin

end;
procedure mll(const cf,f,p:longint); {b*cf=b}
begin
 if b.cnt=cf then
end;
procedure dv(const f:longint);  {t/p=s}
begin
 dv(f+1);
 inc(sp);
 st[sp]:=a;
 inc(sp);
 st[sp]:=b;
 a:=s;
 b:=t;
 mll(p[f],f+1);
 add(f+1);
 s[f]:=0;
 a:=s;
 b:=p;
 mll(t[f],f);
 add(f);
 b:=st[sp];
 dec(sp);
 a:=st[sp];
 dec(sp);
end;
procedure Dv1(const f:longint); {1/a+1/b=s}
begin
 add(f);
 mul(f);
 t:=s;
 dv(f)
end;
procedure Add(const f:longint); {a+b=s}
var i:longint;
begin
 if f=acnt then
 begin
  for i:=f to bcnt do s[i]:=b[i];
  inc(s[f],a[f]);
 end else
 if f=bcnt then
 begin
  for i:=f to acnt do s[i]:=a[i];
  inc(s[f],b[f]);
 end else
 begin
  dv1(f+1);
  inc(s[f],b[f]+a[f]);
 end;
end;  *) var j:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
  tpos:=0;
  ws:=false;
  while not eoln do
  begin
   read(ch);
   if ch in ['0'..'9'] then
   begin
    a.d[tpos]:=a.d[tpos]*10+ord(ch)-ord('0');
    ws:=true;
   end else
   begin
    if ws then begin
     inc(tpos);
     ws:=false;
    end;
    if ch='(' then
    begin
     pbeg:=tpos;
    end;
   end;
  end;
  a.cnt:=tpos-1;
  apbeg:=pbeg;
  readln;
  tpos:=0;
  pbeg:=0;
  ws:=false;
  while not eoln do
  begin
   read(ch);
   if ch in ['0'..'9'] then
   begin
    b.d[tpos]:=b.d[tpos]*10+ord(ch)-ord('0');
    ws:=true;
   end else
   begin
    if ws then begin
     inc(tpos);
     ws:=false;
    end;
    if ch='(' then
    begin
     pbeg:=tpos;
    end;
   end;
  end;
 b.cnt:=tpos-1;
 bpbeg:=pbeg;
 if apbeg<>0 then
 begin
   apl:=a.cnt-apbeg+1;
   while a.cnt<200 do
   begin
    inc(a.cnt);
    a.d[a.cnt]:=a.d[a.cnt-apl];
   end;
 end;
 if bpbeg<>0 then
 begin
   apl:=b.cnt-bpbeg+1;
   while b.cnt<200 do
   begin
    inc(b.cnt);
    b.d[b.cnt]:=b.d[b.cnt-apl];
   end;
 end;
{ add(1);}
 a_p:=a.d[a.cnt];
 for i:=a.cnt-1 downto 0 do a_p:=a.d[i]+1/a_p;
 b_p:=b.d[b.cnt];
 for i:=b.cnt-1 downto 0 do b_p:=b.d[i]+1/b_p;
 c_p:=a_p+b_p;
 s.cnt:=-1;
 while c_p>1.1 do
 begin
  inc(s.cnt);
  s.d[s.cnt]:=trunc(c_p);
  c_p:=1/(c_p-trunc(c_p));
 end;
 dec(s.cnt);
 write('[',s.d[0],';');
 for i:=1 to s.cnt do
 begin
   for per:=1 to s.cnt-i+1 do
   begin
    pr:=true;
    for q:=i+per to s.cnt do
     if s.d[q]<>s.d[q-per] then pr:=false;
    if pr then
    begin
     write('(');
     write(s.d[i]);
     for j:=1 to per-1 do write(',',s.d[i+j]);
     write(')]');
     close(output);halt(0);
    end;
   end;
   write(s.d[i]);
    if i<>s.cnt then write(',');
 end;
 writeln(']');
 close(input);close(output);
end.
