{$H+}
type integer=int64;
var n,left,right:integer;
    i:longint;
    l,sum:array[1..15,1..2]of int64;
function min(a,b:integer):integer;
begin
     if a>b then min:=b else min:=a;
end;
function max(a,b:integer):integer;
begin
     if a<b then max:=b else max:=a;
end;
function find(n,fl,ll,rr,left,right:integer):integer;
var summ:integer;
begin
     summ:=0;find:=0;
     if left>right then exit;
     if (left=ll)and(right=rr)then summ:=sum[n,fl]else
     if n=1 then summ:=fl else begin
        if left<=ll+l[n-1,1]-1 then summ:=summ+find(n-1,1,ll,ll+l[n-1,1]-1,left,min(right,ll+l[n-1,1]-1));
        if left<=ll+2*l[n-1,1]-1 then summ:=summ+find(n-1,1,ll+l[n-1,1],ll+2*l[n-1,1]-1,max(left,ll+l[n-1,1]),min(right,ll+2*l[n-1,1]-1));
        if left<=ll+2*l[n-1,1]+l[n-1,2]-1 then
           summ:=summ+find(n-1,2,ll+2*l[n-1,1],ll+2*l[n-1,1]+l[n-1,2]-1,max(left,ll+2*l[n-1,1]),min(right,ll+2*l[n-1,1]+l[n-1,2]-1));
        if left<=ll+3*l[n-1,1]+l[n-1,2]-1 then
           summ:=summ+find(n-1,1,ll+2*l[n-1,1]+l[n-1,2],ll+3*l[n-1,1]+l[n-1,2]-1,max(left,ll+2*l[n-1,1]+l[n-1,2]),min(right,ll+3*l[n-1,1]+l[n-1,2]-1));
        if left<=ll+3*l[n-1,1]+2*l[n-1,2]-1 then
           summ:=summ+find(n-1,2,ll+3*l[n-1,1]+l[n-1,2],ll+3*l[n-1,1]+2*l[n-1,2]-1,max(left,ll+3*l[n-1,1]+l[n-1,2]),min(right,ll+3*l[n-1,1]+2*l[n-1,2]-1));
        if (left<=ll+4*l[n-1,1]+2*l[n-1,2]-1)and(fl=2) then
           summ:=summ+find(n-1,1,ll+3*l[n-1,1]+2*l[n-1,2],ll+4*l[n-1,1]+2*l[n-1,2]-1,max(left,ll+3*l[n-1,1]+2*l[n-1,2]),min(right,ll+4*l[n-1,1]+2*l[n-1,2]-1));
        if (left<=ll+4*l[n-1,1]+3*l[n-1,2]-1)and(fl=2) then
           summ:=summ+find(n-1,2,ll+4*l[n-1,1]+2*l[n-1,2],ll+4*l[n-1,1]+3*l[n-1,2]-1,max(left,ll+4*l[n-1,1]+2*l[n-1,2]),min(right,ll+4*l[n-1,1]+3*l[n-1,2]-1));
     end;
     find:=summ;
end;
begin
     assign(input,'digitsum.in');
     assign(output,'digitsum.out');
     reset(input);
     rewrite(output);
     l[1,1]:=1;l[1,2]:=1;
     sum[1,1]:=1;sum[1,2]:=2;
     for i:=2 to 13 do begin
         l[i,1]:=3*l[i-1,1]+2*l[i-1,2];
         l[i,2]:=4*l[i-1,1]+3*l[i-1,2];
         sum[i,1]:=3*sum[i-1,1]+2*sum[i-1,2];
         sum[i,2]:=4*sum[i-1,1]+3*sum[i-1,2];
  //       writeln(i,' : ',l[i,1],' ',l[i,2]);
  //       writeln(i,' : ',sum[i,1],' ',sum[i,2]);
     end;
     read(n);
     for i:=1 to n do begin
         read(left,right);
         writeln(find(13,1,1,l[13,1],left,right));
     end;
end.
