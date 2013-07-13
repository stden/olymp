var i,n,m,v1,v2,kl,min:integer;
    a:array[1..30,1..30]of integer;
    r,RazrezG:array[1..30]of integer;
function KolRebr:integer;
var kol,i,j:integer;
begin
     kol:=0;
     for i:=1 to n do
         for j:=1 to n do
             if (a[i,j]=1)and(r[i]<>r[j])then inc(kol);
     KolRebr:=kol;
end;
function GoodRazrez:boolean;
var i:integer;
    kol:array[0..1]of integer;
begin
     kol[1]:=0;kol[0]:=0;
     for i:=1 to n do
         inc(kol[r[i]]);
     if kol[0]=kol[1]then GoodRazrez:=true else GoodRazrez:=false;
end;
procedure NextRazrez;
var i:integer;
begin
  i:=n;
  while r[i]=1 do begin
        r[i]:=0;dec(i);
  end;
  r[i]:=1;
end;
begin
     assign(input,'half.in');
     assign(output,'half.out');
     reset(input);
     rewrite(output);
     read(n,m);
     for i:=1 to m do begin
         read(v1,v2);
         a[v1,v2]:=1;
         a[v2,v1]:=1;
     end;
     min:=100000;
     for i:=1 to (1 shl (n-1))do begin
         if GoodRazrez then begin
                  kl:=KolRebr;
                  if kl<min then begin
                     RazrezG:=r;min:=kl;
                  end;
         end;
         NextRazrez;
     end;
     for i:=1 to n do
         if RazrezG[i]=RazrezG[1] then write(i,' ');
end.
