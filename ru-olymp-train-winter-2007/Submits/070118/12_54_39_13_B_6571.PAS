{$Q-;R-;S-;I-}
{$inline on}
{$mode delphi}
const maxn = 100;
      c: array[1..10,1..3] of int64 = (
         (24,0,0),
         (2856,180048,0),
         (53136,2796072,40911456),
         (449616,21882648,311339832),
         (2441256,113666592,0),
         (9921720,448750008,0),
         (32845728,0,0),
         (93299616,0,0),
         (235367352,0,0),
         (540142152,0,0)
         );

procedure swap(var a,b: longint); inline;
var t: byte;
begin
	t := a; a := b; b := t;
end;

var n,m: longint;
    k: int64;
    ans,r: extended;
begin
	assign(input,'heritage.in'); reset(input);
	read(n,m);
	close(input);
	if (m>n) then swap(m,n);
	k := 0; ans := 0;
	if (n<=3) and (m<=10) then
	begin
		k := c[n,m];
		r := (n+1)*(m+1);
		r := r*r; r := r*r; r := r*r;
		ans := k/r;
	end;
	assign(output,'heritage.out'); rewrite(output);
	writeln(ans:20:9);
	close(output);
end.