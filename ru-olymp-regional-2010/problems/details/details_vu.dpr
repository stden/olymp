// Задача "Производство деталей"
// Региональная олимпиада 2010 года, день второй.
// Автор задачи:  Антон Ахи, akhi@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

type
	int = longint;
const
	MAXN = 100000;
	MAXM = 200000;
	MAXP = 1000000000;
var
	n, i, k, j, a : int;
	p : array [1..MAXN] of int;
	
	m : int;
	first : array [1..MAXN] of int;
	next, t : array [1..MAXM] of int;


procedure add(v, u : int);
begin
	m := m + 1;
	next[m] := first[v];
	first[v] := m;
	t[m] := u;
end;

var
	was : array [1..MAXN] of boolean;

function dfs(v : int) : int64;
var
	a : int;
begin
	result := 0;
	if (not was[v]) then begin
		result := p[v];
		was[v] := true;
		a := first[v];
		while (a > 0) do begin
			result := result + dfs(t[a]);
			a := next[a];
		end;
	end;
end;

procedure printVercises(v : int);
var
	a : int;
begin
	if (not was[v]) then begin
		was[v] := true;
		a := first[v];
		while (a > 0) do begin
			printVercises(t[a]);
			a := next[a];
		end;
		write(v, ' ');
	end;
end;

begin
	reset(input, 'details.in');
	rewrite(output, 'details.out');

	read(n);
	assert((1 <= n) and (n <= MAXN));
	
	for i := 1 to n do begin
		read(p[i]);
		assert((1 <= p[i]) and (p[i] <= MAXP));
	end;

	m := 0;
	fillchar(first, sizeof(first), 0);
	for i := 1 to n do begin
		read(k);
		for j := 1 to k do begin
			read(a);
			assert((1 <= a) and (a <= n));
			add(i, a);
		end;
	end;

	fillchar(was, sizeof(was), 0);
	write(dfs(1));
	k := 0;
	for i := 1 to n do begin
		if (was[i]) then begin
			inc(k);
		end;
	end;
	writeln(' ', k);
	fillchar(was, sizeof(was), 0);
	printVercises(1);
end.
