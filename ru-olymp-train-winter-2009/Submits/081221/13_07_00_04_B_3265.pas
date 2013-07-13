{$H+}

program treef;

uses treeunit,Math;

var b,e,head:array[1..200000] of longint;
    i,j,n,kcur,List,em:longint;
    u:array[1..200000]of boolean;
    next:array[1..400000]of longint;
    h:array[1..200000] of longint;
    ucur:array[1..200000]of boolean;
    def:longint;
    endvertex:longint;
    reb:array[1..200000]of boolean;
procedure dfs(i:longint);
var v:longint;
begin

  ucur[i]:=TRUE;
  v:=head[i];
  while v<>0 do
   begin
    if (h[e[v]]=0)and(not ucur[e[v]])
       and(not u[e[v]]) then
                           begin
                            if v<=n-1 then reb[v+n-1]:=true
                                     else reb[v-n+1]:=true;
                            dfs(e[v]);
                           end;
    if (not reb[v])and(not u[e[v]]) then h[i]:=max(h[i],h[e[v]]+1);
    v:=next[v];
   end;

  h[i]:=max(h[i],1);

end;

function getlist:longint;
var i0,v,sc:longint;
begin

  for i0:=1 to n do
  if not u[i0] then
   begin
     sc:=0;
     v:=head[i0];
    while v<>0 do
      begin
       if not u[e[v]] then
                           inc(sc);
       v:=next[v];
      end;
    if sc=1 then
                 begin
                  getlist:=i0;
                  exit;
                 end;
   end;

end;

function findmid(v:longint):longint;
var i0:longint;
begin

  for i0:=1 to 2*n-2 do
   begin
   if (h[b[i0]]=h[v] div 2) and
       (h[e[i0]]>h[b[i0]]) then
     begin
       findmid:=i0;
       break;
     end;
   end

end;

procedure destroy(v:longint);
var i0:longint;
begin

  u[v]:=true;

  i0:=head[v];
  while i0<>0 do
  begin
   if (i0=em)or(i0=em+n-1) then begin i0:=next[i0]; continue; end;
   if not u[e[i0]] then
                        destroy(e[i0]);
   i0:=next[i0];
  end;

end;


function UNDEADS:boolean;
var i0,k:longint;
begin

 undeads:=true;
 k:=0;
 for i0:=1 to n do
  if not u[i0] then
   begin
    inc(k);
    endvertex:=i0;
   end;
 if k=1 then
  undeads:=false;


end;


begin

 init;
 n:=getn;
 fillchar(u,sizeof(u),0);
 fillchar(next,sizeof(next),0);
 fillchar(head,sizeof(head),0);
 for i:=1 to n-1 do
  begin
   b[i]:=geta(i);
   e[i]:=getb(i);
   e[n+i-1]:=b[i];
   b[n+i-1]:=e[i];
   next[i]:=head[b[i]];
   head[b[i]]:=i;
   next[n+i-1]:=head[b[n+i-1]];
   head[b[n+i-1]]:=n+i-1;
  end;

  while UNDEADS do
   begin

    fillchar(h,sizeof(h),0);
    fillchar(ucur,sizeof(ucur),0);
    fillchar(reb,sizeof(reb),false);
     List:=getlist;
    dfs(list);
    em:=findmid(list);
    if em>(n-1) then
                     em:=em-n+1;
    def:=query(em);

    if def=0 then
                  destroy(e[em])
             else
                  destroy(b[em]);

   end;
   report(endvertex);

end.
