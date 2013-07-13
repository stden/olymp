{$M 16000000}
{$MODE DELPHI}
{$GOTO ON}
type integer = longint;

var
	next:array [1..100000] of integer;
	e:array[1..100000] of integer;
	first:array[1..50000] of integer;
	n,last : integer;
	ansa,ansb:array[1..100000] of integer;
	lp:boolean;
	ansc:integer;
	isfirst:boolean;
procedure dfs(v,prev:integer;var num:integer);
var p,count:integer;
begin
	p:=first[v];
	count := 0;
	while p<>0 do begin
		if (e[p] = prev) then begin
			p := next[p];
			continue;
		end;
                p := next[p];
		inc(count);
	end;
	if (count=0) then begin
		if (isFirst) then begin
			inc(num);
			isfirst:=false;
		end;
		if ((last = -1) or ((num mod 2 = 0) and lp)) then begin
			lp := false;
			last := v;
		end
		else begin
			lp := true;
			inc(ansc);
			ansa[ansc] := last;
			ansb[ansc] := v;

			last := v;
		end;
	end
	else begin
		p:=first[v];
		count := 0;
		while p<>0 do begin
			if (e[p] = prev) then begin
				p := next[p];
				continue;
			end;
			inc(count);
			dfs(e[p],v,count);
		  	p := next[p];
                end;
	end;
end;

var
	a,b,pos,i,qwerty:integer;
begin
	assign(input,'biconn.in');
	reset(input);
	assign(output,'biconn.out');
	rewrite(output);
	read(n);
	pos := 1;
	fillchar(first,sizeof(first),0);
	for i:=1 to n-1 do begin
		read(a,b);

		next[pos] := first[a];
		e[pos] := b;
		first[a]:=pos;
		inc(pos);

		next[pos] := first[b];
		e[pos] := a;
		first[b]:=pos;
		inc(pos);
	end;
        last := -1;
  lp:=true;
  ansc:=0;
  qwerty:=0;
	isfirst := true;
	dfs(1,-1,qwerty);
	if ((last<>-1)and(not lp))then begin
		inc(ansc);
		ansa[ansc] := last;
		ansb[ansc] := 1;
	end;
        writeln(ansc);
	for i:=1 to ansc do begin
		writeln(ansa[i],' ',ansb[i]);
	end;
	close(input);
	close(output);
end.
