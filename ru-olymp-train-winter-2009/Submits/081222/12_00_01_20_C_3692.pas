type
  long = array [0..300] of longint;
var
  s : string;
  a,k,k1,ot,s1,s2,p,p1 : long;
  i,sum : longint;

function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
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

function umn(a : long; k : longint) : long;
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
  umn:=c;
end;

function plus1(a : long; k : longint) : long;
var
  i : longint;
  c : long;
begin
  c[0]:=a[0];
  for i:=1 to a[0] do
  begin
    c[i]:=(a[i]+k) mod 10;
    k:=(a[i]+k) div 10; 
  end; 
  if k<>0 then begin inc(c[0]); c[c[0]]:=k; end;
  plus1:=c;
end;

function minus1(a : long; k : longint) : long;
var
  i : longint;
  c : long;
begin
  c[0]:=a[0];
  for i:=1 to a[0] do
  begin
    if k=1 then
      if a[i]=0 then c[i]:=9 
                else begin c[i]:=a[i]-1; k:=0; end
    
            else c[i]:=a[i]; 
  end;
  while c[c[0]]=0 do dec(c[0]);
  minus1:=c;
end;

function longsum(a,b : long) : long;
var
  i,p : longint;
  c : long;
begin
  p:=0;
  c[0]:=max(a[0],b[0]);

  for i:=a[0]+1 to 300 do a[i]:=0;
  for i:=b[0]+1 to 300 do b[i]:=0;

  for i:=1 to c[0] do
  begin
    c[i]:=(a[i]+b[i]+p) mod 10;
    p:=(a[i]+b[i]+p) div 10; 
  end; 
  if p<>0 then begin inc(c[0]); c[c[0]]:=p; end;
  longsum:=c;
end;

function longumn(a,b : long) : long;
var
  i,j : longint;
  c : long;
begin
  c[0]:=a[0]+b[0]+1;

  for i:=a[0]+1 to 300 do a[i]:=0;
  for i:=b[0]+1 to 300 do b[i]:=0;
  for i:=1 to 300 do c[i]:=0;

  for i:=1 to a[0] do
    for j:=1 to b[0] do
    begin
      c[i+j-1]:=c[i+j-1]+a[i]*b[j];
      c[i+j]:=c[i+j]+c[i+j-1] div 10;
      c[i+j-1]:=c[i+j-1] mod 10;
    end; 
  while c[c[0]]=0 do dec(c[0]);
  longumn:=c;
end;


function longdel(a : long; d : longint) : long;
var
  i,t : longint;
  c : long;
begin
  t:=0;
  c[0]:=0;
  for i:=1 to a[0]+1 do
  begin
    if t>=d then
    begin
      inc(c[0]);
      c[c[0]]:=t div d; 
      t:=t mod d;
      t:=t*10+a[i];
    end
           else
    begin
      inc(c[0]);
      c[c[0]]:=0;
      t:=t*10+a[i];
    end;  
  end; 
  reverse(c);
  while c[c[0]]=0 do
    dec(c[0]);
  reverse(c);
  longdel:=c;
end;

begin
  assign(input,'room.in');
  reset(input);
  assign(output,'room.out');
  rewrite(output);
  readln(s);
  if s='1' then begin writeln(1); halt; end;
  if s='2' then begin writeln(2); halt; end;
  a[0]:=length(s);
  sum:=0;
  for i:=1 to length(s) do
  begin
    a[a[0]-i+1]:=ord(s[i])-ord('0');
    sum:=sum+a[a[0]-i+1];  
  end;

  if sum mod 3=0 then
  begin
    reverse(a);
    k:=longdel(a,3);
    reverse(a);
    reverse(k);  
    k:=umn(k,2);

    k1:=plus1(k,1);
    s1:=longumn(k,k1);
    reverse(s1);
    s1:=longdel(s1,2);
    reverse(s1);
    reverse(k); p:=longdel(k,2);  reverse(k); reverse(p);
    s2:=longumn(k,p);
    reverse(s2); s2:=longdel(s2,2); reverse(s2);
    ot:=longsum(s1,s2);
  end
                 else
  begin
    reverse(a);
    k:=longdel(a,3);
    reverse(a);
    reverse(k);  
    k:=umn(k,2);
    k:=plus1(k,1);
    
    if sum mod 3=1 then
    begin
      k1:=plus1(k,1);
      s1:=longumn(k,k1);
      reverse(s1);
      s1:=longdel(s1,2);
      reverse(s1);
      
      p1:=minus1(k,1);
      reverse(p1); p:=longdel(p1,2);  reverse(p1); reverse(p);
      s2:=longumn(p1,p);
      reverse(s2); s2:=longdel(s2,2); reverse(s2);
      ot:=longsum(s1,s2);
    end; 
    if sum mod 3=2 then
    begin
      k1:=plus1(k,1);
      s1:=longumn(k,k1);
      reverse(s1);
      s1:=longdel(s1,2);
      reverse(s1);
      
      p1:=plus1(k,1);
      reverse(p1); p:=longdel(p1,2);  reverse(p1); reverse(p);
      s2:=longumn(p1,p);
      reverse(s2); s2:=longdel(s2,2); reverse(s2);
      ot:=longsum(s1,s2);
    end; 

  end;

  for i:=1 to ot[0] do
    write(ot[ot[0]-i+1]);
  writeln;
  close(output);
end.