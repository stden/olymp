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
         (32845728,1455181104,0),
         (93299616,0,0),
         (235367352,0,0),
         (540142152,0,0)
         );

procedure swap(var a,b: longint); inline; overload;
var t: byte;
begin
	t := a; a := b; b := t;
end;

procedure swap(var a,b: byte); inline; overload;
var t: byte;
begin
	t := a; a := b; b := t;
end;

function middle(a,b,c: byte): boolean; inline;
begin
	if (a > b) then swap(a,b);
	result := (c >= a) and (c <= b);
end;

function inrect(x1,y1,x2,y2: byte; x,y: byte): boolean; inline;
begin
	result := middle(x1,x2,x) and middle(y1,y2,y);
end;

function cross(x1,y1,x2,y2,x3,y3,x4,y4: byte): boolean;
begin
	result := inrect(x1,y1,x2,y2,x3,y3) or inrect(x1,y1,x2,y2,x4,y4) or inrect(x3,y3,x4,y4,x1,y1) or inrect(x3,y3,x4,y4,x2,y2);
end;

function ans_random(n,m: longint): extended;
var x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8: byte;
    ok,k,i: longint;
begin
	k := 1000000; ok := 0;
	for i:=1 to k do
	begin
		x1 := random(n);
		x2 := random(n);
		x3 := random(n);
		x4 := random(n);
		x5 := random(n);
		x6 := random(n);
		x7 := random(n);
		x8 := random(n);
		y1 := random(m);
		y2 := random(m);
		y3 := random(m);
		y4 := random(m);
		y5 := random(m);
		y6 := random(m);
		y7 := random(m);
		y8 := random(m);
		if not (cross(x1,y1,x2,y2,x3,y3,x4,y4) or cross(x1,y1,x2,y2,x5,y5,x6,y6) or cross(x1,y1,x2,y2,x7,y7,x8,y8) or
		    cross(x3,y3,x4,y4,x5,y5,x6,y6) or cross(x3,y3,x4,y4,x7,y7,x8,y8) or cross(x5,y5,x6,y6,x7,y7,x8,y8)) then
		    	inc(ok);
	end;
	result := (ok/k);
end;

var n,m: longint;
    k: int64;
    ans,r: extended;
begin
	assign(input,'heritage.in'); reset(input);
	read(n,m);
	close(input);
	if (n>m) then swap(m,n);
	k := 0; ans := 0;
	if (n<=3) and (m<=10) then
	begin
		k := c[m,n];
		r := (n+1)*(m+1);
		r := r*r; r := r*r; r := r*r;
		ans := k/r;
	end;
	assign(output,'heritage.out'); rewrite(output);
	{if (ans = 0) then }ans := ans_random(n,m);
	writeln(ans:20:9);
	close(output);
end.