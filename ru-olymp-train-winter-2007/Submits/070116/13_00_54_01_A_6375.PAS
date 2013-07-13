{$M 64000000}
{$MODE DELPHI}
{$GOTO ON}
uses windows;
type integer = longint;
var
	next1,next2:array [1..1000] of integer;
	e1,e2:array[1..1000] of integer;
	first1,first2:array[1..500] of integer;
	n1,n2,last : integer;
	ans:array[1..100000] of integer;
	permut:array[1..1000,1..500] of integer;
	u:array[1..500] of boolean;
	cop:integer;
	lp:boolean;
	ansc:integer;
	isfirst:boolean;
	start:int64;

procedure genpermut(step,k,n:integer);
var i:integer;
begin
	if (step=k+1) then begin
		for i:=1 to k do begin
			permut[cop+1,i] := permut[cop,i];
		end;
		if (cop>=1000) then exit;
		inc(cop);
		exit;
	end;
	for i:=1 to n do begin
		if (not u[i]) then begin
			u[i]:=true;
			permut[cop][step] := i;
			genpermut(step+1,k,n);
			u[i]:=false;
		end;
	end;
end;


{procedure dfs2(v,prev:integer;var num:integer);
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
			dfs2(e[p],v,count);
		  	p := next[p];
    end;
	end;
end;                      }
function dfs(v1,prev1,v2,prev2:integer):boolean;
var
	ee1,ee2:array[1..500] of integer;
	i,j,p,count1,count2:integer;
	ok:boolean;
	pe:array[1..1000,1..500] of integer;
begin
	if (gettickcount - start > 1900) then begin
		writeln('NO');
		close(input);
		close(output);
		halt(0);
	end;
	ans[v1] := v2;
	p:=first1[v1];
	count1 := 0;
	while p<>0 do begin
		if (e1[p] = prev1) then begin
			p := next1[p];
			continue;
		end;
		inc(count1);
		ee1[count1] := e1[p];
		p := next1[p];
	end;
	p:=first2[v2];
	count2 := 0;
	while p<>0 do begin
		if (e2[p] = prev2) then begin
			p := next2[p];
			continue;
		end;
		inc(count2);
		ee2[count2] := e2[p];
                    p := next2[p];
	end;
	if (count1>count2) then begin
		result:=false;
		exit;
	end;
	if ((count1=0) and (count2=0)) then begin
		result:=true;
		exit;
	end;

	fillchar(u,sizeof(u),0);
	cop := 1;
	genpermut(1,count1,count2);
	for i:=1 to cop-1 do begin
		for j:=1 to count1 do begin
			pe[i][j] := permut[i][j];
		end;
	end;
	for i:=1 to cop-1 do begin
		ok := true;
		for j:=1 to count1 do begin
			ok := ok and dfs(ee1[j],v1,ee2[pe[i][j]],v2);
		end;
		if (ok) then begin
			result:=true;
			exit;
		end;
	end;
	result := false;
end;

var
	j,i,a,b,pos1,pos2,qwerty:integer;
begin
	start := gettickcount;
	assign(input,'map.in');
	reset(input);
  assign(output,'map.out');
	rewrite(output);
	read(n1);
	pos1 := 1;
	fillchar(first1,sizeof(first1),0);
	for i:=1 to n1-1 do begin
		read(a,b);

		next1[pos1] := first1[a];
		e1[pos1] := b;
		first1[a]:=pos1;
		inc(pos1);

		next1[pos1] := first1[b];
		e1[pos1] := a;
		first1[b]:=pos1;
		inc(pos1);
	end;
	read(n2);
	pos2 := 1;
	fillchar(first2,sizeof(first2),0);
	for i:=1 to n2-1 do begin
		read(a,b);

		next2[pos2] := first2[a];
		e2[pos2] := b;
		first2[a]:=pos2;
		inc(pos2);

		next2[pos2] := first2[b];
		e2[pos2] := a;
		first2[b]:=pos2;
		inc(pos2);
	end;
{	genpermut(1,3,6);
	for i:=1 to cop-1 do begin
		for j:=1 to 3 do begin
			write(permut[i][j]);
		end;
		writeln;
	end;}
	for i:=1 to n2 do begin
		if (dfs(1,-1,i,-1)) then begin
		  writeln('YES');
		  for j:=1 to n1 do begin
				write(ans[j],' ');
		  end;
			close(input);
			close(output);
			exit;
		end;
	end;
	writeln('NO');
//	readln;
{	for i:=1 to 5000 do begin
		writeln(erroutput,gettickcount - start);
	if (gettickcount - start > 1900) then begin
		writeln('NO');
		close(input);
		close(output);
		halt(0);
	end;
	end;}
	close(input);
	close(output);
	halt(0);
end.
