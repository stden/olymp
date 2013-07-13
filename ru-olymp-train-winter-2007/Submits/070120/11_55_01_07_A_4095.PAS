type
ptree=^ttree;
ttree=record
  isword:boolean;
  beauty:longint;
  pnum:integer;
  next:ptree;
  son:array['a'..'z'] of ptree;
end;
tstring=array[1..10000]of char;
tnum=record
  x:int64;
  fromi:integer;
  fromj:integer;
  ch:char;
end;
var
prefix:array[0..10001]of record
  s:tstring;
  len:integer;
  p:ptree;
//  next:integer;
end;
s:tstring;
len:integer;
count:integer;
procedure create(var p:ptree);
var
ch:char;
begin
  p:=new(ptree
  );
  p^.isword:=false;
  for ch:='a' to 'z' do p^.son[ch]:=nil;
end;
procedure findprefixes(p:ptree);
var
ch:char;
begin
  inc(count);
  prefix[count].s:=s;
  prefix[count].p:=p;
  prefix[count].len:=len;
  p^.pnum:=count;
  for ch:='a' to 'z' do begin
    if p^.son[ch]<>nil then begin
      inc(len);
      s[len]:=ch;
      findprefixes(p^.son[ch]);
      dec(len);
    end;
  end;
end;
procedure countnext(root:ptree);
var
first,last:integer;
queue:array[1..10500]of ptree;
ch:char;
p:ptree;
begin
  first:=1;
  queue[first]:=root;
  last:=1;
  for ch:='a' to 'z' do begin
    if root^.son[ch]<>nil then begin
      inc(last);
      queue[last]:=root^.son[ch];
      root^.son[ch]^.next:=root;
//      prefix[root^.son[ch]^.pnum].next:=0;
    end;
  end;
  inc(first);
  while first<=last do begin
    for ch:='a' to 'z' do begin
      if queue[first]^.son[ch]<>nil then begin
        p:=queue[first]^.next;
        while (p<>root) and (p^.son[ch]=nil) do begin
          p:=p^.next;
        end;
        if (p^.son[ch]<>nil) then begin
           queue[first]^.son[ch]^.next:=p^.son[ch];
        end else queue[first]^.son[ch]^.next:=root;
        inc(last);
        queue[last]:=queue[first]^.son[ch];
//        prefix[queue[first]^.son[ch]^.pnum].next:=p^.pnum;
      end;
    end;
    inc(first);
  end;
end;
var
root:ptree;
p:ptree;
k:integer;
i,j:integer;
ch:char;
n:integer;
c:array[0..200,0..10500]of tnum;
t:integer;
tt:integer;
max:integer;
ii,jj:integer;
begin
  assign(input,'beauty.in');
  reset(input);
  assign(output,'beauty.out');
  rewrite(output);
  readln(k);
  create(root);
  for i:=1 to k do begin
    read(ch);
    p:=root;
    while (ch>='a') and (ch<='z') do begin
      if p^.son[ch]=nil then create(p^.son[ch]);
      p:=p^.son[ch];
      read(ch);
    end;
    readln(p^.beauty);
    p^.isword:=true;
  end;
  readln(n);
  close(input);
  s:='';
  count:=-1;
  len:=0;
  findprefixes(root);
  {
  for i:=0 to count do begin
    for j:=1 to prefix[i].len do
      write(prefix[i].s[j]);
    writeln;
  end;
  close(output);
  halt;
  }
  countnext(root);

  fillchar(c,sizeof(c)div sizeof(tnum),0);
{  for j:=1 to count do
    if prefix[j].p^.isword then c[0,j]:=prefix[j].p^.beauty;
}
  for i:=0 to n do begin
    for j:=0 to count do begin
      for ch:='a' to 'z' do begin
        p:=prefix[j].p;
        while (p<>root) and (p^.son[ch]=nil) do begin
          p:=p^.next;
        end;
        if p^.son[ch]<>nil then begin
          p:=p^.son[ch];
          tt:=c[i,j].x;
          if p^.isword then
            tt:=tt+p^.beauty;
          t:=prefix[j].len-prefix[p^.pnum].len+1;
          if (tt>c[i+t,p^.pnum].x) then begin
            c[i+t,p^.pnum].x:=tt;
            c[i+t,p^.pnum].fromj:=j;
            c[i+t,p^.pnum].fromi:=i;
            c[i+t,p^.pnum].ch:=ch;
          end;
        end;
      end;
    end;
  end;
  max:=-1;
  for j:=0 to count do begin
    if c[n-prefix[j].len,j].x>max then begin
      max:=c[n-prefix[j].len,j].x;
      ii:=n-prefix[j].len;
      jj:=j;
    end;
  end;
  writeln(max);
  if max=0 then begin
    for i:=1 to n do s[i]:='a';
  end
  else begin
    for i:=n downto 1 do begin
      s[i]:=c[ii,jj].ch;
      if s[i]=#0 then begin
        s[i]:=prefix[jj].s[i];
      end
      else begin
        t:=jj;
        jj:=c[ii,jj].fromj;
        ii:=c[ii,t].fromi;
      end;
    end;
  end;
  for i:=1 to n do write(s[i]);
  close(output);
end.
