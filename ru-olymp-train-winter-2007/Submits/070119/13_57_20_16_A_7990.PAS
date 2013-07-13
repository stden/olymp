{$M 16000000}
uses binsearch;
const MaxS = 10000;
var
 n:longint;
 si,sj:array[0..MaxS] of longint;


function mq(i:longint):boolean;
begin
 if i<1 then
  mq:=false
 else if i>n then
  mq:=true
 else mq:=query(i);
end;

procedure truesearch(i,j:longint);
var
 m:longint;
begin
 if i=j then begin
  answer(i);
  exit;
 end;
 m:=(i+j)div 2;
 if query(m) then
  truesearch(i,m)
 else
  truesearch(m+1,j);
end;


procedure bs(i,j,tt,p:longint);
var
 l:longint;
begin
 if i=j then begin
  if (p=0) then begin
   if mq(i) then begin
    if not(mq(i-1)) then begin
     answer(i);
     exit;
    end else begin
     if mq(i-1) then begin
      truesearch(si[tt-1],i-1);
     end else begin
      answer(i);
      exit;
     end;
    end;
   end else begin
    if mq(i) then begin
     answer(i);
     exit;
    end else begin
     l:=tt-1;
     while(((si[l]+sj[l]) div 2)<>i) do dec(l);
     truesearch(i+1,sj[l]);
    end;
   end;
  end else begin
   if mq(i-1) then begin
    if mq(i-1) then begin
     l:=tt-1;
     while(((si[l]+sj[l]) div 2)<>(i-1)) do dec(l);
     truesearch(si[l],i-1);
    end else begin
     answer(i);
     exit;
    end;
   end else begin
    if mq(i) then begin
     answer(i);
     exit;
    end else begin
     if mq(i) then begin
      answer(i);
      exit;
     end else begin
      answer(i+1);
      exit;
     end;
    end;
   end;
  end;
  exit;
 end;
 si[tt]:=i;
 sj[tt]:=j;

 if mq((i+j) div 2) then begin
  bs(i, (i+j) div 2, tt+1, 1);
 end else begin
  bs(((i+j) div 2)+1, j, tt+1, 0);
 end;
end;


begin
 n:=getn;
 bs(1,n+1,0,0);
end.
