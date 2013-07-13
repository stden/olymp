uses treeunit;
var
  i,n,a3,a2,tr,fl1,kd,t1,t2,kind : longint;
  a,a1 : array [-10..200010,-10..16] of longint;
  gfl,fl,flr,ind,st : array [-10..200010] of longint;

procedure dfs(v : longint);
var
  i : longint;
begin
  fl[v]:=1;
  for i:=1 to a[v,0] do
  begin
    if (v=t1) and (a[v,i]=t2) then continue; 
    if gfl[a[v,i]]=1 then continue;
    if fl[a[v,i]]=0 then dfs(a[v,i]);
  end;
end;

begin
{  assign(input,'input.txt');
  reset(input);
}  init();
  n:=getN();
  for i:=1 to n do
  begin
    a[i,0]:=0;
    st[i]:=0;
  end;
  for i:=1 to n-1 do
  begin
    a3:=getA(i);
    a2:=getB(i);
    inc(a[a3,0]);
    a[a3,a[a3,0]]:=a2; 
    inc(a[a2,0]);
    a[a2,a[a2,0]]:=a3; 
    flr[i]:=0; 

    inc(st[a3]); inc(st[a2]);
    a1[i,1]:=a3; a1[i,2]:=a2;
  end;
  for i:=1 to n do
    gfl[i]:=0;
  kd:=0;

  randomize;

  while true do
  begin
    tr:=-1;
    kind:=0;
    for i:=1 to n-1 do
      if flr[i]=0 then begin tr:=1; inc(kind); ind[kind]:=i; end;
    if tr=-1 then break;
    tr:=ind[random(kind)+1];
    fl1:=query(tr);
    flr[tr]:=1; 
    for i:=1 to n do
      fl[i]:=0;
    t1:=a1[tr,1]; t2:=a1[tr,2];
    dfs(t1);  
    if fl1=0 then
    begin
      for i:=1 to n-1 do
        if (fl[a1[i,1]]=0) and (fl[a1[i,2]]=0) then flr[i]:=1;
      for i:=1 to n do
        if fl[i]=0 then begin gfl[i]:=1; inc(kd); end;
    end
            else
    begin
      for i:=1 to n-1 do
        if (fl[a1[i,1]]=1) and (fl[a1[i,2]]=1) then flr[i]:=1;
      for i:=1 to n do
        if fl[i]=1 then begin gfl[i]:=1; inc(kd); end;
    end;  
  end;
  for i:=1 to n do
    if gfl[i]=0 then begin report(i); break; end;
end.