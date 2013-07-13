{$H+,R+,S+,Q+}
type
  long = array [0..101] of integer;
var
  i,k,j,i1,i11,i2 : integer;
  s1,s2 : string;
  a,b,c,t,d : long;
  ot : array [1..500] of string;

procedure sub(a,b : long);
var
  i,p : integer;
begin
  p:=0;
  c[0]:=a[0];
  for i:=1 to c[0] do
  begin  
    c[i]:=a[i]-b[i]-p;
    if c[i]<0 then begin c[i]:=c[i]+10; p:=1; end else p:=0; 
  end;
  while (c[c[0]]=0) and (c[0]>1) do
    dec(c[0]);
end;

function bigger(a,b : long) : boolean;
var
  i : integer;
begin
  bigger:=true;
  if b[0]>a[0] then bigger:=false;
  if a[0]=b[0] then
  begin
    for i:=1 to a[0] do
      if b[i]>a[i] then begin bigger:=false; break; end
                   else if a[i]>b[i] then break; 
  end;
end;

procedure reverse(var a : long);
var
  i : longint;
  p : long;
begin
  p[0]:=a[0];
  for i:=1 to a[0] do
    p[a[0]-i+1]:=a[i];
  a:=p;
end;

procedure umn(a : long; k : longint; var s : string);
var
  i,p : longint;
  c : long;
begin
  p:=0;
  c[0]:=a[0];
  for i:=1 to a[0] do
  begin
    c[i]:=(a[i]*k+p) mod 10;
    p:=(a[i]*k+p) div 10; 
  end; 
  if p<>0 then begin inc(c[0]); c[c[0]]:=p; end;
  s:='';
  for i:=c[0] downto 1 do
    s:=s+chr(ord('0')+c[i]);
end;

function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
end;

function min(a,b : longint) : longint;
begin
  if a<b then min:=a else min:=b;
end;

begin
  assign(input,'division.in');
  reset(input);
  assign(output,'division.out');
  rewrite(output);
  for i:=1 to 101 do
  begin
    a[i]:=0;
    b[i]:=0; 
  end;
  readln(s1);
  a[0]:=length(s1);
  for i:=1 to length(s1) do
    a[i]:=ord(s1[i])-ord('0');
  readln(s2);
  b[0]:=length(s2);
  for i:=1 to length(s2) do
    b[i]:=ord(s2[i])-ord('0');
  k:=1;
  t[0]:=0; d[0]:=0;

  if not bigger(a,b) then
  begin
    writeln(s1,' |',s2);
    for i:=1 to a[0]+1 do
      write(' '); 
    write('+');
    for i:=1 to b[0] do
      write('-');
    writeln;
    for i:=1 to a[0]+1 do
      write(' '); 
    writeln('|0');
    halt;  
  end; 

  ot[1]:=s1+' '+'|'+s2;
  for i:=1 to a[0]+1 do
  begin
    if bigger(t,b) then
    begin
      if k<>1 then
      begin
        inc(k);
        ot[k]:='';
        for j:=1 to i-t[0]-1 do ot[k]:=ot[k]+' ';
        for j:=1 to t[0] do
          ot[k]:=ot[k]+chr(ord('0')+t[j]);
      end;
      inc(d[0]);
      while bigger(t,b) do
      begin
        reverse(b);
        reverse(t);
        sub(t,b);
        t:=c;     
        reverse(b);
        reverse(t);
        inc(d[d[0]]);
      end;   
      inc(k);
      reverse(b);
      umn(b,d[d[0]],ot[k]);
      reverse(b);
      for j:=1 to i-length(ot[k])-1 do
        ot[k]:=' '+ot[k];
      inc(k);
      for j:=1 to 20 do
        ot[k]:=ot[k]+'-';      
    end else begin inc(d[0]); d[d[0]]:=0; end;
    if i<>a[0]+1 then
    begin
      if not((t[0]=1) and (t[1]=0)) then inc(t[0]); 
      t[t[0]]:=a[i];
    end; 
  end; 
  inc(k);
  ot[k]:='';
  for i:=1 to a[0]-t[0] do
    ot[k]:=ot[k]+' ';
  for i:=1 to t[0] do
    ot[k]:=ot[k]+chr(ord('0')+t[i]);
  for i:=1 to k do
    if ot[i][1]='-' then
    begin
      ot[i]:='';
      for j:=1 to length(ot[i-1]) do
        if ot[i-1][j]<>' ' then begin i1:=j; break; end;
      for j:=1 to length(ot[i-2]) do
        if ot[i-2][j]<>' ' then begin i11:=j; break; end;
      i2:=length(ot[i+1]);
      for j:=1 to min(i1,i11)-1 do
        ot[i]:=ot[i]+' ';
      for j:=min(i1,i11) to i2 do
        ot[i]:=ot[i]+'-';
    end;
  for i:=1 to a[0]-length(ot[2])+1 do
    ot[2]:=ot[2]+' ';
  ot[2]:=ot[2]+'+';

  for i:=1 to a[0]-length(ot[3])+1 do
    ot[3]:=ot[3]+' ';
  ot[3]:=ot[3]+'|';

  reverse(d);
  while (d[d[0]]=0) and (d[0]>1) do
    dec(d[0]);
  reverse(d);

  for i:=1 to d[0] do
    ot[3]:=ot[3]+chr(ord('0')+d[i]);;

  for i:=length(ot[2])+1 to max(length(ot[3]),length(ot[1])) do
    ot[2]:=ot[2]+'-';
  for i:=1 to k do
    writeln(ot[i]);
  close(output);
end.