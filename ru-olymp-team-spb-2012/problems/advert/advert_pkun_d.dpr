
uses Math;

const MAXN = 110000;

var w,h,n,i,j:longint;
    a,b:array[1..MAXN] of longint;
    l,r,mid,curh,curw:double;


begin
  assign(input, 'advert.in');
  reset(input);
  assign(output, 'advert.out');
  rewrite(output);

  read(n, w, h);
  
  for i := 1 to n do
    read(a[i], b[i]);

  l := 0;
  r := 1e9+1;
  for i := 1 to n do
    r := min(r,w/a[i]);

  for i := 1 to 200 do
  begin
    mid := (l+r)/2;
    curh := 0;
    curw := 0;

    for j := 1 to n do
    begin
        if ((j = 1) or (b[j] <> b[j-1]) or (curw + a[j] * mid > w)) then
        begin
           curw := 0;
           curh := curh +  b[j] * mid;
        end;
        curw := curw + a[j] * mid;                                             
    end;

    if curh > h then
        r := mid
    else
        l := mid;
  end;

  writeln((l+r)/2 : 0 : 15);
end.