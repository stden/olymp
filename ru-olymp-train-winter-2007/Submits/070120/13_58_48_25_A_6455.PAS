program sh;
const tn='beauty';
type TNode=record
              p:array['a'..'z']of longint;
              mm:array['a'..'z']of byte;
              suf:longint;
              c:longint;
              s,sn:array[1..100]of char;
              acc,nacc,nu,no:longint;

            end;
var l,c:array[1..10001]of longint;
    s:array[1..10000,1..101]of char;
    nd:array[1..10001]of TNode;
var n,i,k,ndc,tk:longint;
    ch:char;
procedure Add(const tt:longint);
var i,t,suck:longint;
begin
 t:=1;
 for i:=1 to l[tt] do
 begin
  if nd[t].p[s[tt,i]]=0 then
  begin
   inc(ndc);
   suck:=ndc;
   nd[t].p[s[tt,i]]:=suck;
  end;
  nd[t].mm[s[tt,i]]:=1;
  t:=nd[t].p[s[tt,i]];
 end;
 nd[t].c:=c[tt];
end;
procedure clclin;
var oc:array[1..2,1..10001] of longint;
    cc:array[1..10001] of char;
    ur,uw:longint;
begin
 oc[1,1]:=1;
 oc[2,1]:=1;
 ur:=1;
 uw:=2;
 while (ur<uw) do
 begin
  if oc[2,ur]=1 then nd[oc[1,ur]].suf:=1 else
  begin
   nd[oc[1,ur]].suf:=nd[oc[2,ur]].suf;
   while (nd[oc[1,ur]].suf>1)and(nd[nd[oc[1,ur]].suf].p[cc[ur]]=0) do
    nd[oc[1,ur]].suf:=nd[nd[oc[1,ur]].suf].suf;
   if nd[nd[oc[1,ur]].suf].p[cc[ur]]<>0 then nd[oc[1,ur]].suf:=nd[nd[oc[1,ur]].suf].p[cc[ur]];
  end;
  for ch:='a' to 'z' do
   if nd[oc[1,ur]].p[ch]<>0 then
   begin
    oc[1,uw]:=nd[oc[1,ur]].p[ch];
    oc[2,uw]:=oc[1,ur];
    cc[uw]:=ch;
    inc(uw);
   end;
  inc(ur);
 end;
end;
procedure clcsuck;
var oc:array[1..10001] of longint;
    ur,uw:longint;
begin
 oc[1]:=1;
 ur:=1;
 uw:=2;
 while (ur<uw) do
 begin
  nd[oc[ur]].c:=nd[oc[ur]].c+nd[nd[oc[ur]].suf].c;
  for ch:='a' to 'z' do
   if nd[oc[ur]].p[ch]<>0 then
   begin
    oc[uw]:=nd[oc[ur]].p[ch];
    inc(uw);
   end else
   begin
    nd[oc[ur]].p[ch]:=nd[oc[ur]].suf;
    while (nd[oc[ur]].p[ch]>1)and(nd[nd[oc[ur]].p[ch]].p[ch]=0) do nd[oc[ur]].p[ch]:=nd[nd[oc[ur]].p[ch]].suf;
    if nd[nd[oc[ur]].p[ch]].p[ch]<>0 then
    begin
     nd[oc[ur]].p[ch]:=nd[nd[oc[ur]].p[ch]].p[ch];
    end;
   end;
  inc(ur);
 end;
end;
procedure clcnew;
var oc:array[1..10001] of longint;
    cc,uz,ur,uw:longint;
    was,suck:boolean;
begin
 oc[1]:=1;
 ur:=1;
 uw:=2;
 while (ur<uw) do
 begin
  nd[oc[ur]].c:=nd[oc[ur]].c+nd[nd[oc[ur]].suf].c;
  for ch:='a' to 'z' do
  begin
   if nd[oc[ur]].mm[ch]<>0 then
   begin
    oc[uw]:=nd[oc[ur]].p[ch];
    inc(uw);
   end;
   if nd[oc[ur]].acc<>1 then continue;
   uz:=nd[oc[ur]].p[ch];
   cc:=nd[oc[ur]].nu+nd[uz].c;
   if (cc>nd[uz].no)or (nd[uz].nacc<>1) then
   begin
    nd[uz].no:=cc;
    nd[uz].sn:=nd[oc[ur]].s;
    nd[uz].sn[tk]:=ch;
    nd[uz].nacc:=1;
   end else
   if (cc=nd[uz].no) then
   begin
    was:=false;
    suck:=false;
    for i:=1 to tk-1 do
     if was then nd[uz].sn[i]:=nd[oc[ur]].s[i] else
     if ord(nd[uz].sn[i])>ord(nd[oc[ur]].s[i]) then
     begin
      nd[uz].sn[i]:=nd[oc[ur]].s[i];
      was:=true;
     end else
     if ord(nd[uz].sn[i])<ord(nd[oc[ur]].s[i]) then
     begin
      suck:=true;
      break;
     end;
    if not suck then
    begin
     if was then
     begin
      nd[uz].sn[tk]:=ch;
     end else
     begin
      if ord(ch)<ord(nd[uz].sn[tk]) then nd[uz].sn[tk]:=ch;
     end;
    end;
   end;
  end;
  inc(ur);
 end;
end;
procedure sfcf;
var oc:array[1..10001] of longint;
    cc,uz,ur,uw:longint;

begin
 oc[1]:=1;
 ur:=1;
 uw:=2;
 while (ur<uw) do
 begin
  nd[oc[ur]].c:=nd[oc[ur]].c+nd[nd[oc[ur]].suf].c;
  if nd[oc[ur]].nacc=1 then
  begin
   nd[oc[ur]].acc:=1;
   nd[oc[ur]].nu:=nd[oc[ur]].no;
   nd[oc[ur]].s:=nd[oc[ur]].sn;
  end else nd[oc[ur]].acc:=0;
  fillchar(nd[oc[ur]].sn,sizeof(nd[oc[ur]].sn),0);
  nd[oc[ur]].nacc:=0;
  nd[oc[ur]].no:=0;
  for ch:='a' to 'z' do
  begin
   if nd[oc[ur]].mm[ch]<>0 then
   begin
    oc[uw]:=nd[oc[ur]].p[ch];
    inc(uw);
   end;
  end;
  inc(ur);
 end;
end;
var bst:longint;

procedure findrs;
var was,suck:boolean;
    oc:array[1..10001] of longint;
    ur,uw:longint;
begin
 oc[1]:=1;
 ur:=1;
 uw:=2;
 while (ur<uw) do
 begin
  nd[oc[ur]].c:=nd[oc[ur]].c+nd[nd[oc[ur]].suf].c;
  for ch:='a' to 'z' do
  begin
   if nd[oc[ur]].mm[ch]<>0 then
   begin
    oc[uw]:=nd[oc[ur]].p[ch];
    inc(uw);
   end;
   if nd[oc[ur]].acc<>1 then continue;
   if bst<nd[oc[ur]].nu then
   begin
    bst:=nd[oc[ur]].nu;
    nd[1].s:=nd[oc[ur]].s;
   end;
   if bst=nd[oc[ur]].nu then
   begin
    was:=false;
    suck:=false;
    for i:=1 to k do
     if was then nd[1].s[i]:=nd[oc[ur]].s[i] else
     if ord(nd[1].s[i])>ord(nd[oc[ur]].s[i]) then
     begin
      nd[1].s[i]:=nd[oc[ur]].s[i];
      was:=true;
     end else
     if ord(nd[1].s[i])<ord(nd[oc[ur]].s[i]) then
     begin
      suck:=true;
      break;
     end;
   end;
  end;
  inc(ur);
 end;
end;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 for i:=1 to n do
 begin
  read(ch);
  l[i]:=0;
  while (ch in ['a'..'z']) do
  begin
   if l[i]<=100 then inc(l[i]);
   s[i,l[i]]:=ch;
   read(ch);
  end;
  readln(c[i]);
 end;
 readln(k);
 ndc:=1;
 for i:=1 to n do
 begin
  Add(i);
 end;
 ClcLin;
 ClcSuck;
 nd[1].acc:=1;
 for tk:=1 to k do
 begin
  ClcNew;
  SfCf;
 end;
 bst:=-maxlongint;
 findrs;
 writeln(bst);
 for i:=1 to tk do write(nd[1].s[i]);
 close(input);close(output);
end.
