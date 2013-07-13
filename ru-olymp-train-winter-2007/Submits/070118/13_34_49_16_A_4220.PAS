{$M 16000000}
uses SysUtils;
const
 QS=6000000;
 s2=2.1e-5;
var
 qi,qj:longint;
 c,n,i,j,k,h,t,ps,fi,fj:longint;
 next,who,state,step,nxt:longint;
 s:longint;
 ver:extended;
 TA:array[0..14,0..14] of integer;
 B:array[0..14,0..14] of extended;
 FA:array[0..65535,0..14,0..14] of extended;
 st:array[0..QS] of longint;
 x:array[0..QS] of byte;
 q:array[0..QS] of word;
 v:array[0..1,0..65535,0..14] of extended;
 t1,t2:extended;
 ans,sv:extended;
{ u:array[0..65535,0..14] of longint;}
 ff:longint;
begin
 t1:=time;
 assign(input,'game.in');
 reset(input);
 assign(output,'game.out');
 rewrite(output);
 read(n);
 if n=1 then begin
  writeln(0);
  close(input);
  close(output);
  halt(0);
 end;
 for i:=0 to n-1 do begin
  for j:=0 to n-1 do begin
   read(TA[i,j]);
  end;
 end;
 for i:=0 to ((1 shl n) - 1) do begin
  fi:=1;
  for j:=0 to n-1 do begin
   if (i and fi)=0 then begin
    fi:=fi shl 1;
    continue;
   end;
   fj:=1;
   s:=0;
   for k:=0 to n-1 do begin
    if (k=j)or((i and fj)=0) then begin
     fj:=fj shl 1;
     continue;
    end;
    inc(s,TA[j,k]);
    fj:=fj shl 1;
   end;

   fi:=fi shl 1;

   if s=0 then continue;

   for k:=0 to n-1 do
    FA[i,j,k]:=TA[j,k]/s;

  end;
 end;
{ for i:=0 to n-1 do begin
  k:=0;
  for j:=0 to n-1 do
   if i<>j then
    k:=k+TA[i,j];

  for j:=0 to n-1 do
   if i<>j then
    A[i,j]:=TA[i,j]/k;

  A[i,i]:=0;
 end;}

 for i:=0 to n-1 do
  for j:=0 to n-1 do begin
   read(B[i,j]);
  end;
 for c:=0 to 1 do
  for qi:=0 to (1 shl n)-1 do
    for qj:=0 to n-1 do
     v[c,qi,qj] := -1;

 ff:=1;
 ff:=(ff shl 21)-1;
 ans:=0;
 ps:=0;
 sv:=0;
 h:=0;
 t:=1;
 i:=1;
 i:=i shl n;
 i:=i-1;
 Q[0]:=i;
 x[0]:=0;
 st[0]:=0;
 c:=0;
 v[c,Q[0],x[0]]:=1;
 t2:=time;

 while (h<>t)and(t2-t1 < s2{true}) do begin
  who:=x[h];
  state:=Q[h];
  step:=st[h];
  if step<>ps then begin
   ans:=ans+sv*ps;
   ps:=step;
   sv:=0;
   for qi:=0 to (1 shl n)-1 do
    for qj:=0 to n-1 do
     v[c,qi,qj] := -1;
   c:=1-c;
  end;

  ver:=v[c,state,who];

  h:=(h+1)and ff;

  if state = (1 shl (who)) then begin
   sv:=sv+ver;
   t2:=time;
   continue;
  end;

  next:=(who+1) mod n;
  while (state and (1 shl next))=0 do
   next:=(next+1)mod n;

  j:=1;
  for i:=0 to n-1 do begin
   if i=who then begin
    j:=j shl 1;
    continue;
   end;
   if (state and j)<>0 then begin
     k:=state - j;
     Q[t]:=k;
     if i<>next then
      x[t]:=next
     else begin
      nxt:=(who+1) mod n;
      while (k and (1 shl nxt))=0 do
       nxt:=(nxt+1)mod n;
      x[t]:=nxt;
     end;
     st[t]:=step+1;
     if v[1-c,Q[t],x[t]]=-1 then begin
      v[1-c,Q[t],x[t]]:=ver*FA[state,who,i]*B[who,i];
      t:=(t+1)and ff;
     end else begin
      v[1-c,Q[t],x[t]]:=v[1-c,Q[t],x[t]]+ver*FA[state,who,i]*B[who,i];
     end;

     Q[t]:=state;
     x[t]:=next;
     st[t]:=step+1;
     if v[1-c,Q[t],x[t]]=-1 then begin
      v[1-c,Q[t],x[t]]:=ver*FA[state,who,i]*(1-B[who,i]);
      t:=(t+1)and ff;
     end else begin
      v[1-c,Q[t],x[t]]:=v[1-c,Q[t],x[t]]+ver*FA[state,who,i]*(1-B[who,i]);
     end;
   end;
   j:=j shl 1;
  end;
  t2:=time;
 end;
 writeln(ans+sv*ps:0:10);
{ writeln(((trunc((ans+sv*ps)*100000))/100000):0:10);
 writeln(trunc(2.9));}
 close(input);
 close(output);
end.
