program tsbor;

type Tarray = array[0..5]of longint;
type Ttree = record
      flag:boolean;
      kol:Tarray;
      val:longint;
end;
var tree:array[1..400000]of Ttree;
    n,k,m,L,R,def,i,nbin:longint;
    s:longint;


procedure goround(v,p:longint);
var i0,j0,t:longint;
begin
 for i0:=1 to p do
  begin
    t:=tree[v].kol[k-1];
    for j0:=k-1 downto 1 do
     tree[v].kol[j0]:=tree[v].kol[j0-1];
    tree[v].kol[0]:=t;
  end;
end;

procedure push(ver:longint);
begin
  if not tree[ver].flag then exit;
  tree[ver].flag:=false;
  if ver<nbin then
                   begin
                    tree[2*ver+1].flag:=true;
                    tree[2*ver+1].val:=tree[2*ver+1].val+tree[ver].val;
                    tree[2*ver].flag:=true;
                    tree[2*ver].val:=tree[2*ver].val+tree[ver].val;
                   end;

 goround(ver,tree[ver].val mod k);
  tree[ver].val:=0;
end;

function sum(a,b:Tarray):Tarray;
var res:Tarray;
   i0:longint;
begin
 fillchar(res,sizeof(res),0);
 for i0:=0 to k do
  res[i0]:=a[i0]+b[i0];
 sum:=res;
end;


procedure add(v,L,R,a,b:longint);
var mid:longint;
begin

 PUSH(v);//!!!!
 if (b<L)or(a>R) then exit;
 if (a<=L)and(b>=R) then
                        begin
                         inc(tree[v].val);
                         tree[v].flag:=true;
                         push(v);
                         exit;
                        end;
 mid:=(L+R) div 2;
 if v<nbin then
 begin
 add(2*v,L,mid,a,b);
 add(2*v+1,mid+1,R,a,b);

 tree[v].kol:=sum(tree[v*2].kol,tree[v*2+1].kol);
 end;
end;
function getkol(a:Tarray):longint;
var i0,res:longint;
begin
 res:=0;
 for i0:=0 to k-1 do
  res:=res+a[i0]*i0;
 getkol:=res;
end;

function rsq(v,L,R,a,b:longint):longint;
var i0,mid:longint;

begin
  PUSH(v);//!!!!
 if (b<L)or(a>R) then begin rsq:=0; exit; end;
 if (L>=a)and(R<=b) then
                        begin
                         rsq:=getkol(tree[v].kol);
                         exit;
                        end;
 mid:=(L+R) div 2;
 if v<nbin then
 rsq:=rsq(2*v,L,mid,a,b)+rsq(2*v+1,mid+1,R,a,b)
           else
 rsq:=0;

end;


begin
 assign(input,'sum.in');
 reset(input);
 assign(output,'sum.out');
 rewrite(output);


 read(n,k,m);

 nbin:=1;
 while nbin<n do
  nbin:=nbin*2;
 for i:=nbin to 2*nbin do
  tree[i].kol[0]:=1;
 for i:=nbin-1 downto 1 do
  tree[i].kol[0]:=tree[2*i].kol[0]+tree[2*i+1].kol[0];
 for i:=1 to m do
  begin
   read(def,L,R);
    case def of
    1:add(1,1,nbin,L,R);
    2:begin
       s:=rsq(1,1,nbin,L,R);
       writeln(s);
      end;
   end;
  end;


 close(input);
 close(output);
end.
