{$R-,Q-,S-}
{$M+ 400000000}
{$MODE DELPHI}
type integer=longint;
var
	aa:array[1..100000] of integer;
	l:integer;
	d:array[-1..100000,0..3] of boolean;
	can : array[0..10000000] of byte;
function num(s:string):integer;
var res,i:integer;
begin
		res:=0;
		for i:=1 to length(s) do
			res:=res*4+(ord(s[i])-ord('a'));
		num:=res;
end;
function test(s:string):boolean;
var a,b,c,i,j,ns:integer;
tmp:string;
good:boolean;
begin           	
	result := false;
	if length(s)<2 then exit;
	result := true;
	if (s[1]<>s[2]) then exit;
	if (s[length(s)]<>s[length(s)-1]) then exit;
	for i:=1 to length(s)-3 do begin
		if (s[i]<>s[i+1]) and (s[i+2]<s[i+3]) then exit;
	end;
	result := false;
end;

var it,n,i,j:integer;
	yes:boolean;
	s:string;
	c:char;
begin
	assign(input,'bit.in');
	reset(input);
	assign(output,'bit.out');
	rewrite(output);
	readln(n);
	for it:=1 to n do begin
		readln(l);
		readln(s);
		if (test(s)) then begin
			writeln('YES');
		end
		else begin
			writeln('NO');
		end;
	end;
  close(input);
	close(output);
end.
