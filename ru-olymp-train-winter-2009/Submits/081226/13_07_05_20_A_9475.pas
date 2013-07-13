var
  i,t,l,r : longint;
  k1,k2,sum,c : array [1..17] of int64;
  k11,k21,sum1,c1 : array [1..17] of int64;

function getsum(p : longint) : int64; forward;

function getsum1(p,il : longint) : int64;
var
  i,t : longint;
begin
  if (p=0) then begin getsum1:=0; exit; end;
  if (p=1) then begin getsum1:=1; exit; end;
  if (p=2) and (il=3) then begin getsum1:=3; exit; end;
  if (p=2) and (il<>3) then begin getsum1:=2; exit; end;
  if (p=3) then begin getsum1:=4; exit; end;
  if (p=4) then begin getsum1:=5; exit; end;
  if (p=5) then begin getsum1:=7; exit; end;
  i:=il-1;
  if p<=c[i-1] then
  begin
    getsum1:=getsum(p);
    exit;
  end; 
  if p<=2*c[i-1] then
  begin
    getsum1:=sum[i-1]+getsum(p-c[i-1]);
    exit;
  end; 
  getsum1:=2*sum[i-1]+getsum1(p-2*c[i-1],i);
end;

function getsum(p : longint) : int64;
var
  i,t : longint;
begin
  if p=0 then begin getsum:=0; exit; end;
  if p=1 then begin getsum:=1; exit; end;
  if p=2 then begin getsum:=2; exit; end;
  if p=3 then begin getsum:=4; exit; end;
  if p=4 then begin getsum:=5; exit; end;
  if p=5 then begin getsum:=7; exit; end;
  for i:=1 to 17 do
    if c[i]>=p then begin t:=i; break; end;
  i:=t;
  if p<=2*c[i-1] then
  begin
    getsum:=sum[i-1]+getsum(p-c[i-1]);
    exit;
  end; 
  if p<=3*c[i-1]+c1[i-1] then
  begin
    if p<=3*c[i-1] then getsum:=2*sum[i-1]+getsum(p-2*c[i-1])
                   else getsum:=3*sum[i-1]+getsum1(p-3*c[i-1],i);
    exit;
  end;  
  if p<=4*c[i-1]+c1[i-1] then
  begin
    getsum:=3*sum[i-1]+sum1[i-1]+getsum(p-3*c[i-1]-c1[i-1]);
    exit;
  end;  
  if p<=5*c[i-1]+5*c1[i-1] then
  begin
    if p<=5*c[i-1]+c1[i-1] then getsum:=4*sum[i-1]+sum1[i-1]+getsum(p-4*c[i-1]-c1[i-1])
                           else getsum:=5*sum[i-1]+sum1[i-1]+getsum1(p-5*c[i-1]-c1[i-1],i);
    exit;
  end;  
end;
 
begin
  assign(input,'digitsum.in');
  reset(input);
  assign(output,'digitsum.out');
  rewrite(output);
  k1[1]:=1; k2[1]:=0;
  sum[1]:=1; c[1]:=1;
  for i:=2 to 17 do
  begin
    k1[i]:=k1[i-1]*3+k2[i-1]*4;
    k2[i]:=k1[i-1]*2+k2[i-1]*3;
    sum[i]:=k1[i]+k2[i]*2;
    c[i]:=k1[i]+k2[i];
  end;  

  k11[2]:=1; k21[2]:=1;
  sum1[2]:=3; c1[2]:=2;
  for i:=3 to 17 do
  begin
    k11[i]:=k11[i-1]*3+k21[i-1]*4;
    k21[i]:=k11[i-1]*2+k21[i-1]*3;
    sum1[i]:=k11[i]+k21[i]*2;
    c1[i]:=k11[i]+k21[i];
  end;  

  read(t);
  for i:=1 to t do
  begin
    read(l,r);
    writeln(getsum(r)-getsum(l-1));
  end;
end.