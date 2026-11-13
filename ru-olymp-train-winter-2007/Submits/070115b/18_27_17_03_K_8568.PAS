{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 maxN = 100000;
type
 int  = longint;
 TRec = record x:int;kon:boolean; end;
var
 h:array[1..maxN]of TRec;
 n,hs,i,res,x,k:int;

procedure swap(i,j:int);
var t:TRec;
begin
 t:=h[i]; h[i]:=h[j]; h[j]:=t;
end;

function less(const a,b:TRec):boolean;
begin
 less := (a.x<b.x) OR ((a.x=b.x)and(b.kon));
end;

procedure siftdown(i:int);
var j:int;
begin
 while (2*i <= hs) do begin
  if (less(h[i],h[2*i])) then j:=2*i else j:=i;
  if (2*i+1<=hs)and(less(h[j],h[2*i+1])) then j:=2*i+1;
  if (i=j) then break;
  swap(i,j);
  i:=j;
 end;
end;

Begin
 assign(input, 'segments.in');
 reset(input);
 assign(output,'segments.out');
 rewrite(output);
 read(n);
 n:=2*n;
 for i:=1 to n do begin
  read(x);
  h[i].x:=x; h[i].kon:=(not odd(i));
 end;
 //sort
 hs:=n;
 for i:=(n div 2) downto 1 do
  siftdown(i);
 while (hs>1) do begin
  swap(1,hs);
  dec(hs);
  siftdown(1);
 end;
 //res
 res:=0; k:=0;
 for i:=1 to n do begin
  if (not h[i].kon) then inc(k)
  else begin
   if (res<k) then begin
    x:=h[i].x;
    res:=k;
   end;
   dec(k);
  end;
 end;
 writeln(res,' ',x);
 close(output);
End.
