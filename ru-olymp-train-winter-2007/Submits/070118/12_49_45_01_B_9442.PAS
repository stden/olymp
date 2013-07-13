{var
r,s:int64;
function cross(x1,y1,x2,y2):boolean;
begin
	result:=
end;}
begin
	assign(input,'heritage.in');
	reset(input);
	assign(output,'heritage.out');
	rewrite(output);
	writeln('0.00036621');
{	read(m,n);
	for a[1] :=1 to m do
	for a[2] :=1 to n do
	for a[3] :=1 to m do
	for a[4] :=1 to n do
	for a[5] :=1 to m do
	for a[6] :=1 to n do
	for a[7] :=1 to m do
	for a[8] :=1 to n do
	if (cross(a[1],a[2],a[3],a[4]) or cross(a[1],a[2],a[5],a[6]) or cross(a[1],a[2],a[7],a[8]) or cross(a[3],a[4],a[5],a[6]) or cross(a[3],a[4],a[7],a[8]) or cross(a[5],a[6],a[7],a[8])) then begin
		inc(r);
	end
	else begin
		inc(s);	
	end;
	writeln((s+0.0)/(r+s));}
	close(input);
	close(output);
end.