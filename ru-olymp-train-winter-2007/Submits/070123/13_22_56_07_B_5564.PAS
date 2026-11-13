type
integer=longint;
const
maxn=2000;
maxm=300000;
var
e:array[1..maxm]of record
  u,v:integer;
end;
n:integer;
i,j:integer;
marked:array[1..maxn]of boolean;
k:array[1..maxn]of integer;
fin:array[0..maxn]of integer;
t,tans:array[0..maxn]of integer;
tt:integer;
max:integer;
len:integer;
ans,xxx:integer;
p:boolean;
begin
  assign(input,'omax.in');
  assign(output,'omax.out');
  reset(input);
  rewrite(output);
  readln(n);
  if n>maxn then begin
    writeln('NO');
    close(input);
    close(output);
    halt;
  end;
  fillchar(e,sizeof(e),0);
  fin[0]:=0;
  len:=0;
  for i:=1 to n do begin
    read(k[i]);
    for j:=1 to k[i] do begin
      read(tt);
      inc(len);
      e[len].u:=i;
      e[len].v:=tt;
    end;
    fin[i]:=len;
    readln;
  end;
  ans:=0;
  xxx:=0;
  while true do begin
    fillchar(marked,sizeof(marked),0);
    p:=false;
    for i:=1 to n do begin
      inc(xxx);
      if xxx>800000 then break;
      t[i]:=e[fin[i-1]+random(k[i])+1].v;
      if marked[t[i]] then begin
        p:=true;
        break;
      end;
      marked[t[i]]:=true;
    end;
    if xxx>800000 then break;
    if p then continue;
    if ans=0 then begin
      tans:=t;
      inc(ans);
    end
    else begin
      p:=false;
      for i:=1 to maxn do begin
        if t[i]<>tans[i] then begin
          p:=true;
          break;
        end;
      end;
      if p then begin
        inc(ans);
        break;
      end;
    end;
  end;
  if ans=1 then begin
    writeln('YES');
    for i:=1 to n do write(tans[i],' ');
  end else writeln('NO');
  close(input);
  close(output);
end.