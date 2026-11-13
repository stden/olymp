{$H+}
const
  name : array [1..12] of string = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');  
var
  s1,s2,s3 : string;
  g,m,ch,c,min,s,t,t1,ss : int64;
  i : longint;

function koldaysg(g : longint) : int64;
begin
  if g mod 4<>0 then koldaysg:=365 else koldaysg:=366; 
end;

function koldaysm(m,g : longint) : int64;
begin
  case m of 
    1,3,5,7,8,10,12 : koldaysm:=31;
    4,6,9,11 : koldaysm:=30;
    2 : if koldaysg(g)=366 then koldaysm:=29 else koldaysm:=28;
  end;
end;

function tosec(g,m,c,ch,min,s : int64) : int64;
var
  res : int64;
  i : longint;
begin
  res:=0;
  for i:=1 to g-1 do
    res:=res+koldaysg(i);
  for i:=1 to m-1 do
    res:=res+koldaysm(i,g);
  res:=res+c-1;
  res:=res*24*60*60;
  res:=res+ch*60*60+min*60+s;
  tosec:=res;
end;

procedure data(sec : int64; var g,m,c,ch,min,s : int64);
var
  i,t : int64;
begin
  i:=0; t:=0;
  while t<=sec do
  begin
    inc(i);
    t:=t+koldaysg(i)*24*60*60;
  end; 
  g:=i;
  t:=t-koldaysg(g)*24*60*60;
  sec:=sec-t;
  i:=0; t:=0;
  while t<=sec do
  begin
    inc(i);
    t:=t+koldaysm(i,g)*24*60*60;
  end;
  m:=i;
  t:=t-koldaysm(m,g)*24*60*60;
  sec:=sec-t;
  c:=sec div (24*60*60)+1; sec:=sec mod (24*60*60);
  ch:=sec div (60*60); sec:=sec mod (60*60);
  min:=sec div (60); sec:=sec mod 60;
  s:=sec;
end;

function readt(s : string) : int64;
var
  k,t : int64;
begin
  if s[1]='-' then t:=-1 
              else t:=1;
  readt:=(ord(s[2])-ord('0'))*10+ord(s[3])-ord('0');
  readt:=readt*60*60;  
  k:=(ord(s[4])-ord('0'))*10+ord(s[5])-ord('0');
  readt:=t*(readt+k*60);  
end;
  
function getsec(s : string) : int64;
var
  i : longint;
  g,m,c,ch,min,sec : int64;
  s1 : string;
begin
  c:=(ord(s[1])-ord('0'))*10+ord(s[2])-ord('0');
  delete(s,1,3);
  s1:=copy(s,1,3);
  for i:=1 to 12 do
    if name[i]=s1 then begin m:=i; break; end;
  delete(s,1,4);
  g:=(ord(s[1])-ord('0'))*1000+(ord(s[2])-ord('0'))*100+(ord(s[3])-ord('0'))*10+ord(s[4])-ord('0');
  delete(s,1,5);
  ch:=(ord(s[1])-ord('0'))*10+ord(s[2])-ord('0');
  delete(s,1,3);   
  min:=(ord(s[1])-ord('0'))*10+ord(s[2])-ord('0');
  delete(s,1,3);   
  sec:=(ord(s[1])-ord('0'))*10+ord(s[2])-ord('0');
  getsec:=tosec(g,m,c,ch,min,sec);
end;

procedure writedata(sec : int64);
var
  g,m,c,ch,min,s : int64;
begin
  data(sec,g,m,c,ch,min,s);
  if c<10 then write(0); 
  write(c,'/');
  write(name[m],'/');
  write(g,':');
  if ch<10 then write(0); 
  write(ch,':');
  if min<10 then write(0); 
  write(min,':');
  if s<10 then write(0); 
  write(s);
end;

begin
  assign(input,'apache.in');
  reset(input);
  assign(output,'apache.out');
  rewrite(output);
  readln(s3);
  t:=readt(s3);
  while not eof do
  begin
    readln(s1);
    for i:=1 to length(s1) do
    begin
      if s1[i]=']' then
      begin
        s2:=copy(s1,i-26,26);
        t1:=readt(copy(s2,22,5));
        delete(s2,22,5);
        ss:=getsec(s2);
        write(copy(s1,1,i-27));
        writedata(ss+(t-t1));
        write(' ',s3);
        write(copy(s1,i,length(s1)-i+1));
        break;
      end;
    end; 
  end;
end.