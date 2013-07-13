{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
uses Math,SysUtils;
const maxl = 13;

type number = record
       n,m: extended;
     end;

var p: array[0..2,-1..100] of longint;
    sa,sb: string;
    i,q,l,m,k,kk: longint;
    possible: boolean;
    a,b: number;

procedure swap(var a,b: extended); inline;
var t: extended;
begin
	t := a; a := b; b := t;
end;

{function gcd(a,b: extended): extended; inline;
var aa: extended;
begin
	while (b <> 0) do
	begin
		aa := a;
		a := b;
		b := aa mod b;
	end;
	result := a;
end;}

procedure addl(var a: number; b: extended);
{var t: extended;}
begin
	a.n := a.n+b*a.m;
{	with a do
	begin
		t := gcd(n,m);
		n := n div t;
		m := m div t;
	end;}
end;

function add(const a,b: number): number;
{var t: extended;}
begin
	with result do
	begin
		m := a.m*b.m;
		n := a.n*b.m+b.n*a.m;
{		t := gcd(n,m);
		n := n div t;
		m := m div t;}
	end;
end;

procedure parse(s: string; r: byte);
var c,k,st,fn: byte;
begin
	s := Copy(s,2,length(s)-2);
	st := 1; fn := 1;
	c := 0;
	while (s[st] <> '(') do
	begin
		while (s[fn] in ['0'..'9']) do inc(fn);
		inc(c);
		p[r][c] := StrToInt(Copy(s,st,fn-st));
		st := fn+1; fn := st;
	end;
	inc(st); fn := st;
	k := c;
	while (s[st] <> ')') do
	begin
		while (s[fn] in ['0'..'9']) do inc(fn);
		inc(k);
		p[r][k] := StrToInt(Copy(s,st,fn-st));
		st := fn+1; fn := st;
	end;
	p[r][-1] := c;
	p[r][0] := k;
end;

function getNumber(r: byte): number;
var c,k,i,j,l: longint;
begin
	c := p[r][-1];
	k := p[r][0];
	result.n := 1;
	result.m := 1;
	j := 0; i := k;
	l := 1000 div (k-c);
	for j:=1 to l do
		for i:=k downto c+1 do
		begin
			swap(result.n,result.m);
			addl(result,p[r][i]);
		end;
	for i:=c downto 1 do
	begin
		swap(result.n,result.m);
		addl(result,p[r][i]);
	end;
end;

begin
	fillchar(p,sizeof(p),0);
	assign(input,'aplusb.in'); reset(input);
	readln(sa);
	readln(sb);
	close(input);
	parse(sa,0); parse(sb,1);
	a := getNumber(0);
	b := getNumber(1);
	a := add(a,b);
	b := a; l := 0;
	for i:=1 to maxl do
	begin
		p[2][i] := trunc(b.n/b.m);
		b.n := b.n-p[2][i]*b.m;
		swap(b.n,b.m);
		inc(l);
		if (b.m = 0) then break;
	end;
	i := 1;
	while (i <= l) do
	begin
		m := (l-i) div 2;
		for k:=1 to m do
		begin
			possible := true;
			for q:=i+1 to l do
				if (p[2][q]<>p[2][((q-i-1) mod k)+i+1]) then possible := false;
			kk := k;
			if possible then break;
		end;
		if possible then break;
		inc(i);
	end;
	assign(output,'aplusb.out'); rewrite(output);
	if (not possible) then
		writeln('Impossible') else
	begin
		write('[');
		write(p[2][1]);
		write(';');
		for q:=2 to i do write(p[2][q],',');
		write('(');
		for q:=i+1 to i+kk do
		begin
			write(p[2][q]);
			if (q <> i+kk) then write(',');
		end;
		write(')]');
	end;
	close(output);
end.
