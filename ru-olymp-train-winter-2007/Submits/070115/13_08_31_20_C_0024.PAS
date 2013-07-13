{$H+}
{$M 16000000}
const sumall=byte('a')+byte('b')+byte('c');
var i,n:longint;
    q:string;

function gen(l,r,lc,rc:longint):boolean;
var oc:char;
begin
  gen:=false;
  if l>r then
  begin
    gen:=true;
    exit;
  end;
  if lc=rc then
    exit;
  if q[l]<>q[l+1] then
  begin
    if lc=l then
      if gen(l+2,r,lc+2,rc) then
      begin
        gen:=true;
        exit;
      end
      else
      begin
        oc:=q[l+1];
        q[l+1]:=char(sumall-byte(q[l])-byte(q[l+1]));
        if gen(l+1,r,lc+1,r) then
        begin
          gen:=true;
          exit;
        end;
        q[l+1]:=oc;
      end;
    if (lc<l) then
      if (q[l-1]=q[l])or(q[l-1]=q[l+1]) then
        if gen(l+1,r,l+1,rc) then
        begin
          gen:=true;
          exit;
        end;
  end
  else
  if q[r]<>q[r-1] then
  begin
    if rc=r then
      if gen(l,r-2,lc,rc-2) then
      begin
        gen:=true;
        exit;
      end
      else
      begin
        oc:=q[r-1];
        q[r-1]:=char(sumall-byte(q[r])-byte(q[r-1]));
        if gen(l,r-1,lc,r-1) then
        begin
          gen:=true;
          exit;
        end;
        q[r-1]:=oc;
      end;
    if rc>r then
      if (q[r+1]=q[r])or(q[r+1]=q[r-1]) then
        if gen(l,r-1,lc,r-1) then
        begin
          gen:=true;
          exit;
        end;
  end;
end;

begin
  assign(input,'bit.in');
  reset(input);
  assign(output,'bit.out');
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    readln(n);
    readln(q);
    if gen(1,n,1,n) then
      writeln('YES')
    else
      writeln('NO');
  end;
  close(input);
  close(output);
end.