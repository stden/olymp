{$MODE DELPHI}
uses windows;
type integer = longint;
function min(a,b:int64):int64;
begin
	if (a>b) then result :=b
	else result:=a;
end;
function max(a,b:int64):int64;
begin
	if (a<b) then result :=b
	else result:=a;
end;
const
	maxx = 100;
var
	h:array[1..100000] of int64;
	c:char;
	it,p,x1,x2,x,i,n:integer;
	ans :extended;
	time:int64;
begin
	time := gettickcount;
	assign(input,'geology.in');
	reset(input);
	assign(output,'geology.out');
	rewrite(output);
	readln(n);
	for it:=1 to n do begin
		if (gettickcount-time>1900) then break;
		read(c);
		if (c='A') then begin
			read(c);read(c);
			readln(x,p);
			for i:= max(x-p,0) to min(x+p,maxx) do begin
				inc(h[i],p-abs(x-i));
			end;
		end
		else begin
			read(c);read(c);read(c);read(c);
			readln(x1,x2);
			ans := 0;
			for i:=x1 to x2-1 do begin
				ans := ans+ 2*(min(h[i],h[i+1])) + abs(h[i]-h[i+1]);
			end;
			writeln(ans/2:0:3);
		end;
	end;
	close(input);
	close(output);	
end.
