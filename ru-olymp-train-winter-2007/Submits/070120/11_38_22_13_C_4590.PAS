{$Q-;R-;S-;I-;O+}
{$mode delphi}
{$inline on}
uses SysUtils,Math;
type rleChar = record
       ch: char;
       count,ends: int64;
     end;
const maxn = 50001;

var s: array[0..maxn] of rleChar;
    pr,p: array[0..maxn] of int64;
    num,str: string;
    n,m,i: longint;
    j,k: int64;
    ch: char;

function getBlock(i: int64): longint;
var l,r,t: longint;
begin
	l := 1; r := n;
	while (l < r) do
	begin
		t := (l+r) shr 1;
		if (s[t].ends < i) then
			l := t+1 else
			r := t;
	end;
	result := r;
end;

function createBlock(ch: char; count: longint);
begin
	if (s[n].ch = ch) then
	begin
		inc(s[n].ends,count);
		inc(s[n].count,count);
	end else
	begin
		inc(n);
		s[n].ch := ch;
		s[n].ends := s[n-1].ends+count;
		s[n].count := count;
	end;
end;

function prefix(i: longint): int64;
var j,c: longint;
begin
	j := getBlock(i);
	c := i-s[j-1].ends;
	if (j = 1) then
		result := i-1 else
			if (pr[j] <> 0) then
				result := p[j-1]+min(c,s[pr[j]].count) else
				result := 0;
end;

begin
	n := 0;
	fillchar(s,sizeof(s),0);
	fillchar(pr,sizeof(pr),0);
	assign(input,'rle.in'); reset(input);
	while not seekeoln do
	begin
		num := '';
		read(ch);
		while ch in ['0'..'9'] do
		begin
			num := num + ch;
			read(ch);
		end;
		if (num <> '') then
			k := StrToInt(num) else
			k := 1;
		createBlock(ch,k);
	end;
	str := '';
	for i:=1 to n do
		str := str+s[i].ch;
	pr[1] := 0;	k := 0;
	for i:=2 to n do
	begin
		while (k > 0) and (str[i]<>str[k+1]) do k := pr[k];
		if (str[i]=str[k+1]) then inc(k);
		pr[i] := k;
	end;
	for i:=2 to n do
		if (pr[i] <> 0) then
			p[i] := p[i-1]+min(s[i].count,s[pr[i]].count) else
			p[i] := 0;
	assign(output,'rle.out'); rewrite(output);
	read(m);
	for i:=1 to m do
	begin
		read(j);
		writeln(prefix(j));
	end;
	close(output);
	close(input);
end.
