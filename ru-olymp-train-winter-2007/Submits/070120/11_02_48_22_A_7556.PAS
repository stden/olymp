{$Mode Delphi}
const inf=1000000000000000000;
var b:array[0..10000,'a'..'z']  of integer;
    bonus:array[1..10000] of int64;
    pref:array[0..10000] of integer;
    och:array[1..10000] of integer;
    q:array[0..100,1..10000] of int64;
    f:array[0..100,1..10000] of boolean;
    p:array[0..100,1..10000] of integer;
    per:array[0..100,1..10000] of char;
    vos:array[0..100,1..10000] of int64;
    res:string;
    maxi,u,n,i,j,k:integer;
    max:int64;
    c:char;
procedure add(const s:string;k:integer);
var nw,i:integer;
begin
  nw:=1;
  for i:=1 to length(s) do begin
    if b[nw,s[i]]<>0 then
      nw:=b[nw,s[i]]
    else begin
      inc(u);
      b[nw,s[i]]:=u;
      nw:=u;
    end;
  end;
  bonus[u]:=bonus[u]+k;
end;

procedure buildpref;
var w,r,t:integer;
    c:char;
begin
  r:=0;
  w:=1;
  och[w]:=1;
  for c:='a' to 'z' do
  b[0,c]:=1;

  while r<w do begin
    inc(r);
    for c:='a' to 'z' do
      if b[och[r],c]<>0 then begin
         t:=pref[och[r]];
         while b[t,c]=0 do
           t:=pref[t];
         pref[b[och[r],c]]:=b[t,c];
         inc(bonus[b[och[r],c]],bonus[t]);
         inc(w);
         och[w]:=b[och[r],c];
      end;
    for c:='a' to 'z' do
    if b[och[r],c]=0 then
    b[och[r],c]:=b[pref[och[r]],c];
  end;
end;




var s:string;
    ch:char;
    m:integer;
begin
  u:=1;
  assign(input,'beauty.in');
  assign(output,'beauty.out');
  reset(input);
  rewrite(output);
  readln(m);
  res:='';
  for i:=1 to m do begin
      s:='';
     while true do begin
       read(ch);
       if not (ch in ['a'..'z']) then  break;
       s:=s+ch;
     end;
     readln(k);
     add(s,k);
  end;
  readln(n);
  buildpref;
  for i:=0 to n do
  for j:=1 to u do
  q[i,j]:=-inf;
  q[0,1]:=0;
  for i:=0 to n-1 do
    for j:=1 to u do
       if q[i,j]>=0 then
       for c:='a' to 'z' do
         if (b[j,c]<>0)  then begin
            if q[i+1,b[j,c]]<q[i,j]+bonus[b[j,c]] then begin
              q[i+1,b[j,c]]:=q[i,j]+bonus[b[j,c]];
            end;
         end;
  max:=0;
  for i:=1 to u do
    if max<q[n,i]  then
      max:=q[n,i];
  for i:=1 to u do
    if q[n,i]=max then f[n,i]:=true;
  for i:=n-1 downto 0 do begin
     for j:=1 to u do
       for c:='a' to 'z' do
         if (b[j,c]<>0) then
           if f[i+1,b[j,c]] and (q[i+1,b[j,c]]=q[i,j]+bonus[b[j,c]]) then begin
             f[i,j]:=true;
             per[i,j]:=c;
             p[i,j]:=b[j,c];
             break;
           end;

  end;
  writeln(max);
  j:=1;
  for i:=0 to n-1 do begin
    write(per[i,j]);
    j:=p[i,j];
  end;
  close(input);
  close(output);
end.
